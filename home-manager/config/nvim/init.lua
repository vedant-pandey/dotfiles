--[[
=====================================================================
==================== GLOBAL INIT ====================================
=====================================================================
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Optional: Add some Netrw configuration
vim.g.netrw_banner = 0 -- Disable banner
vim.g.netrw_browse_split = 4 -- Open in previous window
vim.g.netrw_altv = 1 -- Open splits to the right
vim.g.netrw_liststyle = 1 -- Tree view

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
  "tpope/vim-sleuth",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
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

  -- { "catppuccin/nvim",      name = "catppuccin", priority = 1000 },
  { "sainnhe/everforest", name = "everforest", priority = 1000 },

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

  "justinmk/vim-sneak",
  "tpope/vim-surround",

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        -- java = false, -- don't check treesitter on java
      },
    }, -- this is equalent to setup({}) function
  },

  "ThePrimeagen/vim-be-good",

  {
    "nacro90/numb.nvim",
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
      DONE = { icon = "✅", color = "hint", alt = { "NOTE" } },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "akinsho/bufferline.nvim",
    -- version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  "moll/vim-bbye",
  "kevinhwang91/nvim-bqf",

  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      home = vim.fn.expand("~/personal/notes/telekasten"),
    },
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
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {},
  },

  "ziglang/zig.vim",

  "tpope/vim-dadbod",
  -- 'vrischmann/tree-sitter-templ',
  -- 'github/copilot.vim',

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      -- Only needed if you want to use session lens
      "nvim-telescope/telescope.nvim",
    },

    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }, -- if you prefer nvim-web-devicons
    opts = {},
  },

  "yamatsum/nvim-cursorline",

  {
    "stevearc/conform.nvim",
    opts = {},
  },

  {
    "chipsenkbeil/org-roam.nvim",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "~/personal/dotfiles/notes/orgmode",
      })
    end,
  },

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/personal/dotfiles/notes/orgmode/**/*",
        org_default_notes_file = "~/personal/dotfiles/notes/orgmode/refile.org",
        org_deadline_warning_days = 7,
        org_todo_keywords = {
          "Unplanned(u)",
          "Todo(t)",
          "InProgress(i)",
          "|",
          "Reassigned(r)",
          "Deprioritised(d)",
          "Finished(f)",
        },
        org_todo_keyword_faces = {
          Unplanned = ":foreground #333333 :background #E5E5E5",
          Todo = ":background #FFE5E5 :foreground #CC0000",
          InProgress = ":background #E5F2FF :foreground #0066CC",
          Reassigned = ":background #FFF3E5 :foreground #CC6600",
          Deprioritised = ":background #F2E5FF :foreground #6600CC",
          Finished = ":background #E5FFE5 :foreground #006600",
        },
        calendar_week_start_day = 0,
        org_agenda_span = "day",
        org_startup_folded = "showeverything",
        mappings = {
          org = {
            org_todo = "gl",
            org_todo_prev = "gh",
            org_priority_up = "gk",
            org_priority_down = "gj",
            org_toggle_checkbox = "<Leader>x",
            org_open_at_point = "gd",
          },
          agenda = {
            org_agenda_priority_up = "gk",
            org_agenda_priority_down = "gj",
          },
        },
      })
    end,
  },

  "dhruvasagar/vim-table-mode",
  {
    "mrshmllow/orgmode-babel.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "OrgExecute", "OrgTangle" },
    opts = {
      -- by default, none are enabled
      langs = { "python", "lua", "shell", "java", "ocaml", "go", "latex" },

      -- paths to emacs packages to additionally load
      load_paths = {},
    },
  },

  "nvim-java/nvim-java",

  -- Lua
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 130,
        options = {},
      },
      plugins = {
        options = {},
      },
    },
  },

  "tpope/vim-abolish",
  "tpope/vim-repeat",

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  "akinsho/org-bullets.nvim",

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "tectonic"
    end,
  },

  "kshenoy/vim-signature",

  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  "lewis6991/gitsigns.nvim",

  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  "tpope/vim-tbone",

  {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { -- optional cmp completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
    -- { -- optional blink completion source for require statements and module annotations
    --   "saghen/blink.cmp",
    --   opts = {
    --     sources = {
    --       -- add lazydev to your completion providers
    --       default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    --       providers = {
    --         lazydev = {
    --           name = "LazyDev",
    --           module = "lazydev.integrations.blink",
    --           -- make lazydev completions top priority (see `:h blink.cmp`)
    --           score_offset = 100,
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}, {})

--[[
=====================================================================
==================== SETTING OPTIONS ================================
=====================================================================
--]]

vim.opt.listchars = {
  eol = "¬",
  tab = ">-",
  trail = "~",
  extends = ">",
  precedes = "<",
  multispace = "␣",
  space = "␣",
  lead = "␣",
  leadmultispace = "␣",
}
vim.o.background = "dark"
vim.o.scrolloff = 20
vim.o.relativenumber = true
vim.o.colorcolumn = "120,150"
vim.o.number = true
local tabLen = 4
vim.o.tabstop = tabLen
vim.o.softtabstop = tabLen
vim.o.shiftwidth = tabLen
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.cul = true
vim.o.whichwrap = "h,l"
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.linebreak = true
--
-- vim.wo.foldmethod = "manual"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldcolumn = "1" -- '0' is not bad
-- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 3
vim.o.foldenable = true

vim.cmd.colorscheme("everforest")

vim.loader.enable()

vim.g.loaded = 1

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
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>mz", "<cmd>ZenMode<cr>", { desc = "[M]ode [Z]en" })
vim.keymap.set("n", "<leader>ml", function()
  vim.opt.list = not vim.opt.list:get()
  vim.notify("List mode: " .. (vim.opt.list:get() and "ON" or "OFF"))
end, { desc = "[M]ode [L]ist" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setqflist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>qt", "<cmd>TodoTrouble<cr>", { desc = "Open [T]odo list" })
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Open [T]odo list" })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})

local function debug_keymap(key)
  local modes = { "n", "v", "x", "s", "o", "i", "l", "c", "t" }
  for _, mode in ipairs(modes) do
    local map = vim.fn.maparg(key, mode, false, true)
    if map and not vim.tbl_isempty(map) then
      print(string.format("Mode %s: %s -> %s (defined in %s)", mode, key, map.rhs, map.scriptfile or "Unknown"))
    end
  end
end

-- Usage example:
-- debug_keymap('<space>s')

-- You can also create a user command for easier debugging:
vim.api.nvim_create_user_command("DebugKeymap", function(opts)
  debug_keymap(opts.args)
end, { nargs = 1 })

require("render-markdown").setup({
  file_types = { "markdown", "quatro", "org", "orgagenda" },
  render_modes = { "n", "v", "i", "c" },
  heading = { position = "inline" },
  debounce = 100,
})

-- Disable zig.vim autoformat as it pauses the buffer
vim.g.zig_fmt_autosave = 0

require("oil").setup()
require("java").setup()
require("org-bullets").setup()

require("gitsigns").setup()

require("marks").setup({
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {},
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "org",
  callback = function()
    vim.keymap.set("i", "<leader><CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
      silent = true,
      buffer = true,
    })
  end,
})

--[[
=====================================================================
==================== TELESCOPE HISTORY SEARCH COMMAND ===============
=====================================================================
--]]

local function search_command_history()
  local history = vim.api.nvim_exec("history cmd", true)

  local lines = {}
  for line in history:gmatch("[^\r\n]+") do
    local _, command = line:match("^%s*(%d+)%s+(.+)")
    if command then
      table.insert(lines, 1, command) -- Insert at the beginning to reverse order
    end
  end

  -- Add the most recent command (which called this function)
  local most_recent = vim.fn.histget("cmd", -1)
  if most_recent and most_recent ~= "" then
    table.insert(lines, 1, most_recent)
  end

  -- Remove duplicates while preserving order
  local seen = {}
  local unique_lines = {}
  for _, line in ipairs(lines) do
    if not seen[line] then
      seen[line] = true
      table.insert(unique_lines, line)
    end
  end

  -- Use Telescope to search through the commands
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Command History",
      finder = require("telescope.finders").new_table({
        results = unique_lines,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, _)
        local actions = require("telescope.actions")
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          vim.fn.histadd("cmd", selection[1])
          -- Execute the selected command
          -- vim.cmd(selection[1])

          -- only write the current command without executing
          vim.api.nvim_feedkeys(":" .. selection[1], "n", true)
        end)
        return true
      end,
    })
    :find()
end

-- Create a user command to trigger the search
vim.api.nvim_create_user_command("SearchCommandHistory", search_command_history, {})

vim.keymap.set("n", "<leader>sx", search_command_history, { desc = "[S]earch e[X]ecuted commands" })

--[[
=====================================================================
==================== CONFIGURE TELESCOPE ============================
=====================================================================
--]]

-- Custom function to find the project root
local function custom_find_root(startpath)
  local function get_parent_dir_contains(startpath, target)
    local current = vim.fn.fnamemodify(startpath, ":p")
    while current ~= "/" do
      local check_path = current .. "/" .. target
      if vim.fn.isdirectory(check_path) == 1 then
        return current
      end
      current = vim.fn.fnamemodify(current, ":h")
    end

    -- Check root directory as well
    if vim.fn.isdirectory("/" .. target) == 1 then
      return "/"
    end

    return nil
  end
  -- Custom function to find directory containing target up the tree
  startpath = startpath or vim.fn.getcwd()

  -- First try to find .bemol directory
  local bemol_root = get_parent_dir_contains("release-info", startpath)
  if bemol_root then
    return bemol_root
  end

  -- Fallback to .git directory
  local git_root = get_parent_dir_contains(".git", startpath)
  if git_root then
    return git_root
  end

  -- If neither is found, return the current directory
  return startpath
end

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      "**/build/*",
      ".bemol/*",
      ".idea/*",
      "tmp/*",
    },
  },
})
local default_pickers = {
  find_files = {
    hidden = true,
  },
}
-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

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

