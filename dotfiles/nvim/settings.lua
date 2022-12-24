local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api
local wk = require("which-key")

----------------------------------------------------------------------
-- General
----------------------------------------------------------------------
o.showmode = false

-- turn off auto comment insertion
api.nvim_create_autocmd("BufEnter", {
	callback = function()
		o.formatoptions = o.formatoptions - { "c", "r", "o" }
	end,
})

-- so cursor stays in middle
o.scrolloff = 999

-- highlights current row of cursor
o.cursorline = true

-- history
o.history = 9999

-- number column
o.number = true
o.numberwidth = 2
o.relativenumber = true

-- we back up so don't need swap
o.swapfile = false

-- default splits to vertical
o.diffopt:append({ "vertical" })

-- open help windows vertically
c([[autocmd FileType help wincmd L]])

-- better spacing when using tabs
o.expandtab = false
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = 0
o.smarttab = true

-- search
o.hlsearch = true
o.incsearch = true

-- colors
o.termguicolors = true
c("colorscheme codedark")

-- sets bg transparency
-- api.nvim_set_hl(0, "Normal", { bg = "none" })
-- api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- c(":hi LineNr guibg=NONE guifg=#ffffff")

g.mapleader = " "
o.completeopt = { "menu", "menuone", "noselect" }
o.textwidth = 60
o.wrap = true

-- gutter
o.signcolumn = "yes:2"

-- Command Menu Settings
o.wildmode = { "list:longest,full" }

-- allows system clipboard to work
o.clipboard:prepend({ "unnamedplus" })

-- vifm
g.vifm_replace_netrw = 1
g.vifm_replace_netrw_cmd = "Vifm"
g.vifm_embed_split = 1

-- allows persistent undos
o.undodir = "/tmp/nvim_undos"
o.undofile = true

-- backups config
o.backupdir = "/tmp/nvim_backups"
o.backup = true

-- Add timestamp as extension for backup files
api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		o.backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M")
	end,
})

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
local parser_install_dir = fn.stdpath("cache") .. "/treesitters"
fn.mkdir(parser_install_dir, "p")

-- Prevents reinstall of treesitter plugins every boot
o.runtimepath:append(parser_install_dir)

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"html",
		"http",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"lua",
		"markdown",
		"ocaml",
		"ocaml_interface",
		"python",
		"rust",
		"toml",
		"typescript",
		"vim",
		"yaml",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	parser_install_dir = parser_install_dir,
})

----------------------------------------------------------------------
-- Git Signs Plugin
----------------------------------------------------------------------
require("gitsigns").setup({
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns
		wk.register({
			["<leader>"] = {
				g = {
					name = "Gitsigns",
					b = {
						function()
							gs.blame_line({ full = true })
						end,
						"Blame",
					},
					c = { gs.toggle_current_line_blame, "Toggle blame line" },
					d = { "<cmd>Gitsigns diffthis<CR>", "Diff" },
					D = {
						function()
							gs.diffthis("~")
						end,
						"Diff to head",
					},
					n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
					p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
					r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
					s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
					u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" },
					l = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlights" },
					w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Toggle word diff" },
				},
			},
		})

		c("highlight GitSignsAdd guibg=NONE guifg=GREEN")
		c("highlight GitSignsChange guibg=NONE guifg=ORANGE")
		c("highlight GitSignsDelete guibg=NONE guifg=RED")
		c("highlight SignColumn guibg=NONE")
		c("highlight DiffAdd guibg=GREEN guifg=NONE ctermbg=none")
		c("highlight DiffChange guibg=ORANGE guifg=NONE ctermbg=none")
		c("highlight DiffDelete guibg=RED guifg=NONE ctermbg=none")
	end,
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = {
			hl = "GitSignsChange",
			text = "│",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		delete = {
			hl = "GitSignsDelete",
			text = "_",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = "‾",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		changedelete = {
			hl = "GitSignsChange",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},
})

----------------------------------------------------------------------
-- Lsp
----------------------------------------------------------------------
local null_ls = require("null-ls")

local cmp = require("cmp")

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 1,
		},
		documentation = cmp.config.window.bordered(),

		dofile,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-2),
		["<C-f>"] = cmp.mapping.scroll_docs(2),
		["<C-a>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if not cmp.select_next_item() then
				-- currently does not work for vsnip
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
		["<S-Tab>"] = function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		-- { name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!", "wq" },
			},
		},
	}),
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.statix,
		-- null_ls.builtins.diagnostics.deadnix,
		-- null_ls.builtins.completion.spell,
	},
})

