return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
    { "<leader>gc", "<cmd>Gitsigns toggle_current_line_blame", desc = "Toggle blame line" },
    { "<leader>gd", "<cmd>Gitsigns preview_hunk<CR>", desc = "Diff" },
    { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
    { "<leader>gh", "<cmd>Gitsigns toggle_linehl<CR>", desc = "Toggle line highlights" },
    { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", desc = "Toggle word diff" },
  },
  opts = {
    on_attach = function(buffer)
      -- just leaving this blnak to remove default keybinds
    end,
  },
}