-- Define theme mapping
local theme_mapping = {
  -- Specific picker names
  -- find_files = "ivy",
  -- live_grep = "ivy",
  -- -- Patterns (will be checked with string.match)
  -- ["^git"] = "dropdown",  -- All git-related pickers
  -- ["grep$"] = "ivy",      -- All pickers ending with 'grep'
  -- Default theme (used if no other matches are found)
  -- default = "ivy",
  default = "dropdown",
}

local function get_all_picker_names()
  local pickers = default_pickers

  -- Get built-in pickers
  for picker_name, _ in pairs(require("telescope.builtin")) do
    if type(require("telescope.builtin")[picker_name]) == "function" then
      table.insert(pickers, picker_name)
    end
  end

  -- Get custom pickers
  for picker_name, _ in pairs(require("telescope").extensions) do
    table.insert(pickers, picker_name)
  end

  -- Add any other custom pickers that might not be in extensions
  -- For example, if you have a custom picker named 'my_custom_picker':
  -- table.insert(pickers, 'my_custom_picker')
  return pickers
end

local function get_theme_for_picker(picker_name)
  -- Check for exact matches first
  if theme_mapping[picker_name] then
    return theme_mapping[picker_name]
  end
  -- Check for pattern matches
  for pattern, theme_name in pairs(theme_mapping) do
    if picker_name:match(pattern) then
      return theme_name
    end
  end
  -- Return default theme if no matches found
  return theme_mapping.default
