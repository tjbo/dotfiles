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
-- Which Key
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
-- Notify
----------------------------------------------------------------------

-- needed for noice
require("notify").setup({ stages = "fade" })

----------------------------------------------------------------------
-- Noice
----------------------------------------------------------------------
require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true,   -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,     -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	views = {
      cmdline_popup = {
        position = {
          row = 5,
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
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
})



----------------------------------------------------------------------
-- TreeSitter
----------------------------------------------------------------------

-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = fn.stdpath("cache") .. "/treesitters"
fn.mkdir(parser_install_dir, "p")

-- Prevents reinstall of treesitter plugins every boot
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
-- GitSigns
----------------------------------------------------------------------
require("gitsigns").setup({
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns
		wk.register({
			["<leader>"] = {
				g = {
					name = "Git",
					b = {
						function()
							gs.blame_line({ full = true })
						end,
						"Blame",
					},
					c = { gs.toggle_current_line_blame, "Toggle blame line" },
					d = { "<cmd>Gitsigns preview_hunk<CR>", "Diff" },
					n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
					p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
					r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
					s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
					u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" },
					h = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlights" },
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
	preview_config = {
		border = "none",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

----------------------------------------------------------------------
-- AutoCompletion
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
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
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
		["<C-k>"] = cmp.mapping.scroll_docs(-2),
		["<C-j>"] = cmp.mapping.scroll_docs(2),
		["<C-w>"] = cmp.mapping.abort(),
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
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!", "wq" },
			},
		},
	}),
})

-- gray
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
-- blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

----------------------------------------------------------------------
-- Lsp
----------------------------------------------------------------------

-- this formats our code
require("lsp-format").setup {}

require("lspconfig").astro.setup({})

local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client, bufnr)

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- c([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
end


require("lspconfig").gopls.setup { on_attach = on_attach }

local lspconfig = require("lspconfig")

-- vimPlugins.cmp-cmdline
-- couldn't install dependencies without setting this option
-- https://github.com/NixOS/nixpkgs/issues/168928#issuecomment-1109581739
lspconfig.gopls.setup({ on_attach = on_attach })

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})


----------------------------------------------------------------------
-- Lsp - Astro
----------------------------------------------------------------------

vim.filetype.add({
	extension = {
		astro = "astro"
	}
})

require 'lspconfig'.astro.setup {}



----------------------------------------------------------------------
-- Lsp - JavaScript & TypeScript
----------------------------------------------------------------------
require('lspconfig').eslint.setup({
	-- right now using vim.prettier which seems to do the job better than all the nvim plugins
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
	on_attach = function(client, bufnr)
		c([[autocmd BufWritePre <buffer> Prettier]])
	end,
})

----------------------------------------------------------------------
-- Lsp - Lua
----------------------------------------------------------------------
lspconfig.lua_ls.setup({
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

----------------------------------------------------------------------
-- Lsp - Nix
----------------------------------------------------------------------
lspconfig.rnix.setup({
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- Lsp - Rescript
----------------------------------------------------------------------
lspconfig.rescriptls.setup({
	cmd = {
		"node",
		"/Users/tjbo/.nix-profile/share/vscode/extensions/chenglou92.rescript-vscode/server/out/server.js",
		"--stdio",
	},
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		askToStartBuild = false,
	},
})

----------------------------------------------------------------------
-- Rust
----------------------------------------------------------------------
lspconfig.rust_analyzer.setup({
	-- This didn't work on my ubuntu system, but check macos before removing completely
	-- cmd = { "/Users/tjbo/.nix-profile/bin/rust-analyzer" },
	capabilities = capabilities,
	on_attach = on_attach,
})

----------------------------------------------------------------------
-- CSS & Tailwind
----------------------------------------------------------------------
lspconfig.tailwindcss.setup({
	cmd = { "tailwindcss-language-server", "--stdio" },
	settings = {
		tailwindCSS = {
			classAttributes = { "className" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
})

-- Need to fix CSS formatter:
-- lspconfig.cssls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

----------------------------------------------------------------------
-- Diagnostics
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
-- Telescope
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
-- Bufferline
----------------------------------------------------------------------

require("bufferline").setup({
	options = {
		themable = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
	}

})

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
		["<leader>"] = {
			"<Cmd>BufferLinePick<CR>",
			"Pick Buffer"
		},
		b = {
			name = "Bufferline",
			b = {
				"<Cmd>BufferLineTogglePin<CR>",
				"Toggle Pin"
			},

			d = { "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
			o = { "<Cmd>BufferLineCloseOthers<CR>" },
			r = { "<Cmd>BufferLineCloseRight<CR>", "Delete buffers to the right" },
			l = { "<Cmd>BufferLineCloseLeft<CR>", "Delete buffers to the left" },

		},
		d = {
			name = "Diagnostics",
			d = {
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				"Show Diagnostic For Error",
			},
			n = {
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				"Next Diagnostic",
			},
			p = {
				"<cmd>lua vim.diagnostic.goto_prev()<CR>",
				"Prev Diagnostic",
			},
		},
		n = {
			name = "Noice",
			l = {
				"<cmd>Noice last<CR>",
				"Noice Last Message",
			},
			d = {
				"<cmd>Noice dismiss<CR>",
				"Dismiss Notifications",
			},
		},
		t = {
			name = "Telescope",
			b = {
				"<cmd>lua require('telescope.builtin').buffers({ previewer= false })<cr>",
				"List Open Buffers",
			},
			c = {
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'horizontal' })<cr>",
				"Fuzzy Search Current Buffer",
			},
			d = {
				"<cmd>lua require('telescope.builtin').diagnostics({ initial_mode = 'normal', path_display='hidden', wrap_results = true })<cr>",
				"List Diagnositcs For All Open Buffers",
			},
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find File" },
			g = { "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", "Go to implementation" },
			h = {
				"<cmd>lua require('telescope.builtin').help_tags()<cr>",
				"Help Tags",
			},
			n = {
				"<cmd>Telescope noice<cr>",
				"Show Notification History"
			},
			j = { "<cmd>lua require('telescope.builtin').jumplist()<cr>", "Jump List" },
			l = { "<cmd>Telescope live_grep<cr>", "Live Grep for CWD" },
			o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Recent Files" },
			r = { "<cmd>Telescope registers<cr>", "Registers" },
			s = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest for Cursor" },
			t = { "<cmd>Telescope git_files<cr>", "Gitfiles" },
			z = { "<cmd>Telescope lsp_workspace_symbols<cr>", "List Workspace Symbols" },
		},
	},
}, {
	window = {
		border = "single",
		position = "top",
	},
	show_help = false,
})
