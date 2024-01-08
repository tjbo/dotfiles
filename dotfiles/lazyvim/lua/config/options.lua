local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api

vim.opt.shell = "zsh -i"
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 999
vim.opt.cursorline = true
vim.opt.history = 999

-- we back-up so no need for swap
vim.opt.swapfile = false

-- better spacing for tabs
-- vim.opt.expandtab = false
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 0
-- vim.opt.softtabstop = 0
-- vim.opt.smarttab = true

-- backups
vim.opt.backupdir = "/tmp/nvim_backups"
vim.opt.backup = true

-- Add timestamp as extension for backup files
api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
  desc = "Add timestamp to backup extension",
  pattern = "*",
  callback = function()
    o.backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M")
  end,
})

-- turn off auto comment insertion
api.nvim_create_autocmd("BufEnter", {
  callback = function()
    o.formatoptions = o.formatoptions - { "c", "r", "o" }
  end,
})