end

local all_pickers = get_all_picker_names()

local pickers_config = {}
for _, picker_name in ipairs(all_pickers) do
  pickers_config[picker_name] = default_pickers[picker_name]

  if not pickers_config[picker_name] == nil then
    pickers_config[picker_name]["theme"] = get_theme_for_picker(picker_name)
  else
    pickers_config[picker_name] = { theme = get_theme_for_picker(picker_name) }
  end
  pickers_config[picker_name]["opts"] = { cwd = custom_find_root() }
end

require("telescope").setup({
  pickers = pickers_config,
})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set(
  "n",
  "<leader>sb",
  require("telescope.builtin").current_buffer_fuzzy_find,
  { desc = "Fuzzily [S]earch in current [B]uffer" }
)

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end

-- require("telescope").load_extension "file_browser"

vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
-- vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Search [F]iles" })
vim.keymap.set("n", "<leader>f", function()
  require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" } })
end, { desc = "Search [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

--[[
=====================================================================
==================== CONFIGURE TREESITTER ===========================
=====================================================================
--]]

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
      "elixir",
      "eex",
      "heex",
      "markdown",
      "ocaml",
      "latex",
      "java",
    },

    fold = { enable = true },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
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

          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          ["is"] = { query = "@local.scope.inner", query_group = "locals", desc = "Select language scope" },

          -- Bindings for ocaml
          ["al"] = "@let_binding.outer",
          ["am"] = "@module_binding.outer",
          ["ax"] = "@match_expression.outer",
          ["av"] = "@value_definition.outer",
          ["at"] = "@type_definition.outer",
          ["aC"] = "@class_definition.outer",
          ["aF"] = "@method_definition.outer",
          ["il"] = "@let_binding.inner",
          ["im"] = "@module_binding.inner",
          ["ix"] = "@match_expression.inner",
          ["iv"] = "@value_definition.inner",
          ["it"] = "@type_definition.inner",
          ["iC"] = "@class_definition.inner",
          ["iF"] = "@method_definition.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]l"] = "@let_binding.outer",
          ["]m"] = "@module_binding.outer",
          ["]x"] = "@match_expression.outer",
          ["]v"] = "@value_definition.outer",
          ["]t"] = "@type_definition.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]L"] = "@let_binding.outer",
          ["]M"] = "@module_binding.outer",
          ["]X"] = "@match_expression.outer",
          ["]V"] = "@value_definition.outer",
          ["]T"] = "@type_definition.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[l"] = "@let_binding.outer",
          ["[m"] = "@module_binding.outer",
          ["[x"] = "@match_expression.outer",
          ["[v"] = "@value_definition.outer",
          ["[t"] = "@type_definition.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[L"] = "@let_binding.outer",
          ["[M"] = "@module_binding.outer",
          ["[X"] = "@match_expression.outer",
          ["[V"] = "@value_definition.outer",
          ["[T"] = "@type_definition.outer",
        },
      },
      -- swap = {
      -- 	enable = true,
      -- 	swap_next = {
      -- 		["<leader>a"] = "@parameter.inner",
      -- 	},
      -- 	swap_previous = {
      -- 		["<leader>A"] = "@parameter.inner",
      -- 	},
      -- },
    },
  })
