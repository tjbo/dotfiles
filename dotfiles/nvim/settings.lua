local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api


-- Map keys function
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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


-- require'neo-tree'.setup({
--         close_if_last_window: true,
-- });

----------------------------------------------------------------------
-- Lsp  
----------------------------------------------------------------------

local on_attach = function (client, bufnr) 
          -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)
  map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Javascript & Typescript
require'lspconfig'['tsserver'].setup{
        cmd = {'typescript-language-server', '--stdio', '--tsserver-path', '/Users/tjbo/.nix-profile/bin/tsserver'}, 
}

-- Lua
require'lspconfig'.sumneko_lua.setup {
         settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }

}

-- Rescript
require'lspconfig'.rescriptls.setup {
        cmd = { 'node', '/Users/tjbo/.nix-profile/share/vscode/extensions/chenglou92.rescript-vscode/server/out/server.js', '--stdio' }
}

-- Rust
require'lspconfig'.rust_analyzer.setup{cmd = { '/Users/tjbo/.nix-profile/bin/rust-analyzer' } }



----------------------------------------------------------------------
-- General Options 
----------------------------------------------------------------------
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

-- can this be working?
o.undodir = "Users/tjbo/.local/share/nvim/undo"
o.backup = true
o.backupdir = "/User/tjbo/.local/share/nvim/backups"
o.backupext = ".bak"

c("silent !mkdir /Users/tjbo/.local/share/nvim/backups> /dev/null 2>&1")
-- auto back up with timestamp
api.nvim_create_autocmd('BufWritePre', {
  group = api.nvim_create_augroup('timestamp_backupext', { clear = true }),
  desc = 'Add timestamp to backup extension',
  pattern = '*',
  callback = function()
    o.backupext = '-' .. vim.fn.strftime('%Y%m%d%H%M')
  end,
})

----------------------------------------------------------------------
-- Keymaps 
----------------------------------------------------------------------


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
-- todo add a way to format files 
-- todo add cheat sheet?
-- todo add debugger?
-- todo add some way to multiplex the terminal
-- todo add nvimpager as pager
