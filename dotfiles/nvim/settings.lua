local fn = vim.fn
local g = vim.g
local c = vim.cmd
local o = vim.opt
local api = vim.api
local wk = require("which-key")

g.loaded_netrwPlugin = 0

require("oil").setup({
	default_file_explorer = false,
	constrain_cursor = "name",
	prompt_save_on_select_new_entry = true,
	view_options = {
		hidden = true,
		is_hidden_file = function(name, bufnr)
			return vim.startswith(name, ".")
		end,
	},
	keymaps = {
		["<C-?>"] = "actions.show_help",
		["f"] = "actions.select",
		["<CR>"] = "actions.select",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["b"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["<C-s>"] = "actions.change_sort",
		["<C-.>"] = "actions.toggle_hidden",
	},
	use_default_keymaps = false,
})

----------------------------------------------------------------------
-- Icons
----------------------------------------------------------------------

require("nvim-web-devicons").setup({})

----------------------------------------------------------------------
-- Which Key
----------------------------------------------------------------------

wk.setup({
	ignore_missing = true,
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

o.splitright = true

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
o.relativenumber = true
o.signcolumn = "yes:1"

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
o.textwidth = 80
o.wrap = true

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
-- Lualine
----------------------------------------------------------------------

local custom_ayudark = require("lualine.themes.ayu_dark")

-- Change the background of lualine_c section for normal mode
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
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = true, -- Display new file status (new file means no write after created)
				path = 3,
			},
		},
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
			"encoding",
			{
				"filetype",
				colored = true, -- Displays filetype icon in color if set to true
				icon_only = false, -- Display only an icon for filetype
				icon = { align = "right" }, -- Display filetype icon on the right hand side
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- only one status line when multiple windows
o.laststatus = 3

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
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
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
		"c",
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
		"ruby",
		"rust",
		"toml",
		"typescript",
		"vim",
		"vimdoc",
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
	on_attach = function()
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

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	enabled = function()
		if vim.bo.buftype == "prompt" then
			return false
		elseif vim.bo.ft == "markdown" then
			return false
		elseif vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			local context = require("cmp.config.context")
			-- keep command mode completion enabled when cursor is in a comment
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
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-2),
		["<C-d>"] = cmp.mapping.scroll_docs(2),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif has_words_before() then
				cmp.complete()
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "vsnip", keyword_length = 4 },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path", keyword_length = 2 },
	}),
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

----------------------------------------------------------------------
-- Lsp
----------------------------------------------------------------------

