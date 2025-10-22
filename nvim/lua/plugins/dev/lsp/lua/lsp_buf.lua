local api = vim.api
local lsp = vim.lsp
local util = vim.lsp.util
local validate = vim.validate
local M = {}

local function jump_to_location(item, win, reuse_win)
  local b = item.bufnr or vim.fn.bufadd(item.filename)
  vim.cmd("normal! m'")

  vim.bo[b].buflisted = true
  local w = win
  if reuse_win then
    w = vim.fn.win_findbuf(b)[1] or w
    if w ~= win then
      api.nvim_set_current_win(w)
    end
  end
  api.nvim_win_set_buf(w, b)
  api.nvim_win_set_cursor(w, { item.lnum, item.col - 1 })
  vim.cmd("normal! zv")
end

---@param method string
---@param opts? { reuse_win: boolean, on_list: function }
function M.get_locations(method, opts)
  opts = opts or {}
  local bufnr = api.nvim_get_current_buf()
  local win = api.nvim_get_current_win()

  local clients = lsp.get_clients({ method = method, bufnr = bufnr })
  if not next(clients) then
    vim.notify(lsp._unsupported_method(method), vim.log.levels.WARN)
    return
  end

  local from = vim.fn.getpos(".")
  from[1] = bufnr
  local tagname = vim.fn.expand("<cword>")

  lsp.buf_request_all(bufnr, method, function(client)
    return util.make_position_params(win, client.offset_encoding)
  end, function(results)
    ---@type vim.quickfix.entry[]
    local all_items = {}

    for client_id, res in pairs(results) do
      local client = assert(lsp.get_client_by_id(client_id))
      local locations = {}
      if res then
        locations = vim.islist(res.result) and res.result or { res.result }
      end
      local items = util.locations_to_items(locations, client.offset_encoding)
      vim.list_extend(all_items, items)
    end

    if vim.tbl_isempty(all_items) then
      vim.notify("No locations found", vim.log.levels.INFO)
      return
    end

    local title = "LSP locations"
    if #all_items == 1 then
      vim.fn.settagstack(vim.fn.win_getid(win), { items = { { tagname = tagname, from = from } } }, "t")
      jump_to_location(all_items[1], win, opts.reuse_win)
      return
    end

    if opts.on_list then
      assert(vim.is_callable(opts.on_list), "on_list is not a function")
      opts.on_list()
      return
    end

    vim.fn.setqflist({}, " ", { title = title, items = all_items })
    vim.cmd("botright copen")
  end)
end

function M.references(opts)
  validate("opts", opts, "table", true)

  local bufnr = api.nvim_get_current_buf()
  local win = api.nvim_get_current_win()
  opts = opts or {}

  lsp.buf_request_all(bufnr, "textDocument/references", function(client)
    local params = util.make_position_params(win, client.offset_encoding)
    ---@diagnostic disable-next-line: inject-field
    params.context = { includeDeclaration = true }
    return params
  end, function(results)
    local all_items = {}
    local title = "References"

    for client_id, res in pairs(results) do
      local client = assert(lsp.get_client_by_id(client_id))
      local items = util.locations_to_items(res.result or {}, client.offset_encoding)
      vim.list_extend(all_items, items)
    end

    if not next(all_items) then
      vim.notify("No references found")
    else
      if #all_items == 2 then
        local curr_line = vim.api.nvim_win_get_cursor(win)[1]
        local uri = vim.uri_from_bufnr(bufnr)
        all_items = vim.tbl_filter(function(l)
          return not (curr_line == l.lnum and l.user_data and l.user_data.uri == uri)
        end, all_items)
      end

      if #all_items == 1 then
        jump_to_location(all_items[1], win, opts.reuse_win)
        return
      end

      if opts.on_list then
        return opts.on_list(all_items)
      end

      vim.fn.setloclist(0, {}, " ", { title = title, items = all_items })
      vim.cmd.lopen()
    end
  end)
end

--- Jumps to the declaration of the symbol under the cursor.
--- @note Many servers do not implement this method. Generally, see |vim.lsp.buf.definition()| instead.
---@param opts? { reuse_win: boolean, on_list: function }
function M.declaration(opts)
  validate("opts", opts, "table", true)
  M.get_locations("textDocument/declaration", opts)
end

--- Jumps to the definition of the symbol under the cursor.
---@param opts? { reuse_win: boolean, on_list: function }
function M.definition(opts)
  validate("opts", opts, "table", true)
  M.get_locations("textDocument/definition", opts)
end

--- Jumps to the definition of the type of the symbol under the cursor.
---@param opts? { reuse_win: boolean, on_list: function }
function M.type_definition(opts)
  validate("opts", opts, "table", true)
  M.get_locations("textDocument/typeDefinition", opts)
end

--- Lists all the implementations for the symbol under the cursor in the
--- quickfix window.
---@param opts? { reuse_win: boolean, on_list: function }
function M.implementation(opts)
  validate("opts", opts, "table", true)
  M.get_locations("textDocument/implementation", opts)
end
return M