end, 0)

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
-- vim.opt.foldlevel = 3

vim.treesitter.query.set(
  "ocaml",
  "textobjects",
  [[
  (let_binding) @let_binding.outer
  (let_binding body: (_) @let_binding.inner)

  (module_binding) @module_binding.outer
  (module_binding body: (_) @module_binding.inner)

  (match_expression) @match_expression.outer
  (match_expression body: (_) @match_expression.inner)
]]
)

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

  nmap("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>lc", function()
    vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
  end, "Lsp: [C]ode Action")

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function()
    -- Disable the switch mappings
    vim.keymap.set("n", "<LocalLeader>s", "<Nop>", { buffer = true })
    vim.keymap.set("n", "<LocalLeader>S", "<Nop>", { buffer = true })
    -- Disable the type printing mappings
    vim.keymap.set("n", "<LocalLeader>t", "<Nop>", { buffer = true })
    vim.keymap.set("x", "<LocalLeader>t", "<Nop>", { buffer = true })
    -- Optionally, set your own mappings here
    -- For example:
    -- vim.keymap.set('n', '<LocalLeader>x', YourCustomFunction, { buffer = true })
  end,
})

-- document existing key chains
require("which-key").add({
  { "<leader>a", group = "t[A]b" },
  { "<leader>b", group = "[B]uffer" },
  { "<leader>d", group = "[D]ocument" },
  { "<leader>g", group = "[G]it" },
  { "<leader>h", group = "Git [H]unk" },
  { "<leader>r", group = "[R]ename" },
  { "<leader>s", group = "[S]earch" },
  { "<leader>t", group = "[T]oggle" },
  { "<leader>v", group = "[V]edant's Config" },
  { "<leader>w", group = "[W]orkspace" },
  { "<leader>z", group = "[Z] Session" },
  { "<leader>q", group = "[Q]uickfix" },
  { "<leader>l", group = "[L]SP" },
  { "<leader>m", group = "[M]odes" },
  { "<leader>o", group = "[M]odes" },
  { "<leader>n", group = "[N] Org Roam" },
  { "<leader>na", group = "[A]lias" },
  { "<leader>nd", group = "[D]ate" },
  { "<leader>no", group = "[O]rigin" },
  { "<leader>c", group = "[C]url" },
  { "<leader>cc", group = "[C]url [C]ollection" },
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require("which-key").add({
  { "<leader>", group = "VISUAL <leader>" },
  { "<leader>h", group = "Git [H]unk" },
  { "<leader>v", group = "[V]edant's Config" },
}, { mode = "v" })

-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

vim.g["go_fmt_autosave"] = 0

vim.filetype.add({ extension = { templ = "templ" } })
local servers = {
  nextls = {},
  elixirls = {},
  gopls = {
    formatting = false,
  },
  -- nil_ls = {},
  bashls = {},
  pylsp = {},
  templ = {},
  html = { filetypes = { "html", "templ", "heex" } },
  htmx = { filetypes = { "html", "templ" } },
  tailwindcss = {
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  },
  -- pyright = {},
  rust_analyzer = {},
  jdtls = {},
  -- zls = {},
  -- ocamllsp = {
  -- 	filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
  -- },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = true,
        -- Use stylua instead of the built-in formatter
        defaultConfig = {
          indent_style = "Tabs",
          indent_size = "2",
        },
      },
    },
  },
}

