local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      { "<leader>tf", Util.telescope("find_files", { cwd = false }), desc = "Find Files" },
      { "<leader>tt", Util.telescope("git_files"), desc = "Find Files (git)" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
      { "<leader>t:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>tc", Util.telescope.config_files(), desc = "Find Config File" },
      { "<leader>to", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent Files (cwd)" },
      { '<leader>tr"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>tz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>tm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>tr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      -- { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      -- { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      -- { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      -- { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    }
  end,
}
