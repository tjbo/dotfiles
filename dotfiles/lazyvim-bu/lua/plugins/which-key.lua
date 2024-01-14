return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      -- ["g"] = { name = "+goto" },
      ["<leader>s"] = { name = "+surround" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>t"] = { name = "+telescope" },
      ["<leader>d"] = { name = "+diagnostics/quickfix" },
    },
  },
}
