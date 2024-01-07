return {
  "akinsho/bufferline.nvim",
  keys = function()
    return {
      { "<leader>bx", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bb", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      { "<leader>bw", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<leader>bn", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<leader>bp", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    }
  end,
}
