local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api
local wk = require("which-key")

----------------------------------------------------------------------
-- Icons
----------------------------------------------------------------------

require("nvim-web-devicons").setup({})

----------------------------------------------------------------------
-- Mini
----------------------------------------------------------------------

require("mini.surround").setup()
require("mini.comment").setup({
	mappings = {
		-- normal and visual modes
		comment = "gc",
		-- toggle comment on current line
		comment_line = "gcc",
		-- toggle comment on visual selection
		comment_visual = "gc",
		-- define 'comment' textobject (like `dgc` - delete whole comment block)
		textobject = "gc",
	},
})


----------------------------------------------------------------------
-- which key
----------------------------------------------------------------------

wk.setup({
	presets = {
		operators = false,
		motions = false,
		text_objects = false,
		windows = true,
	},
	plugins = {
		marks = false,
		registers = false,
		spelling = {
			enabled = false,
		},
	},
	layout = {
		height = { min = 30, max = 250 },
	},
	window = {
		padding = { 2, 2, 2, 2 },
		winblend = 10,
	},
})

----------------------------------------------------------------------
-- general
----------------------------------------------------------------------
o.showmode = false

-- turn off auto comment insertion
api.nvim_create_autocmd("bufenter", {
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
c([[autocmd filetype help wincmd l]])

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

g.mapleader = " "
o.completeopt = { "menu", "menuone", "noselect" }
o.textwidth = 60
o.wrap = true

-- gutter
o.signcolumn = "yes:2"

-- command menu settings
o.wildmode = { "list:longest,full" }

-- allows system clipboard to work
o.clipboard:prepend({ "unnamedplus" })

-- allows persistent undos
o.undodir = "/tmp/nvim_undos"
o.undofile = true

-- backups config
o.backupdir = "/tmp/nvim_backups"
o.backup = true

-- add timestamp as extension for backup files
api.nvim_create_autocmd("bufwritepre", {
	group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
	desc = "add timestamp to backup extension",
	pattern = "*",
	callback = function()
		o.backupext = "-" .. vim.fn.strftime("%y%m%d%h%m")
	end,
})

-- map keys function
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------------------------------------------------------
-- notify
----------------------------------------------------------------------

-- needed for noice
require("notify").setup({ stages = "fade" })

----------------------------------------------------------------------
-- lualine
----------------------------------------------------------------------

local custom_ayudark = require("lualine.themes.ayu_dark")

-- change the background of lualine_c section for normal mode
custom_ayudark.normal.c.fg = "#e6e1cf"

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_ayudark,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				newfile_status = true, -- display new file status (new file means no write after created)
				path = 3,
			},
		},
		lualine_x = {
			"encoding",
			{
				"filetype",
				colored = true, -- displays filetype icon in color if set to true
				icon_only = false, -- display only an icon for filetype
				icon = { align = "right" }, -- display filetype icon on the right hand side
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		-- lualine_c = { "filename" },
		-- lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
});

----------------------------------------------------------------------
-- noice
----------------------------------------------------------------------
require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true,   -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,     -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	views = {
		cmdline_popup = {
			position = {
				row = 10,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
			relative = "editor",
			position = {
				row = 13,
				col = "50%",
			},
			size = {
				width = 60,
				height = 20,
			},
			border = {
				style = "rounded",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { normal = "normal", floatborder = "diagnosticinfo" },
			},
		},
	},
})



----------------------------------------------------------------------
-- treesitter
----------------------------------------------------------------------

-- defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = fn.stdpath("cache") .. "/treesitters"
fn.mkdir(parser_install_dir, "p")

-- prevents reinstall of treesitter plugins every boot
o.runtimepath:append(parser_install_dir)