vim.lsp.set_log_level("debug")

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig").ocamllsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require("lspconfig").zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require("lspconfig").clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

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
==================== CONFIGURE FORMATTER ============================
=====================================================================
--]]
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    ocaml = { "ocamlformat" },
    sh = { "beautysh" },
    go = { "gofmt", "golines", "goimports" },
    c = { "clang-format" },
    templ = { "templ" },
  },

  formatters = {
    stylua = {
      prepend_args = {
        "--indent-type=Spaces",
        "--indent-width=2",
        "--quote-style=AutoPreferDouble",
        "--column-width=120",
      },
    },
    ocamlformat = {
      -- Using Jane Street profile with minimal overrides
      prepend_args = {
        "--profile=janestreet",
      },
    },
  },
})

require("conform").formatters["clang-format"] = {
  args = {
    -- "--Werror",
    "--style={BasedOnStyle: llvm, IndentWidth: 4, ColumnLimit: 120}",
  },
}

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

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
  require("conform").format({
    async = true,
    lsp_fallback = true,
  })
end, { desc = "[L]ang [F]ormat" })

--[[
=====================================================================
==================== CONFIGURE NVIM-CMP =============================
=====================================================================
--]]
local cmp = require("cmp")
local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
ls.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
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
  }),
  sources = {
    { name = "nvim_lsp" },
    -- { name = "luasnip" },
    { name = "path" },
    { name = "orgmode" },
    { name = "go_pkgs" },
  },
  matching = { disallow_symbol_nonprefix_matching = false },
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
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

vim.keymap.set({ "i" }, "<C-K>", function()
  ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

ls.add_snippets("java", {
  s("cc", {
    t({ "import java.util.Scanner;", "", "" }),
    t("public class "),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE or {}
    end),
    t({ " {", "\t" }),
    t({ "public static void main(String[] args) {", "\t\t" }),
    t({ "Scanner sc = new Scanner(System.in);", "\t\t" }),
    i(1, "int"),
    t(" "),
    i(2, "n"),
    t(" = sc."),
    i(3, "nextInt"),
    t({ "();", "\t\t" }),
    i(4, ""),
    t({ "", "\t\t" }),
    t({ "sc.close();", "\t\t" }),
    i(0),
    t({ "", "\t}", "}" }),
  }),
})

ls.add_snippets("go", {
  s("iferr", {
    t({ "if err != nil {", "\t" }),
    i(1, 'log.Fatalf("Error - %v", err)'),
    t({ "", "}", "" }),
    i(0),
  }),
})

