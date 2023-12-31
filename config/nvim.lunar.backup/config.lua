lvim.colorscheme = "catppuccin"
lvim.plugins = {
	{ "ThePrimeagen/vim-be-good" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				default_mappings = true, -- whether to map keybinds or not. default true
				builtin_marks = { ".", "<", ">", "^" }, -- which builtin marks to show. default {}
				cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
				force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
				refresh_interval = 1000, -- how often (in ms) to redraw signs/recompute mark positions.
				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 22 }, -- sign priorities for each type of mark
				excluded_filetypes = {}, -- disables mark tracking for specific filetypes. default {}
				bookmark_0 = {
					sign = "⚑",
					virt_text = "BM0",
					annotate = true,
				},
				mappings = {
					preview = "<leader>bm",
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"rhysd/git-messenger.vim",
	},
	{
		"kevinhwang91/nvim-bqf",
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"elixir-tools/elixir-tools.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local elixir = require("elixir")
			local elixirls = require("elixir.elixirls")

			elixir.setup({
				nextls = { enable = true },
				credo = {},
				elixirls = {
					enable = true,
					settings = elixirls.settings({
						dialyzerEnabled = false,
						enableTestLenses = false,
					}),
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
					end,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}

-- basic stuff
lvim.keys.normal_mode["<leader>q"] = ":q<cr>"
lvim.keys.normal_mode["<leader>a"] = ":qa<cr>"
lvim.keys.normal_mode["<leader>h"] = ":noh<CR>"
lvim.keys.normal_mode["<leader>w"] = ":w<cr>"
lvim.keys.insert_mode["jk"] = "<esc>"
lvim.keys.normal_mode["<BS>"] = [["_X]]
lvim.keys.normal_mode["<leader>D"] = [["_D]]
lvim.keys.visual_mode["<leader>D"] = [["_D]]
lvim.keys.normal_mode["<leader>d"] = [["_d]]
lvim.keys.visual_mode["<leader>d"] = [["_d]]

lvim.keys.normal_mode["<leader>p"] = [["+P<CR>]]
lvim.keys.visual_mode["<leader>p"] = [["_d"+P<CR>]]
lvim.keys.normal_mode["<leader>y"] = [["+y]]
lvim.keys.visual_mode["<leader>y"] = [["+y]]
lvim.keys.normal_mode["<leader>va"] = "ggVG"

lvim.keys.visual_mode["<M-j>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<M-k>"] = ":m '<-2<CR>gv=gv"
lvim.keys.normal_mode["<M-j>"] = ":m .+1<CR>"
lvim.keys.visual_mode["<M-J>"] = ":t '><CR>gv=gv"
lvim.keys.visual_mode["<M-K>"] = ":t '<-1<CR>"
lvim.keys.normal_mode["<M-k>"] = ":m .-2<CR>"
lvim.keys.normal_mode["<M-J>"] = ":t .<CR>"
lvim.keys.normal_mode["<M-K>"] = ":t .-1<CR>"

lvim.keys.normal_mode["<C-l>"] = "<C-w><C-l>"
lvim.keys.normal_mode["<C-h>"] = "<C-w><C-h>"
lvim.keys.normal_mode["<C-j>"] = "<C-w><C-j>"
lvim.keys.normal_mode["<C-k>"] = "<C-w><C-k>"
lvim.keys.normal_mode["<M-W>"] = "<C-w>="

-- Lunar vim remaps
lvim.keys.visual_mode["<leader>v;"] = "g<C-g>"
lvim.keys.normal_mode["<leader>vn"] = ":ene<CR>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"
-- lvim.keys.normal_mode["n"] = "nzzzv"
-- lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<C-n>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>x"] = "<cmd>BufferKill<CR>"

-- Nvim tree
lvim.keys.normal_mode["<leader>e"] = "<cmd>NvimTreeToggle<cr>"
lvim.keys.normal_mode["<leader>gg"] = "<cmd>LazyGit<cr>"

-- LSP keymaps
lvim.keys.normal_mode["<leader>li"] = "<cmd>LspInfo<cr>"
lvim.keys.normal_mode["<leader>/"] = "<Plug>(comment_toggle_linewise_current)"
lvim.keys.visual_mode["<leader>/"] = "<Plug>(comment_toggle_linewise_visual)"
lvim.keys.normal_mode["<C-f>"] = "<cmd>silent !tmux neww t-sesh<CR>"
lvim.keys.normal_mode["<C-g>"] = "<cmd>silent !tmux neww cheet<CR>"

lvim.keys.normal_mode["<leader>;"] = "<cmd>vsplit %<CR>"
lvim.keys.normal_mode["<leader>'"] = "<cmd>split %<CR>"
lvim.keys.normal_mode["<leader>Q"] = "<cmd>qa!<CR>"

lvim.keys.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["<leader>z"] = "$zf%"
lvim.keys.normal_mode["<leader>m"] = "<cmd>Telescope marks<cr>"
lvim.keys.normal_mode["<leader>tq"] = "<cmd>TodoQuickFix<cr>"
lvim.keys.normal_mode["<leader>tt"] = "<cmd>TodoTelescope<cr>"
lvim.keys.normal_mode["<leader>tr"] = "<cmd>TodoTrouble<cr>"

lvim.keys.normal_mode["<leader>vk"] = "<cmd>silent !ssh-add -D<cr>"
lvim.keys.normal_mode["<leader>vx"] = "<cmd>!chmod +x %<cr>"

lvim.keys.normal_mode[">"] = ">>"
lvim.keys.normal_mode["<"] = "<<"

lvim.keys.normal_mode["<leader>vf"] = ":silent !gofmt -s -w %<cr>"

lvim.keys.visual_mode["<leader>vs"] = [["hy:%s/<C-r>h/<C-r>h/gc<left><left><left>]]
lvim.keys.normal_mode["<leader>vs"] = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]

lvim.keys.normal_mode["<leader>["] = "<C-x>"
lvim.keys.normal_mode["<leader>]"] = "<C-a>"
lvim.keys.normal_mode["<leader>sw"] = ":Telescope grep_string<cr>"

lvim.keys.normal_mode["<leader>gp"] = ":lua require('goto-preview').goto_preview_definition()<cr>"

lvim.keys.normal_mode["<leader>ui"] = ":DBUIToggle<cr>"

require("todo-comments").setup()
require("elixir").setup({
	nextls = { enable = false },
	credo = { enable = true },
	elixirls = { enable = true },
})

vim.opt.so = 16
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.sw = 4
vim.opt.et = true
vim.opt.si = true
vim.opt.wrap = true
vim.opt.ww = "h,l"
vim.opt.tgc = true
vim.opt.ic = true
vim.opt.clipboard = ""

require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
		},
	},
})

require("cmp").setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
})