require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"astro",
		"bash",
		"css",
		"html",
		"http",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"lua",
		"markdown",
		"markdown_inline",
		"ocaml",
		"ocaml_interface",
		"python",
		"regex",
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
-- gitsigns
----------------------------------------------------------------------
require("gitsigns").setup({
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns
		wk.register({
			["<leader>"] = {
				g = {
					name = "git",
					b = {
						function()
							gs.blame_line({ full = true })
						end,
						"blame",
					},
					v = { gs.toggle_current_line_blame, "toggle blame line" },
					d = { "<cmd>gitsigns preview_hunk<cr>", "diff" },
					n = { "<cmd>gitsigns next_hunk<cr>", "next hunk" },
					p = { "<cmd>gitsigns prev_hunk<cr>", "prev hunk" },
					r = { "<cmd>gitsigns reset_hunk<cr>", "reset hunk" },
					s = { "<cmd>gitsigns stage_hunk<cr>", "stage hunk" },
					u = { "<cmd>gitsigns undo_stage_hunk<cr>", "undo stage hunk" },
					h = { "<cmd>gitsigns toggle_linehl<cr>", "toggle line highlights" },
					w = { "<cmd>gitsigns toggle_word_diff<cr>", "toggle word diff" },
				},
			},
		})
		c("highlight gitsignsadd guibg=none guifg=green")
		c("highlight gitsignschange guibg=none guifg=orange")
		c("highlight gitsignsdelete guibg=none guifg=red")
		c("highlight signcolumn guibg=none")
		c("highlight diffadd guibg=green guifg=none ctermbg=none")
		c("highlight diffchange guibg=orange guifg=none ctermbg=none")
		c("highlight diffdelete guibg=red guifg=none ctermbg=none")
	end,
	signs = {
		add = { hl = "gitsignsadd", text = "│", numhl = "gitsignsaddnr", linehl = "gitsignsaddln" },
		change = {
			hl = "gitsignschange",
			text = "│",
			numhl = "gitsignschangenr",
			linehl = "gitsignschangeln",
		},
		delete = {
			hl = "gitsignsdelete",
			text = "_",
			numhl = "gitsignsdeletenr",
			linehl = "gitsignsdeleteln",
		},
		topdelete = {
			hl = "gitsignsdelete",
			text = "‾",
			numhl = "gitsignsdeletenr",
			linehl = "gitsignsdeleteln",
		},
		changedelete = {
			hl = "gitsignschange",
			text = "~",
			numhl = "gitsignschangenr",
			linehl = "gitsignschangeln",
		},
		untracked = { hl = "gitsignsadd", text = "┆", numhl = "gitsignsaddnr", linehl = "gitsignsaddln" },
	},
	preview_config = {
		border = "none",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

----------------------------------------------------------------------
-- autocompletion
----------------------------------------------------------------------
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
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")

		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("comment")
		end
	end,
	formatting = {
		format = function(entry, vim_item)
			if vim.tbl_contains({ "path" }, entry.source.name) then
				local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
		end,
	},
	snippet = {
		-- required - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- for `vsnip` users.
		end,
	},
	window = {
		completion = {
			winhighlight = "normal:pmenu,floatborder:pmenu,search:none",
			col_offset = -3,
			side_padding = 1,
		},
		documentation = cmp.config.window.bordered(),

		dofile,
	},
	mapping = cmp.mapping.preset.insert({
		["<c-k>"] = cmp.mapping.scroll_docs(-2),
		["<c-j>"] = cmp.mapping.scroll_docs(2),
		["<c-w>"] = cmp.mapping.abort(),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<tab>"] = function(fallback)
			if not cmp.select_next_item() then
				-- currently does not work for vsnip
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
		["<s-tab>"] = function(fallback)
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
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- gray
vim.api.nvim_set_hl(0, "cmpitemabbrdeprecated", { bg = "none", strikethrough = true, fg = "#808080" })
-- blue
vim.api.nvim_set_hl(0, "cmpitemabbrmatch", { bg = "none", fg = "#569cd6" })
vim.api.nvim_set_hl(0, "cmpitemabbrmatchfuzzy", { link = "cmpintemabbrmatch" })
-- light blue
vim.api.nvim_set_hl(0, "cmpitemkindvariable", { bg = "none", fg = "#9cdcfe" })
vim.api.nvim_set_hl(0, "cmpitemkindinterface", { link = "cmpitemkindvariable" })
vim.api.nvim_set_hl(0, "cmpitemkindtext", { link = "cmpitemkindvariable" })
-- pink
vim.api.nvim_set_hl(0, "cmpitemkindfunction", { bg = "none", fg = "#c586c0" })
vim.api.nvim_set_hl(0, "cmpitemkindmethod", { link = "cmpitemkindfunction" })
-- front
vim.api.nvim_set_hl(0, "cmpitemkindkeyword", { bg = "none", fg = "#d4d4d4" })
vim.api.nvim_set_hl(0, "cmpitemkindproperty", { link = "cmpitemkindkeyword" })
vim.api.nvim_set_hl(0, "cmpitemkindunit", { link = "cmpitemkindkeyword" })

----------------------------------------------------------------------
-- lsp
----------------------------------------------------------------------

-- formatting
require("conform").setup({
	formatters_by_ft = {
		-- for astro also need to add a config and plugin locally
		-- https://github.com/withastro/prettier-plugin-astro
		astro = { { "prettier" } },
		javascript = { { "prettier" } },
		lua = { "stylua" },
		rust = { "rustfmt" },

	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("lspconfig").astro.setup({})

local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client, bufnr)

	if client.name == "tsserver" then
		client.server_capabilities.documentformattingprovider = false
	end
	-- api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- c([[autocmd bufwritepre <buffer> lua vim.lsp.buf.format()]])
end


require("lspconfig").gopls.setup { on_attach = on_attach }

local lspconfig = require("lspconfig")

lspconfig.gopls.setup({ on_attach = on_attach })

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})


----------------------------------------------------------------------
-- lsp - astro
----------------------------------------------------------------------

vim.filetype.add({
	extension = {
		astro = "astro"
	}
})

require 'lspconfig'.astro.setup({
	capabilities = capabilities,
})



----------------------------------------------------------------------
-- lsp - javascript & typescript
----------------------------------------------------------------------
require('lspconfig').eslint.setup({
	-- right now using vim.prettier which seems to do the job better than all the nvim plugins
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
	on_attach = function(client, bufnr)
		c([[autocmd bufwritepre <buffer> prettier]])
	end,
})

----------------------------------------------------------------------
-- lsp - lua
----------------------------------------------------------------------
lspconfig.lua_ls.setup({
	settings = {
		lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- lsp - nix
----------------------------------------------------------------------
lspconfig.rnix.setup({
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- lsp - rescript
----------------------------------------------------------------------
lspconfig.rescriptls.setup({
	cmd = {
		"node",
		"/users/tjbo/.nix-profile/share/vscode/extensions/chenglou92.rescript-vscode/server/out/server.js",
		"--stdio",
	},
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		asktostartbuild = false,
	},
})

----------------------------------------------------------------------
-- rust
----------------------------------------------------------------------
lspconfig.rust_analyzer.setup({
	-- this didn't work on my ubuntu system, but check macos before removing completely
	-- cmd = { "/users/tjbo/.nix-profile/bin/rust-analyzer" },
	capabilities = capabilities,
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- css & tailwind
----------------------------------------------------------------------
lspconfig.tailwindcss.setup({
	cmd = { "tailwindcss-language-server", "--stdio" },
	settings = {
		tailwindcss = {
			classattributes = { "classname" },
			lint = {
				cssconflict = "warning",
				invalidapply = "error",
				invalidconfigpath = "error",
				invalidscreen = "error",
				invalidtailwinddirective = "error",
				invalidvariant = "error",
				recommendedvariantorder = "warning",
			},
			validate = true,
		},
	},
})

-- need to fix css formatter:
-- lspconfig.cssls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

----------------------------------------------------------------------
-- diagnostics
----------------------------------------------------------------------
vim.diagnostic.config({
	float = {
		scope = "c",
		header = "",
	},
	signs = true,
	virtual_text = false,
})

----------------------------------------------------------------------
-- telescope
----------------------------------------------------------------------
require("telescope").setup({
	defaults = {
		wrap_results = true,
		layout_config = {
			horizontal = { width = 0.99, height = 0.99 },
			vertical = { width = 0.99 },
		},
		mappings = {
			i = {
				["q"] = require("telescope.actions").close,
			},
		},
	},
	pickers = {
		diagnostics = {
			previewer = true,
		},
		oldfiles = {
			previewer = false,
		},
	},
})


----------------------------------------------------------------------
-- bufferline
----------------------------------------------------------------------

require("bufferline").setup({
	options = {
		themable = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
	}

})

----------------------------------------------------------------------
-- keymaps
----------------------------------------------------------------------
-- clears the search highlight
map("n", "<c-l>", ":nohlsearch<cr><c-l>")

-- todo: switch between tabs
map("n", "<c-tab>", "<cmd>tabnext<cr>")
map("n", "<c-s-tab>", "<cmd>tabprev<cr>")
map("n", "<c-n>", "<cmd>tabnew<cr>")

-- keeps selection when indenting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- allows <ctrl+v> to paste from system clipboard
map("i", "<c-v>", "<c-r>+")
map("n", "<leader>/", "<cmd>whichkey<cr>")
map("n", "<pageup>", "<c-b>")

wk.register({
	["<leader>"] = {
		["<leader>"] = {
			"<cmd>bufferlinepick<cr>",
			"pick buffer"
		},
		b = {
			name = "bufferline",
			b = {
				"<cmd>bufferlinetogglepin<cr>",
				"toggle pin"
			},
			d = { "<cmd>bufferlinegroupclose ungrouped<cr>", "delete non-pinned buffers" },
			o = { "<cmd>bufferlinecloseothers<cr>", "close other buffers" },
			r = { "<cmd>bufferlinecloseright<cr>", "delete buffers to the right" },
			l = { "<cmd>bufferlinecloseleft<cr>", "delete buffers to the left" },
		},
		d = {
			name = "diagnostics",
			d = {
				"<cmd>lua vim.diagnostic.open_float()<cr>",
				"show diagnostic for error",
			},
			n = {
				"<cmd>lua vim.diagnostic.goto_next()<cr>",
				"next diagnostic",
			},
			p = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"prev diagnostic",
			},
		},
		n = {
			name = "noice",
			l = {
				"<cmd>noice last<cr>",
				"noice last message",
			},
			d = {
				"<cmd>noice dismiss<cr>",
				"dismiss notifications",
			},
		},
		t = {
			name = "telescope",
			b = {
				"<cmd>lua require('telescope.builtin').buffers({ previewer= false })<cr>",
				"list open buffers",
			},
			c = {
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'horizontal' })<cr>",
				"fuzzy search current buffer",
			},
			d = {
				"<cmd>lua require('telescope.builtin').diagnostics({ initial_mode = 'normal', path_display='hidden', wrap_results = true })<cr>",
				"list diagnositcs for all open buffers",
			},
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "find file" },
			h = {
				"<cmd>lua require('telescope.builtin').help_tags()<cr>",
				"help tags",
			},
			n = {
				"<cmd>telescope noice<cr>",
				"show notification history"
			},
			j = { "<cmd>lua require('telescope.builtin').jumplist()<cr>", "jump list" },
			g = { "<cmd>telescope live_grep<cr>", "live grep for cwd" },
			o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "recent files" },
			r = { "<cmd>telescope registers<cr>", "registers" },
			t = { "<cmd>telescope git_files<cr>", "gitfiles" },
		},
	},
}, {
	window = {
		border = "single",
		position = "top",
	},
	show_help = false,
})