ls.add_snippets("go", {
  s("pacman", {
    t({ "package main", "", "func main() {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
})

ls.add_snippets("go", {
  s("cc", {
    t({
      "package main",
      "",
      "func main() {",
      "\tscanner := bufio.NewReader(os.Stdin)",
      "\tlineBytes, _, _ := scanner.ReadLine()",
      "\tn, _ := strconv.Atoi(string(lineBytes))",
      "\t",
    }),
    i(0),
    t({ "", "}" }),
  }),
})

--[[
=====================================================================
==================== Amazon Config ==================================
=====================================================================
--]]

-- [[ Barium support ]]
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- https://w.amazon.com/bin/view/Barium/#HVimandNeovim
-- Remove hyphen because it breaks vim/neovim
-- vim.filetype.add({ filename = { Config = "brazilconfig" } })

-- Check if the config is already defined (useful when reloading this file)
if not configs.barium then
  configs.barium = {
    default_config = {
      cmd = { "barium" },
      filetypes = { "brazil-config" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end,
      settings = {},
    },
  }
end

lspconfig.barium.setup({})

-- [[ Add support for Bemol folders ]]
-- https://w.amazon.com/bin/view/Bemol/#HnvimbuiltinLSP28withlsp-configand2Forlsp-zero29
local function bemol()
  -- Find bemol directory based on current working directory, not parent directory of current buffer.
  local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
  local ws_folders_lsp = {}
  if bemol_dir then
    vim.notify(".bemol directory found: " .. bemol_dir, vim.log.levels.INFO)
    local file = io.open(bemol_dir .. "/ws_root_folders", "r")
    if file then
      for line in file:lines() do
        table.insert(ws_folders_lsp, line)
      end
      file:close()
    end
  end

  for _, line in ipairs(ws_folders_lsp) do
    vim.lsp.buf.add_workspace_folder(line)
  end

  return ws_folders_lsp
end

-- Should be rarely needed because of auto command defined below
vim.api.nvim_create_user_command("BemolAdditions", bemol, {
  desc = "Add bemol detected workspace folders",
})

vim.api.nvim_create_autocmd("LspAttach", {
  -- Should stack with existing autogroup for defining keymaps, etc.
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),

  -- bemol supports multiple workspace roots for Java, Python, and Ruby Brazil workspaces.
  -- https://w.amazon.com/bin/view/Bemol/#HBrazilPlugins
  pattern = { "*.java", "*.py", "*.rb" },

  callback = function(args)
    bemol()
  end,
})

require("ufo").setup()

vim.cmd([[
" ============================================================================
" File:        fugitive-gitfarm.vim
" Maintainer:  Benoît Taine <btaine@amazon.com>
" ============================================================================

function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction

function! s:gitfarm_url(opts) abort
  if a:0 || type(a:opts) != type({})
    return ''
  endif
  let default_domain = 'git\.amazon\.com'
  let domain = exists('g:fugitive_gitfarm_domain') ? g:fugitive_gitfarm_domain : default_domain
  let repo = matchstr(get(a:opts, 'remote'), '^ssh://\(\w\+@\)\?' . domain . '\(:\d\+\)\?/pkg/\w\+$')
  if repo ==# ''
    return ''
  endif
  let package = split(repo, '/')[4]
  let path = substitute(a:opts.path, '^/', '', '')
  let root = 'https://code.amazon.com/packages/' . package
  if path =~# '^\.git/\%(config$\|hooks\>\)'
    return root . '/repo-info'
  elseif path =~# '^\.git\>'
    return root
  endif
  if a:opts.commit =~# '^\d\=$'
    let commit = a:opts.repo.rev_parse('HEAD')
  else
    let commit = a:opts.commit
  endif
  if get(a:opts, 'type', '') ==# 'tree' || a:opts.path =~# '/$'
    let url = substitute(root . '/trees/' . commit . '/--/' . path, '/$', '', 'g')
  elseif get(a:opts, 'type', '') ==# 'blob' || a:opts.path =~# '[^/]$'
    let url = root . '/blobs/' . commit . '/--/' . path
    if get(a:opts, 'line2')
      let url .= '#L' . a:opts.line1
      " Linking a range of lines
      if a:opts.line1 != a:opts.line2
        let url .= '-L' . a:opts.line2
      endif
    endif
  else
    let url = root . '/commits/' . commit
  endif
  return url
endfunction

if !exists('g:fugitive_browse_handlers')
  let g:fugitive_browse_handlers = []
endif

call insert (g:fugitive_browse_handlers, s:function('s:gitfarm_url'))
]])

--[[
=====================================================================
==================== PERSONAL KEYMAPS ===============================
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
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
vim.keymap.set("n", "<M-j>", ":m .+1<CR>", { desc = "Move text down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>", { desc = "Move text up" })
vim.keymap.set("v", "<M-J>", ":t '><CR>gv=gv", { desc = "Copy text down" })
vim.keymap.set("v", "<M-K>", ":t '<-1<CR>", { desc = "Copy text up" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>", { desc = "Move text up" })
vim.keymap.set("v", "<M-J>", ":t '><CR>gv=gv", { desc = "Copy text down" })
vim.keymap.set("v", "<M-K>", ":t '<-1<CR>V'.", { desc = "Copy text up" })
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
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up" })
vim.keymap.set("n", "<leader>ax", "<cmd>tabclose<cr>", { desc = "t[A]b [X] close" })
vim.keymap.set("n", "<leader>an", "<cmd>tabnew<cr>", { desc = "t[A]b [N]ew" })
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
vim.keymap.set("n", "<leader>bX", ":Bdelete!<CR>", { desc = "[B]uffer e[X]it" })
vim.keymap.set("n", "<leader>bn", ":ene<CR>", { desc = "[B]uffer [N]ew" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all buffers to the left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all buffers to the right" })
vim.keymap.set("n", "<leader>br", "<cmd>e<CR>zz", { desc = "Refresh current buffer" })
--
vim.keymap.set("n", "<leader>;", "<cmd>vsplit %<CR>", { desc = "[;] Split vertical" })
vim.keymap.set("n", "<leader>'", "<cmd>split %<CR>", { desc = "['] Split horizontal" })
vim.keymap.set("n", "<leader>vx", "<cmd>!chmod +x %<cr>", { desc = "Make current file e[X]ecutable" })
vim.keymap.set("n", "<leader>vh", "<cmd>!home-manager switch --show-trace<CR>", { desc = "[H]ome manager switch" })
vim.keymap.set("n", "<leader>va", "ggVG", { desc = "Select [A]ll text" })
vim.keymap.set("n", "<leader>v.", "<cmd>!echo %<cr>", { desc = "[.]Where am I?" })

vim.keymap.set("n", "<leader>ga", ":Git blame<CR>", { desc = "[G]it bl[A]me" })
vim.keymap.set("n", "<leader>gb", ":GBrowse<CR>", { desc = "[G]it [B]rowse" })
vim.keymap.set("n", "<leader>gc", ":GBrowse!<CR>", { desc = "[G]it [C]opy link" })
vim.keymap.set("v", "<leader>gc", ":'<,'>GBrowse!<CR>", { desc = "[G]it [C]opy link" })
vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "[G]it [G]o" })
vim.keymap.set("n", "<F8>", "<cmd>DapNew<cr>", { desc = "Run debugger" })
vim.keymap.set("n", "<F6>", "<cmd>DapStepInto<cr>", { desc = "Run debugger" })
vim.keymap.set("n", "<S-F6>", "<cmd>DapStepOut<cr>", { desc = "Run debugger" })
vim.keymap.set("n", "<F7>", "<cmd>DapStepOver<cr>", { desc = "Run debugger" })
vim.keymap.set("n", "<F5>", "<cmd>DapToggleBreakpoint<cr>", { desc = "Run debugger" })

vim.keymap.set("n", "<leader>zr", "<cmd>SessionRestore<cr>", { desc = "Session Restore" })
vim.keymap.set("n", "<leader>zs", "<cmd>SessionSave<cr>", { desc = "Session Save" })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "File explorer" })
vim.keymap.set(
  { "v", "n" },
  "<S-home>",
  "<cmd>lua require('orgmode').action('org_mappings.org_babel_tangle')<CR>",
  { desc = "File explorer" }
)

local curl = require("curl")
curl.setup({})

vim.keymap.set("n", "<leader>ct", curl.open_curl_tab, { desc = "Directory scoped Curl tab" })
vim.keymap.set("n", "<leader>cg", curl.open_global_tab, { desc = "Global scoped Curl tab" })
vim.keymap.set("n", "<leader>cct", curl.create_scoped_collection, { desc = "Create or open a collection" })
vim.keymap.set("n", "<leader>ccg", curl.create_global_collection, { desc = "Create or open a global collection" })
vim.keymap.set("n", "<leader>ccT", curl.pick_scoped_collection, { desc = "Select a scoped collection and open it" })
vim.keymap.set("n", "<leader>ccG", curl.pick_global_collection, { desc = "Select a global collection and open it" })
