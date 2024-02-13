--[[
=====================================================================
==================== GLOBAL INIT ====================================
=====================================================================
--]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[
=====================================================================
==================== PLUGIN CONFIGURATION ===========================
=====================================================================
--]]
require("lazy").setup({
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",  -- Detect tabstop and shiftwidth automatically
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
	"L3MON4D3/LuaSnip",
	build = (function()
	  -- Build Step is needed for regex support in snippets
	  -- This step is not supported in many windows environments
	  -- Remove the below condition to re-enable on windows
	  if vim.fn.has("win32") == 1 then
	    return
	  end
	  return "make install_jsregexp"
	end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
  },

  { "folke/which-key.nvim", opts = {} },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
	add = { text = "+" },
	change = { text = "~" },
	delete = { text = "_" },
	topdelete = { text = "‾" },
	changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
	  opts = opts or {}
	  opts.buffer = bufnr
	  vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map({ "n", "v" }, "]c", function()
	  if vim.wo.diff then
	    return "]c"
	  end
	  vim.schedule(function()
	    gs.next_hunk()
	  end)
	  return "<Ignore>"
	  end, { expr = true, desc = "Jump to next hunk" })

	map({ "n", "v" }, "[c", function()
	  if vim.wo.diff then
	    return "[c"
	  end
	  vim.schedule(function()
	    gs.prev_hunk()
	  end)
	  return "<Ignore>"
	  end, { expr = true, desc = "Jump to previous hunk" })

	-- Actions
	-- visual mode
	map("v", "<leader>hs", function()
	  gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	  end, { desc = "stage git hunk" })
	map("v", "<leader>hr", function()
	  gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	  end, { desc = "reset git hunk" })
	-- normal mode
	map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
	map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
	map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
	map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
	map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
	map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
	map("n", "<leader>hb", function()
	  gs.blame_line({ full = false })
	  end, { desc = "git blame line" })
	map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
	map("n", "<leader>hD", function()
	  gs.diffthis("~")
	  end, { desc = "git diff against last commit" })

	-- Toggles
	map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
	map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
      end,
    },
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
	icons_enabled = false,
	theme = "auto",
	component_separators = "|",
	section_separators = "",
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },

  { "numToStr/Comment.nvim", opts = {} },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
	cond = function()
	  return vim.fn.executable("make") == 1
	end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
	sort_by = "case_sensitive",
	view = {
	  width = 30,
	},
	renderer = {
	  group_empty = true,
	},
	filters = {
	  git_ignored = false,
	  dotfiles = false,
	},
	update_focused_file = {
	  enable = true,
	},
      }
    end,
  },

  'justinmk/vim-sneak',
  'tpope/vim-surround',

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {  check_ts = true, -- enable treesitter
      ts_config = {
	lua = { "string" }, -- don't add pairs in lua string treesitter nodes
	javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
	java = false, -- don't check treesitter on java
      },
    } -- this is equalent to setup({}) function
  },

  {
    'yamatsum/nvim-cursorline',
    opts = {
      cursorline = {
	enable = true,
	timeout = 1000,
	number = false,
      },
      cursorword = {
	enable = true,
	min_length = 3,
	hl = { underline = true },
      }
    }
  },

  'ThePrimeagen/vim-be-good',

  {
    'nacro90/numb.nvim',
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
  },

  'moll/vim-bbye',
  'kevinhwang91/nvim-bqf',

  {
    'renerocksai/telekasten.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'renerocksai/calendar-vim',
    },
    opts = {
      home = vim.fn.expand("~/personal/notes/telekasten"),
    }
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'kevinhwang91/nvim-ufo',
    opts = {},
  },

  'ziglang/zig.vim',
}, {})

--[[
=====================================================================
==================== SETTING OPTIONS ================================
=====================================================================
--]]
vim.o.scrolloff = 16
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.whichwrap = "h,l"
vim.o.termguicolors = true
vim.o.ignorecase = true

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.cmd.colorscheme("catppuccin")

