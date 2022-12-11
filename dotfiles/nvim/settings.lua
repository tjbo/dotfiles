local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api


----------------------------------------------------------------------
-- Tree Sitter Plugin 
----------------------------------------------------------------------
-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)

require'nvim-treesitter.configs'.setup {
            ensure_installed = { "bash", "html", "http", "javascript", "jsdoc", "json", "json5",  "lua", "markdown", "ocaml", "ocaml_interface", "python", "rust", "toml", "typescript", "vim", "yaml" },
            highlight = {
                enable =  true,
            	  additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
parser_install_dir = parser_install_dir,
  }

----------------------------------------------------------------------
-- Git Signs Plugin 
----------------------------------------------------------------------

require'gitsigns'.setup({
	on_attach = function(buffer) 
	c("highlight GitSignsAdd guibg=NONE guifg=GREEN")
	c("highlight GitSignsChange guibg=NONE")
	c("highlight GitSignsDelete guibg=NONE")
	c("highlight SignColumn guibg=NONE")
  c("highlight DiffAdd guibg=#d2ebbe guifg=NONE ctermbg=none")
  c("highlight DiffChange guibg=#dad085 guifg=NONE ctermbg=none")
  c("highlight DiffDelete guibg=#f0a0c0 guifg=NONE ctermbg=none")
	end,
  signs = {
        add = { hl = 'GitSignsAdd', text = '│', numhl='GitSignsAddNr', linehl='GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
        untracked  = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
},
})


-- vim.lsp.start({
--           name = 'my-server-name',
--           cmd = {'name-of-language-server-executable'},
--           root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
-- })

require'lspconfig'.pyright.setup{}

----------------------------------------------------------------------
-- General Options 
----------------------------------------------------------------------
o.backspace=indent,eol,start
o.history=9999
-- Number column
o.number = true
o.numberwidth = 2
o.relativenumber = true

-- better spacing when using tabs
o.expandtab = true
o.softtabstop = 2
o.smartindent = true
o.tabstop = 2
o.wrap = false

-- search
o.hlsearch = false
o.incsearch = true

-- colors
o.termguicolors = true
c("colorscheme slate")


g.mapleader = " "
o.completeopt = {'menu', 'menuone', 'noselect'}
o.textwidth = 60
o.wrap = true


-- gutter 
o.signcolumn = "yes:2"


-- Command Menu Settings
o.wildmode = { "list:longest,full" }
-- todo: autowrapping doesn't work
-- o.formatoptions:append { "t" }

-- allows system clipboard to work  
o.clipboard:prepend {"unnamedplus"}
--
-- todo: remove trailing white space on save, maybe this is
-- fixed once adding a formatter
-- api.nvim_create_autocmd({ "BufWritePre" }, {pattern = { "*" },  command = [[%s/\s\+$//e]], })

----------------------------------------------------------------------
-- Keymaps 
----------------------------------------------------------------------
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Telescope
map("n", "<leader>pp", "<cmd>Telescope<cr>")
map("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
map("n", "<leader>pt", "<cmd>Telescope treesitter<cr>")
map("n", "<leader>pb", "<cmd>Telescope buffers<cr>")

-- Vifm
map("n", "<leader>f", ":TabVifm<cr>")

-- Todo: Switch between tabs
-- map("n", "<C-Tab>", ":bnext<cr>")


-- Keeps selection when indenting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Allow CTRL + V to paste from system clipboard
map("i", "<c-v>", "<c-r>+")
--
-- todo add lsp
-- todo add a way to format files 
-- todo add cheat sheet?
-- todo add debugger?
-- todo add some way to multiplex the terminal
-- todo add nvimpager as pager
