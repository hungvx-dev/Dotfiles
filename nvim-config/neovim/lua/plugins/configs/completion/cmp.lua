local M = {}
local fmt = string.format
M.methods = {}

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
M.methods.has_words_before = has_words_before

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end,
}

local source_mapping = {
  -- cmp_tabnine = hvim.icons.Cmp.Tabnine .. "Tabnine",
  nvim_lsp = hvim.icons.Cmp.Lsp .. "LSP",
  buffer = hvim.icons.Cmp.Buffer .. "Buffer",
  luasnip = hvim.icons.Cmp.Snippet .. "Snippet",
  path = hvim.icons.Cmp.Path .. "Path",
  treesitter = hvim.icons.Cmp.Tree,
  spell = hvim.icons.Cmp.Spellcheck .. "Spell",
}

local function jumpable(dir)
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    return false
  end

  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  ---sets the current buffer's luasnip to the one nearest the cursor
  ---@return boolean true if a node is found, false otherwise
  local function seek_luasnip_cursor_node()
    -- TODO(kylo252): upstream this
    -- for outdated versions of luasnip
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local exit_node = snippet.insert_nodes[0]

    local pos = win_get_cursor(0)
    pos[1] = pos[1] - 1

    -- exit early if we're past the exit node
    if exit_node then
      local exit_pos_end = exit_node.mark:pos_end()
      if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    node = snippet.inner_first:jump_into(1, true)
    while node ~= nil and node.next ~= nil and node ~= snippet do
      local n_next = node.next
      local next_pos = n_next and n_next.mark:pos_begin()
      local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
        or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

      -- Past unmarked exit node, exit early
      if n_next == nil or n_next == snippet.next then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end

      if candidate then
        luasnip.session.current_nodes[get_current_buf()] = node
        return true
      end

      local ok
      ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
      if not ok then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    -- No candidate, but have an exit node
    if exit_node then
      -- to jump to the exit node, seek to snippet
      luasnip.session.current_nodes[get_current_buf()] = snippet
      return true
    end

    -- No exit node, exit from snippet
    snippet:remove_from_jumplist()
    luasnip.session.current_nodes[get_current_buf()] = nil
    return false
  end

  if dir == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
end

M.methods.jumpable = jumpable

M.config = function()
  local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
  if not status_cmp_ok then
    return
  end
  local ConfirmBehavior = cmp_types.ConfirmBehavior

  local cmp = require("utils.modules").require_on_index "cmp"
  local luasnip = require("utils.modules").require_on_index "luasnip"
  local cmp_window = require "cmp.config.window"
  local cmp_mapping = require "cmp.config.mapping"

  hvim.builtin.cmp = {
    on_config_done = nil,
    active = true,
    enabled = function()
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      if buftype == "prompt" then
        return false
      end
      return hvim.builtin.cmp.active
    end,
    confirm_opts = {
      behavior = ConfirmBehavior.Replace,
      select = false,
    },
    completion = {
      ---@usage The minimum length of a word to complete on.
      keyword_length = 1,
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      max_width = 0,
      kind_icons = hvim.icons.Kind,
      source_names = source_mapping,
      duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      },
      duplicates_default = 0,
      format = function(entry, vim_item)
        local max_width = hvim.builtin.cmp.formatting.max_width
        if max_width ~= 0 and #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. hvim.icons.UI.Ellipsis
        end
        if hvim.use_icons then
          vim_item.kind = fmt("%s %s", hvim.builtin.cmp.formatting.kind_icons[vim_item.kind], vim_item.kind)
          -- vim_item.kind = hvim.builtin.cmp.formatting.kind_icons[vim_item.kind]
        end
        vim_item.menu = hvim.builtin.cmp.formatting.source_names[entry.source.name]
        vim_item.dup = hvim.builtin.cmp.formatting.duplicates[entry.source.name]
          or hvim.builtin.cmp.formatting.duplicates_default
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp_window.bordered {
        winhighlight = "FloatBorder:Pmenu",
      },
      documentation = cmp_window.bordered {
        winhighlight = "FloatBorder:Pmenu",
      },
    },
    sources = {
      {
        name = "nvim_lsp",
        priority = 9,
        entry_filter = function(entry, ctx)
          local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
          if kind == "Text" then
            return false
          end
          return true
        end,
      },
      { name = "path", priority = 4 },
      { name = "luasnip", priority = 9 },
      -- { name = "cmp_tabnine", priority = 8, max_num_results = 3 },
      -- { name = "nvim_lua", priority = 5 },
      {
        name = "spell",
        priority = 7,
        max_item_count = 3,
        option = {
          enable_in_context = function()
            return require("cmp.config.context").in_treesitter_capture "spell"
          end,
        },
      },
      { name = "buffer", priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
    },
    mapping = cmp_mapping.preset.insert {
      ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
      ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
      ["<C-d>"] = cmp_mapping.scroll_docs(-4),
      ["<C-u>"] = cmp_mapping.scroll_docs(4),
      ["<C-y>"] = cmp_mapping {
        i = cmp_mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
      },
      -- ["<Tab>"] = cmp_mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expand_or_locally_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif jumpable(1) then
      --     luasnip.jump(1)
      --   elseif has_words_before() then
      --     -- cmp.complete()
      --     fallback()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      -- ["<S-Tab>"] = cmp_mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      ["<C-e>"] = cmp_mapping.abort(),
      ["<C-Space>"] = cmp_mapping.complete(),
      ["<CR>"] = cmp_mapping(function(fallback)
        if cmp.visible() then
          local confirm_opts = vim.deepcopy(hvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
          local is_insert_mode = function()
            return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
          end
          if is_insert_mode() then -- prevent overwriting brackets
            confirm_opts.behavior = ConfirmBehavior.Insert
          end
          if cmp.confirm(confirm_opts) then
            return -- success, exit early
          end
        end
        fallback() -- if not exited early, always fallback
      end),
    },
    cmdline = {
      enable = true,
      options = {
        {
          type = ":",
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
        },
        {
          type = { "/", "?" },
          sources = {
            { name = "buffer" },
          },
        },
      },
    },
  }
end

M.config()

function M.setup()
  local cmp = require "cmp"
  cmp.setup(hvim.builtin.cmp)

  if hvim.builtin.cmp.cmdline.enable then
    for _, option in ipairs(hvim.builtin.cmp.cmdline.options) do
      cmp.setup.cmdline(option.type, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = option.sources,
      })
    end
  end

  if hvim.builtin.cmp.on_config_done then
    hvim.builtin.cmp.on_config_done(cmp)
  end
end

return M