vim.loader.enable()

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--[[
=====================================================================
==================== PERSONAL CONFIGURATION =========================
=====================================================================
--]]
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>qt", "<cmd>TodoTrouble<cr>", { desc = "Open [T]odo list" })
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Open [T]odo list" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--[[
=====================================================================
==================== CONFIGURE TELESCOPE ============================
=====================================================================
--]]
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
	["<C-u>"] = false,
	["<C-d>"] = false,
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sb", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fuzzily [S]earch in current [B]uffer" })

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Search [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

--[[
=====================================================================
==================== CONFUGURE TREESITTER ===========================
=====================================================================
-- --]]
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "tsx",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "bash",
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
	init_selection = "<C-space>",
	node_incremental = "<C-space>",
	scope_incremental = "<C-s>",
	node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
	enable = true,
	lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
	keymaps = {
	  -- You can use the capture groups defined in textobjects.scm
	  ["aa"] = "@parameter.outer",
	  ["ia"] = "@parameter.inner",
	  ["af"] = "@function.outer",
	  ["if"] = "@function.inner",
	  ["ac"] = "@class.outer",
	  ["ic"] = "@class.inner",
	},
      },
      move = {
	enable = true,
	set_jumps = true, -- whether to set jumps in the jumplist
	goto_next_start = {
	  ["]m"] = "@function.outer",
	  ["]]"] = "@class.outer",
	},
	goto_next_end = {
	  ["]M"] = "@function.outer",
	  ["]["] = "@class.outer",
	},
	goto_previous_start = {
	  ["[m"] = "@function.outer",
	  ["[["] = "@class.outer",
	},
	goto_previous_end = {
	  ["[M"] = "@function.outer",
	  ["[]"] = "@class.outer",
	},
      },
      swap = {
	enable = true,
	swap_next = {
	  ["<leader>a"] = "@parameter.inner",
	},
	swap_previous = {
	  ["<leader>A"] = "@parameter.inner",
	},
      },
    },
  })
end, 0)

