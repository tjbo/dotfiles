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

-- highlights current row of cursor
o.cursorline = true

o.history = 9999

-- number column
o.number = true
o.numberwidth = 2
o.relativenumber = true

-- default splits to vertical
o.diffopt:append({ "vertical" })

-- open help windows vertically
c([[autocmd FileType help wincmd L]])

-- better spacing when using tabs
o.expandtab = false
o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = 0
o.smarttab = true

-- search
o.hlsearch = true
o.incsearch = true

-- colors
o.termguicolors = true
c("colorscheme codedark")

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
				name = "Gitsigns",
				g = {
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

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping({
			i = function(a, b)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					-- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					-- vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
				else
					vim.api.nvim_feedkeys(t("<Tab>"), "n", true) -- fallback()
				end
			end,
		}),
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
		-- null_ls.builtins.completion.spell,
	},
})

-- auto format on write
c([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])

local on_attach = function(client, bufnr)
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "gD", vim.lsp.buf.declaration, bufopts)
	map("n", "gd", vim.lsp.buf.definition, bufopts)
	map("n", "K", vim.lsp.buf.hover, bufopts)
	map("n", "gi", vim.lsp.buf.implementation, bufopts)
	map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	map("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	map("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	map("n", "gr", vim.lsp.buf.references, bufopts)

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
})

-- Rescript
lspconfig.rescriptls.setup({
	cmd = {
		"node",
		"/Users/tjbo/.nix-profile/share/vscode/extensions/chenglou92.rescript-vscode/server/out/server.js",
		"--stdio",
	},
	capabilities = capabilities,
})

-- Rust
lspconfig.rust_analyzer.setup({
	cmd = { "/Users/tjbo/.nix-profile/bin/rust-analyzer" },
	capabilities = capabilities,
})

----------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-c>"] = require("telescope.actions").close,
			},
		},
	},
})

require("telescope").load_extension("file_browser")

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

-- Vifm
map("n", "<leader>pd", ":below 100 TabVifm<cr>")

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

wk.register({
	["<leader>"] = {
		t = {
			name = "Telescope",
			b = { "<cmd>lua require('telescope.builtin').buffers({ previewer= false })<cr>", "List buffers" },
			c = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy search in current buffer" },
			d = { "<cmd>Telescope diagnostics<cr>", "List diagnositcs" },
			f = { "<cmd>lua require('telescope.builtin').find_files({ previewer= false })<cr>", "Find file" },
			g = { "<cmd>Telescope live_grep<cr>", "Live grep for CWD" },
			-- this seems to be a lil broken, with grep preview vs other preview
			j = { "<cmd>lua require('telescope.builtin').jumplist({ previewer= false })<cr>", "Jump list" },
			h = {
				"<cmd>lua require('telescope.builtin').command_history({ previewer= false })<cr>",
				"List command hisotry",
			},
			r = { "<cmd>Telescope lsp_references<cr>", "Find references of" },
			s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "List symbols" },
			t = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
			v = { "<cmd>Telescope registers<cr>", "Registers" },
		},
	},
})