-- This setups code formatting
require("conform").setup({
	formatters_by_ft = {
		-- for astro also need to add a config and plugin locally
		-- https://github.com/withastro/prettier-plugin-astro
		astro = { "prettier" },
		css = { "rustywind" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("conform").setup({
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

require("lspconfig").astro.setup({})

local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
end

require("lspconfig").gopls.setup({ on_attach = on_attach })

local lspconfig = require("lspconfig")

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
		astro = "astro",
	},
})

require("lspconfig").astro.setup({
	capabilities = capabilities,
})

----------------------------------------------------------------------
-- Lsp - Podspec
----------------------------------------------------------------------

local auto_command_on = vim.api.nvim_create_autocmd

auto_command_on({ "BufRead", "BufNewFile" }, {
	pattern = { "*.podspec", "Podfile" },
	command = "set filetype=ruby",
})

----------------------------------------------------------------------
-- Lsp - JavaScript & TypeScript
----------------------------------------------------------------------

require("lspconfig").eslint.setup({
	-- right now using vim.prettier which seems to do the job better than all the nvim plugins
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
	},
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
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
local actions = require("telescope.actions")
local ta = {
	["<C-o>"] = function(p_bufnr)
		require("telescope.actions").send_selected_to_qflist(p_bufnr)
		vim.cmd.cfdo("edit")
	end,
	["<C-j>"] = actions.move_selection_next,
	["<C-k>"] = actions.move_selection_previous,
	["<C-c>"] = actions.close,
	["<Down>"] = actions.nop,
	["<Up>"] = actions.nop,
	["<CR>"] = actions.select_default,
	["<C-CR>"] = actions.select_default,
	["<C-x>"] = actions.select_horizontal,
	["<C-v>"] = actions.select_vertical,
	["<C-t>"] = actions.select_tab,
	["<C-u>"] = actions.preview_scrolling_up,
	["<C-d>"] = actions.preview_scrolling_down,
	["<C-f>"] = actions.preview_scrolling_left,
	["<C-b>"] = actions.results_scrolling_right,
	["<PageUp>"] = actions.nop,
	["<PageDown>"] = actions.nop,
	["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
	["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
	["<C-l>"] = actions.complete_tag,
	["<C-/>"] = actions.which_key,
	["<C-w>"] = { "<c-s-w>", type = "command" },
	["<C-r><C-w>"] = actions.insert_original_cword,
}

require("telescope").setup({
	defaults = {
		mappings = {
			i = ta,
			n = ta,
		},
		wrap_results = true,
		layout_config = {
			horizontal = { width = 0.95, height = 0.99 },
			vertical = { width = 0.98, height = 0.98 },
		},
		layout_strategy = "vertical",
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
		max_name_length = 17,
		numbers = "none",
		themable = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_duplicate_prefix = false,
		always_show_bufferline = true,
	},
})

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------

-- clears the search highlight
map("n", "<C-L>", ":nohlsearch<cr><C-L>")

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
			"<Cmd>BufferLinePick<cr>",
			"Pick Buffer",
		},
		b = {
			name = "Bufferline",
			p = {
				"<Cmd>BufferLineTogglePin<cr>",
				"Toggle Pin",
			},
			c = {
				"<Cmd>bd<cr>",
				"Close buffer",
			},
			n = { "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
			o = { "<Cmd>BufferLineCloseOthers<CR>", "Close Other Buffers" },
			r = { "<Cmd>BufferLineCloseRight<CR>", "Delete buffers to the right" },
			l = { "<Cmd>BufferLineCloseLeft<CR>", "Delete buffers to the left" },
		},
		e = {
			name = "Errors",
			e = {
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				"Show Diagnostic For Error",
			},
			j = {
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev()<CR>",
				"Prev Diagnostic",
			},
		},
		g = {
			name = "Git",
			b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
			d = { "<cmd>Gitsigns preview_hunk<CR>", "Diff" },
			j = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
			k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
			r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
			s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
			u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" },
			h = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlights" },
			v = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle current line blame" },
			w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Toggle word diff" },
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
		o = {
			name = "Oil",
			o = {
				"<cmd>Oil<cr>",
				"Open Oil",
			},
		},
		t = {
			name = "Telescope",
			c = {
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ layout_strategy = 'horizontal' })<cr>",
				"Fuzzy Search Current Buffer",
			},
			d = {
				"<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
				"Go to or show definiton",
			},
			e = {
				"<cmd>lua require('telescope.builtin').diagnostics({ initial_mode = 'normal', path_display='hidden', wrap_results = true })<cr>",
				"List Errors For Buffers",
			},

			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files in current directory" },
			q = {
				"<cmd>lua require('telescope.builtin').help_tags()<cr>",
				"Help Tags",
			},
			m = {
				"<cmd>lua require('telescope.builtin').marks()<cr>",
				"Marks",
			},
			n = {
				"<cmd>Telescope noice<cr>",
				"Show Notification History",
			},
			h = { "<cmd>lua require('telescope.builtin').search_history()<cr>", "Search History" },
			j = { "<cmd>lua require('telescope.builtin').jumplist()<cr>", "Jump List" },
			g = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Show git files" },
			o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Recent Files" },
			r = { "<cmd>Telescope registers<cr>", "Registers" },
			s = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep Cursor Word" },
			t = { "<cmd>Telescope git_files<cr>", "Gitfiles (working directory)" },
		},
	},
}, {
	window = {
		border = "single",
		position = "top",
	},
	show_help = false,
})

----------------------------------------------------------------------
-- Mini
----------------------------------------------------------------------

require("mini.surround").setup()
require("mini.comment").setup({
	mappings = {
		-- Normal and Visual modes
		comment = "gc",
		-- Toggle comment on current line
		comment_line = "gcc",
		-- Toggle comment on visual selection
		comment_visual = "gc",
		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		textobject = "gc",
	},
})

-- gutter
o.signcolumn = "yes:1"
