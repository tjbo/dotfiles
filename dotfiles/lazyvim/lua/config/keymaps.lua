-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local unset = vim.keymap.del

unset("n", "<leader>gg")
unset("n", "<leader>gG")

-- diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

unset("n", "<leader>cd")
unset("n", "]d")
unset("n", "[d")
unset("n", "]e")
unset("n", "[e")
unset("n", "]w")
unset("n", "[w")
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
set("n", "<leader>dn", diagnostic_goto(true), { desc = "Next Diagnostic" })
set("n", "<leader>dp", diagnostic_goto(false), { desc = "Prev Diagnostic" })

-- floating terminal
unset("n", "<leader>ft")
unset("n", "<leader>fT")
unset("n", "<c-/>")
unset("n", "<c-_>")

-- windows
set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
unset("n", "<leader>|")
unset("n", "<leader>-")

-- tabs
unset("n", "<leader><tab>l")
unset("n", "<leader><tab>f")
unset("n", "<leader><tab><tab>")
unset("n", "<leader><tab>d")
unset("n", "<leader><tab>]")
unset("n", "<leader><tab>[")

-- buffers are in bufferline plugin