local on_attach = function(client, bufnr)
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- map("n", "gd", vim.lsp.buf.definition, bufopts)
	-- map("n", "K", vim.lsp.buf.hover, bufopts)
	-- map("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	-- map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	-- map("n", "<space>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	-- map("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	-- map("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- map("n", "gr", vim.lsp.buf.references, bufopts)
	c([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])

	wk.register({
		["<leader>"] = {
			l = {
				name = "Lsp",
				D = {
					vim.lsp.buf.declaration,
					"Declaration",
					bufopts,
				},
				d = {
					vim.lsp.buf.definition,
					"Definition",
					bufopts,
				},
				f = {
					function()
						vim.lsp.buf.format({ async = true })
					end,
					"Format",
					bufopts,
				},
				h = {
					vim.lsp.buf.hover,
					"Search in current file",
					bufopts,
				},

				-- I think this is broken in the plugin
				-- w = {
				-- 	"<leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				-- 	"Search word",
				-- },
			},
		},
	})

	-- not working
	-- map("n", "<space>f", function()
	-- vim.lsp.buf.format({ async = true })
	-- end, bufopts)
end

local lspconfig = require("lspconfig")

-- vimPlugins.cmp-cmdline
-- couldn't install dependencies without setting this option
-- https://github.com/NixOS/nixpkgs/issues/168928#issuecomment-1109581739

lspconfig.gopls.setup({ on_attach = on_attach })

-- Javascript & Typescript
lspconfig["tsserver"].setup({
	cmd = { "typescript-language-server", "--stdio", "--tsserver-path", "/Users/tjbo/.nix-profile/bin/tsserver" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- NixOS
lspconfig.rnix.setup({
	on_attach = on_attach,
})

-- Rescript
lspconfig.rescriptls.setup({
	cmd = {
		"node",
		"/Users/tjbo/.nix-profile/share/vscode/extensions/chenglou92.rescript-vscode/server/out/server.js",
		"--stdio",
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Rust
lspconfig.rust_analyzer.setup({
	cmd = { "/Users/tjbo/.nix-profile/bin/rust-analyzer" },
	capabilities = capabilities,
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------

require("telescope").setup({
	defaults = {
		layout_config = {
			horizontal = { width = 0.99, height = 0.99 },
			vertical = { width = 0.99 },
		},
		mappings = {
			i = {
				["<C-c>"] = require("telescope.actions").close,
			},
		},
		-- pickers = {
		-- 	find_files = {
		-- 		theme = "dropdown",
		-- 	},
		-- },
	},
})

----------------------------------------------------------------------
-- Spectre
----------------------------------------------------------------------
require("spectre").setup()

wk.register({
	["<leader>"] = {
		s = {
			name = "Spectre",
			o = {
				"<cmd>lua require('spectre').open()<CR>",
				"Open spectre",
			},
			a = {
				"<cmd>lua require('spectre.actions').run_replace()<CR>",
				"Replace all",
			},
			c = {
				"lua require('spectre').open_file_search()<CR>",
				"Search in current file",
			},

			-- I think this is broken in the plugin
			-- w = {
			-- 	"<leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>",
			-- 	"Search word",
			-- },
		},
	},
})

----------------------------------------------------------------------
-- Lightline
----------------------------------------------------------------------

g["lightline"] = {
	-- active = {
	--         left = { { "mode" }, { "statuslinetabs" } },
	-- },
	colorscheme = "solarized",
	-- component_expand = {
	--         statuslinetabs = "lightline#statuslinetabs#show",
	-- },
}

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------
-- clears the search highlight
map("n", "<C-L>", ":nohlsearch<CR><C-L>")

-- Todo: Switch between tabs
map("n", "<C-tab>", "<cmd>tabnext<cr>")
map("n", "<C-S-tab>", "<cmd>tabprev<cr>")
map("n", "<C-n>", "<cmd>tabnew<cr>")

-- Keeps selection when indenting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Allows <ctrl+v> to paste from system clipboard
map("i", "<c-v>", "<c-r>+")

map("n", "<leader>/", "<cmd>WhichKey<cr>")

map("n", "<PageUp>", "<C-b>")

wk.register({
	["<leader>"] = {
		f = {
			name = "Files",
			f = { ":below 100 TabVifm<cr>", "Open files" },
		},
		t = {
			name = "Telescope",
			b = {
				"<cmd>lua require('telescope.builtin').buffers({ previewer= false })<cr>",
				"List open buffers in current neovim instance",
			},
			c = {
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'horizontal' })<cr>",
				"Fuzzy search current buffer",
			},
			d = { "<cmd>Telescope diagnostics<cr>", "List diagnositcs" },
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find file" },
			g = { "<cmd>Telescope git_status<cr>", "List active git files" },
			l = { "<cmd>Telescope live_grep<cr>", "Live grep for cwd" },
			j = { "<cmd>lua require('telescope.builtin').jumplist()<cr>", "Jump list" },
			h = {
				"<cmd>lua require('telescope.builtin').command_history()<cr>",
				"List nvim command history",
			},
			-- r = { "<cmd>Telescope lsp_references<cr>", "List LSP refs for word under cursor " },
			r = { "<cmd>Telescope registers<cr>", "Registers" },
			s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "List workspace symbols" },
			t = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
			w = {
				"<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<cr>",
				"Search for string under curse in cwd",
			},
		},
	},
})