--[[
=====================================================================
==================== CONFIGURE LSP ==================================
=====================================================================
--]]
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", function()
    vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
    end, "[C]ode [A]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-;>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").register({
  ["<leader>b"] = { name = "[B]uffer", _ = "which_key_ignore" },
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
  ["<leader>v"] = { name = "[V]edant's Config", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
  ["<leader>z"] = { name = "[Z] Telekasten", _ = "which_key_ignore" },
  ["<leader>q"] = { name = "[Q]uickfix", _ = "which_key_ignore" },
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require("which-key").register({
  ["<leader>"] = { name = "VISUAL <leader>" },
  ["<leader>h"] = { "Git [H]unk" },
  ["<leader>v"] = { "[V]edant's Config" },
}, { mode = "v" })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = {
	globals = { 'vim' },
      },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Give nvim-ufo ability to create folds using LSP
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

--[[
=====================================================================
==================== CONFIGURE NVIM-CMP =============================
=====================================================================
--]]
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
	luasnip.expand_or_jump()
      else
	fallback()
      end
      end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
	luasnip.jump(-1)
      else
	fallback()
      end
      end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--[[
=====================================================================
==================== PERSONAL CONFIGURATION =========================
=====================================================================
--]]
-- basic stuff
vim.keymap.set("n", "<C-c>", ":noh<CR>", { desc = "Highlight off" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Normal mode" })
vim.keymap.set("n", "<BS>", [["_X]], { desc = "Backspace" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to clipboard" })
vim.keymap.set("n", "<leader>p", [["+P<CR>]], { desc = "[P]aste from clipboard" })
vim.keymap.set("v", "<leader>p", [["_d"+P<CR>]], { desc = "[P]aste from clipboard" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move text up"} )
vim.keymap.set("n", "<M-j>", ":m .+1<CR>", { desc = "Move text down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>", { desc = "Move text up" })
vim.keymap.set("v", "<M-J>", ":t '><CR>gv=gv", { desc = "Copy text down" })
vim.keymap.set("v", "<M-K>", ":t '<-1<CR>", { desc = "Copy text up" })
vim.keymap.set("n", "<M-J>", ":t .<CR>", { desc = "Copy text down" })
vim.keymap.set("n", "<M-K>", ":t .-1<CR>", { desc = "Copy text up" })
vim.keymap.set("n", "<", "<<", { desc = "Indent down" })
vim.keymap.set("n", ">", ">>", { desc = "Indent up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent down" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent up" })
--
-- -- window stuff
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Window right" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Window up" })
vim.keymap.set("n", "<M-W>", "<C-w>=", { desc = "Window equalize" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Move up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "[/] Comment selection" })
vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "[/] Comment selection" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww t-sesh<CR>", { desc = "t-sesh find projects" })
--
-- -- set after plugin installs
vim.keymap.set("n", "<C-n>", "<cmd>BufferLineCycleNext<CR>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<C-p>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Goto prev buffer" })
vim.keymap.set("n", "<leader>bq", ":q<cr>", { desc = "[B]uffer [Q]uit" })
vim.keymap.set("n", "<leader>ba", ":qa<cr>", { desc = "[B]uffer quit [A]ll" })
vim.keymap.set("n", "<leader>bw", ":w<cr>", { desc = "[B]uffer [W]rite" })
vim.keymap.set("n", "<leader>bx", ":Bdelete<CR>", { desc = "[B]uffer e[X]it" })
vim.keymap.set("n", "<leader>bn", ":ene<CR>", { desc = "[B]uffer [N]ew" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all buffers to the left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all buffers to the right" })
--
vim.keymap.set("n", "<leader>;", "<cmd>vsplit %<CR>", { desc = "[;] Split vertical" })
vim.keymap.set("n", "<leader>'", "<cmd>split %<CR>", { desc = "['] Split horizontal" })
vim.keymap.set("n", "<leader>vx", "<cmd>!chmod +x %<cr>", { desc = "Make current file e[X]ecutable" })
vim.keymap.set("v", "<leader>vs", [["hy:%s/<C-r>h/<C-r>h/gc<left><left><left>]], { desc = "[S]earch selection" })
vim.keymap.set("n", "<leader>vs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S]earch selection" })
vim.keymap.set("n", "<leader>vh", "<cmd>!home-manager switch --show-trace<CR>", { desc = "[H]ome manager switch" })
vim.keymap.set("n", "<leader>va", "ggVG", { desc = "Select [A]ll text" })


vim.keymap.set("n", "<leader>zf", ":Telekasten find_notes<CR>", { desc = "[F]ind notes" })
vim.keymap.set("n", "<leader>zd", ":Telekasten find_daily_notes<CR>", { desc = "Find [D]aily notes" })
vim.keymap.set("n", "<leader>zg", ":Telekasten search_notes<CR>", { desc = "[G] Search notes" })
vim.keymap.set("n", "<leader>zz", ":Telekasten follow_link<CR>", { desc = "[Z] Follow link" })
vim.keymap.set("n", "<leader>zT", ":Telekasten goto_today<CR>", { desc = "Goto [T]oday" })
vim.keymap.set("n", "<leader>zW", ":Telekasten goto_thisweek<CR>", { desc = "Goto this [W]eek" })
vim.keymap.set("n", "<leader>zn", ":Telekasten new_note<CR>", { desc = "[N]ew note" })
vim.keymap.set("n", "<leader>zc", ":Telekasten show_calendar<CR>", { desc = "Show [C]alendar side" })
vim.keymap.set("n", "<leader>zt", ":Telekasten toggle_todo<CR>", { desc = "Toggle [T]odo" })
vim.keymap.set("n", "<leader>zb", ":Telekasten show_backlinks<CR>", { desc = "Show [B]acklinks" })
vim.keymap.set("n", "<leader>zr", ":Telekasten rename_note<CR>", { desc = "[R]ename note" })
vim.keymap.set("n", "<leader>zC", ":CalendarT<CR>", { desc = "Open [C]alendar" })
