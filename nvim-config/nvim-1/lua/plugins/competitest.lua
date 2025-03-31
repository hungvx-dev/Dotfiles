return {
  "xeluxee/competitest.nvim",
  enabled = HVIM.competitive_programming,
  dependencies = "MunifTanjim/nui.nvim",
  event = "VeryLazy",
  opts = {
    split_ui = {
      relative_to_editor = false,
    },
    runner_ui = {
      interface = "split",
      selector_show_nu = false,
      selector_show_rnu = false,
      show_nu = true,
      show_rnu = false,
      editor_ui = {
        popup_width = 0.4,
        popup_height = 0.6,
        show_nu = true,
        show_rnu = false,
        normal_mode_mappings = {
          switch_window = { "<C-w>h", "<C-w>l", "<C-w>i" },
          save_and_close = "<C-s>",
          cancel = { "q", "<esc>" },
        },
        insert_mode_mappings = {
          switch_window = { "<C-w>h", "<C-w>l", "<C-w>i" },
          save_and_close = "<C-s>",
          cancel = { "q", "<esc>" },
        },
      },
      mappings = {
        run_again = "R",
        run_all_again = "<C-r>",
        kill = "K",
        kill_all = "<C-k>",
        view_input = { "i", "I" },
        view_output = { "a", "A" },
        view_stdout = { "o", "O" },
        view_stderr = { "e", "E" },
        toggle_diff = { "d", "D" },
        close = { "q", "Q" },
      },
      viewer = {
        width = 0.5,
        height = 0.5,
        show_nu = true,
        show_rnu = false,
        close_mappings = { "q", "Q" },
      },
    },
    compile_command = {
      cpp = { exec = "clang++", args = { "$(FNAME)", "-o", "$(FNOEXT)" } },
    },
    run_command = {
      cpp = { exec = "./$(FNOEXT)" },
    },
  },
}
