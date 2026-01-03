--[[
=====================================================================
==================== GLOBAL INIT ====================================
=====================================================================
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Optional: Add some Netrw configuration
-- vim.g.netrw_banner = 1 -- Disable banner
-- vim.g.netrw_browse_split = 4 -- Open in previous window
-- vim.g.netrw_altv = 1 -- Open splits to the right
-- vim.g.netrw_liststyle = 1 -- Tree view
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
  "tikhomirov/vim-glsl",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      { "j-hui/fidget.nvim", opts = {} },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { "rafamadriz/friendly-snippets" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default", ["<CR>"] = { "select_and_accept", "fallback" } },

      enabled = function()
        return not vim.tbl_contains({ "DressingInput", "TelescopePrompt" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  { "folke/which-key.nvim", opts = {} },

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

  -- {
  --   -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = "ibl",
  --   opts = {},
  -- },

  {
    "numToStr/Comment.nvim",
    opts = {
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        -- line = "gcc",
        line = "<leader>/",
        ---Block-comment toggle keymap
        -- block = "gbc",
        block = "<localleader>/",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "<leader>/",
        ---Block-comment keymap
        block = "<localleader>/",
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = "<localleader>[",
        ---Add comment on the line below
        below = "<localleader>]",
        ---Add comment at the end of line
        eol = "<localleader>,",
      },
      ---Enable keybindings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = nil,
    },
  },

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
        -- javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        -- java = false, -- don't check treesitter on java
      },
    }, -- this is equalent to setup({}) function
  },

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
      keywords = {
        DONE = { icon = "✅", color = "hint", alt = { "NOTE" } },
        STEP = { icon = "➡️", color = "step", alt = { "STEP 1" } },
      },
      colors = {
        step = { "Identifier", "#FFFFFF" },
      },

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
    keys = {
      { "<C-n>", "<cmd>BufferLineCycleNext<CR>", desc = "Goto next buffer" },
      { "<C-p>", "<cmd>BufferLineCyclePrev<CR>", desc = "Goto prev buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close all buffers to the left" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close all buffers to the right" },
    },
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          ocaml = { "ocamlformat" },
          sh = { "beautysh" },
          go = { "gofmt", "golines", "goimports" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          templ = { "templ" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          zig = { "zigfmt" },
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
    end,
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({
            async = true,
            lsp_fallback = true,
          })
        end,
        mode = { "n", "v" },
        desc = "[L]ang [F]ormat",
      },
    },
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
    opts = {
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
    },
  },

  "dhruvasagar/vim-table-mode",

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = {
        enabled = true,
        size = 3 * 1024 * 1024, -- 1.5MB
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      -- words = { enabled = true },
    },
  },

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
    keys = {
      { "<leader>mz", "<cmd>ZenMode<cr>", { desc = "[M]ode [Z]en" } },
    },
  },

  "tpope/vim-repeat",

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "size",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    keys = {
      { "-", "<cmd>Oil<cr>", { desc = "[-] File explorer" } },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  },

  {
    "akinsho/org-bullets.nvim",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    -- opts = {},
    config = function()
      vim.keymap.set("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "[G]it [H]unk [S]tage" })
      vim.keymap.set("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "[G]it [H]unk [P]review" })
      vim.keymap.set("n", "]c", "<cmd>Gitsigns nav_hunk 'next'<cr>", { desc = "Next hunk" })
      vim.keymap.set("n", "[c", "<cmd>Gitsigns nav_hunk 'prev'<cr>", { desc = "Prev hunk" })
    end,
  },

  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
    keys = function(_, _)
      local curl = require("curl")
      return {
        { "<leader>ct", curl.open_curl_tab, { desc = "Directory scoped Curl tab" } },
        { "<leader>cg", curl.open_global_tab, { desc = "Global scoped Curl tab" } },
        { "<leader>cct", curl.create_scoped_collection, { desc = "Create or open a collection" } },
        { "<leader>ccg", curl.create_global_collection, { desc = "Create or open a global collection" } },
        { "<leader>ccT", curl.pick_scoped_collection, { desc = "Select a scoped collection and open it" } },
        { "<leader>ccG", curl.pick_global_collection, { desc = "Select a global collection and open it" } },
      }
    end,
  },

  "tpope/vim-tbone",

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

  {
    "hasansujon786/super-kanban.nvim",
    dependencies = {
      "folke/snacks.nvim", -- [required]
      "nvim-orgmode/orgmode", -- [optional] Org format support
    },
    opts = {
      orgmode = {
        notes_dir = "~/personal/dotfiles/notes/orgmode",
        default_template = {
          "** 💭 Backlog\n",
          "** 🖋 Todo\n",
          "** 🛠 Work in progress\n",
          "** 🏁 Completed\n",
          "*Complete*",
        },
      },
      mappings = {
        ["<cr>"] = "open_note",
        ["gD"] = "delete_card",
        ["<C-t>"] = "toggle_complete",
      },
    },
  },

  "tommcdo/vim-exchange",
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
vim.o.scrolloff = 30
vim.o.relativenumber = true
vim.o.colorcolumn = "120,150"
vim.o.number = true
local tabLen = 4
vim.o.tabstop = tabLen
vim.o.softtabstop = tabLen
vim.o.shiftwidth = tabLen
vim.o.smartindent = true
vim.o.wrap = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.linebreak = true
vim.o.cul = true
vim.o.whichwrap = "h,l"
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.linebreak = true
--
-- vim.wo.foldmethod = "manual"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldenable = true

vim.cmd.colorscheme("tokyonight-night")

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

vim.o.completeopt = "menuone,noselect"

--[[
=====================================================================
==================== PERSONAL CONFIGURATION =========================
=====================================================================
--]]

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

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

-- You can also create a user command for easier debugging:
vim.api.nvim_create_user_command("DebugKeymap", function(opts)
  local modes = { "n", "v", "x", "s", "o", "i", "l", "c", "t" }
  for _, mode in ipairs(modes) do
    local map = vim.fn.maparg(opts.args, mode, false, true)
    if map and not vim.tbl_isempty(map) then
      print(string.format("Mode %s: %s -> %s (defined in %s)", mode, opts.args, map.rhs, map.scriptfile or "Unknown"))
    end
  end
end, { nargs = 1 })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "org",
  callback = function()
    vim.keymap.set("i", "<leader><CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
      silent = true,
      buffer = true,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

--[[
=====================================================================
==================== TELESCOPE HISTORY SEARCH COMMAND ===============
=====================================================================
--]]

-- Create a user command to trigger the search
vim.api.nvim_create_user_command("SearchCommandHistory", function()
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
end, {})

vim.keymap.set("n", "<leader>sx", "<cmd>SearchCommandHistory<CR>", { desc = "[S]earch e[X]ecuted commands" })

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

require("telescope").setup({
  pickers = {
    find_files = { theme = "ivy" },
    live_grep = { theme = "ivy" },
    -- Add manual overrides here if needed
  },
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
vim.keymap.set("n", "<leader>s.", function()
  require("telescope.builtin").live_grep({ opts = { settings = { search_dirs = vim.fn.getcwd(-1, 0) } } })
end, { desc = "[S]earch by grep [.]current dir" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

--[[
=====================================================================
==================== CONFIGURE TREESITTER ===========================
=====================================================================
--]]

vim.filetype.add({
  extension = {
    hx = "haxe",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "haxe",
  callback = function()
    vim.opt_local.autowrite = true
    -- Or auto-save on text change:
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      buffer = 0,
      callback = function()
        if vim.bo.modified then
          vim.cmd("silent! write")
        end
      end,
    })
  end,
})

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
      "haxe",
    },

    fold = { enable = true },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = { playground = { enable = true } },
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
          ["i/"] = "@comment.inner",
          ["a/"] = "@comment.outer",
          ["ip"] = "@conditional.inner",
          ["ap"] = "@conditional.outer",
          ["ir"] = "@loop.inner",
          ["ar"] = "@loop.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",

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
          ["aT"] = "@type_definition.outer",
          ["aC"] = "@class_definition.outer",
          ["aF"] = "@method_definition.outer",
          ["il"] = "@let_binding.inner",
          ["im"] = "@module_binding.inner",
          ["ix"] = "@match_expression.inner",
          ["iv"] = "@value_definition.inner",
          ["iT"] = "@type_definition.inner",
          ["iC"] = "@class_definition.inner",
          ["iF"] = "@method_definition.inner",
        },
      },
      -- move = {
      --   enable = true,
      --   set_jumps = true, -- whether to set jumps in the jumplist
      --   goto_next_start = {
      --     ["]f"] = "@function.outer",
      --     ["]c"] = "@class.outer",
      --     ["]l"] = "@let_binding.outer",
      --     ["]m"] = "@module_binding.outer",
      --     ["]x"] = "@match_expression.outer",
      --     ["]v"] = "@value_definition.outer",
      --     ["]t"] = "@type_definition.outer",
      --   },
      --   goto_next_end = {
      --     ["]F"] = "@function.outer",
      --     ["]C"] = "@class.outer",
      --     ["]L"] = "@let_binding.outer",
      --     ["]M"] = "@module_binding.outer",
      --     ["]X"] = "@match_expression.outer",
      --     ["]V"] = "@value_definition.outer",
      --     ["]T"] = "@type_definition.outer",
      --   },
      --   goto_previous_start = {
      --     ["[f"] = "@function.outer",
      --     ["[c"] = "@class.outer",
      --     ["[l"] = "@let_binding.outer",
      --     ["[m"] = "@module_binding.outer",
      --     ["[x"] = "@match_expression.outer",
      --     ["[v"] = "@value_definition.outer",
      --     ["[t"] = "@type_definition.outer",
      --   },
      --   goto_previous_end = {
      --     ["[F"] = "@function.outer",
      --     ["[C"] = "@class.outer",
      --     ["[L"] = "@let_binding.outer",
      --     ["[M"] = "@module_binding.outer",
      --     ["[X"] = "@match_expression.outer",
      --     ["[V"] = "@value_definition.outer",
      --     ["[T"] = "@type_definition.outer",
      --   },
      -- },
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.haxe = {
  install_info = {
    url = "https://github.com/vantreeseba/tree-sitter-haxe",
    files = { "src/parser.c", "src/scanner.c" },
    -- optional entries:
    branch = "main",
  },
  filetype = "haxe",
}

vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
-- vim.opt.foldlevel = 3

-- vim.treesitter.query.set(
--   "ocaml",
--   "textobjects",
--   [[
--   (let_binding) @let_binding.outer
--   (let_binding body: (_) @let_binding.inner)
--
--   (module_binding) @module_binding.outer
--   (module_binding body: (_) @module_binding.inner)
--
--   (match_expression) @match_expression.outer
--   (match_expression body: (_) @match_expression.inner)
-- ]]
-- )

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspConfig", {}),
  callback = function(ev)
    -- Check if 'gd' is already mapped
    local gd_mapping = vim.fn.maparg("gd", "n")
    if gd_mapping == "" then
      -- Only map if 'gd' is not already defined
      vim.keymap.set("n", "gd", "<C-]>", { buffer = ev.buf, desc = "Go to definition (fallback)" })
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
  glsl_analyzer = {},
  gopls = {},
  pylsp = {},
  wgsl_analyzer = {},
  bashls = {},
  html = {},
  rust_analyzer = {},
  ts_ls = {},
  -- vtsls = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
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

-- vim.lsp.set_log_level("debug")

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- local capabilities = require("blink.cmp").get_lsp_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

-- require("lspconfig").zls.setup({
vim.lsp.config("zls", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "zls",
  },
})

-- require("lspconfig").clangd.setup({
vim.lsp.config("clangd", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "/opt/homebrew/opt/llvm/bin/clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--header-insertion-decorators=0",
    -- "-j=4", -- Adjust based on your CPU
    -- "--pch-storage=memory", -- Important for Unreal's PCH usage
  },
})

-- require("lspconfig").gdscript.setup({
vim.lsp.config("gdscript", {
  filetypes = { "gd", "gdscript", "gdscript3" },
  capabilities = capabilities,
  on_attach = on_attach,
})

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup({
  handlers = {
    function(server_name)
      -- require("lspconfig")[server_name].setup({
      vim.lsp.config(server_name, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      })
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].tagfunc = nil -- Disable buggy tagfunc
  end,
})

--[[
=====================================================================
==================== CONFIGURE FORMATTER ============================
=====================================================================
--]]

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

--[[
=====================================================================
==================== CONFIGURE NVIM-CMP =============================
=====================================================================
--]]
local ls = require("luasnip")
require("luasnip.loaders.from_vscode").load({})
ls.config.setup({})

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

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
  s("pacman", {
    t({ "package main", "", "func main() {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
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

ls.add_snippets("javascript", {
  s("tfunc", {
    t({ "/** ", "* @param {" }),
    i(3, "type"),
    t("} "),
    f(function(args, _, _)
      return args[1][1]
    end, { 2 }, {}),
    t({ "", "*/", "function " }),
    i(1),
    t("("),
    i(2),
    t({ ") {", "" }),
    i(4),
    t({ "", "}" }),
  }),
  s("type", {
    t("/** @type {"),
    i(1),
    t("} */"),
  }),
})

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
-- vim.keymap.set("n", "j", "jzz", { desc = "Move up" })
-- vim.keymap.set("n", "k", "kzz", { desc = "Move up" })
vim.keymap.set("n", "<leader>ax", "<cmd>tabclose<cr>", { desc = "t[A]b [X] close" })
vim.keymap.set("n", "<leader>an", "<cmd>tabnew<cr>", { desc = "t[A]b [N]ew" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww t-sesh<CR>", { desc = "t-sesh find projects" })
--
-- -- set after plugin installs
vim.keymap.set("n", "<leader>bq", ":q<cr>", { desc = "[B]uffer [Q]uit" })
vim.keymap.set("n", "<leader>ba", ":qa<cr>", { desc = "[B]uffer quit [A]ll" })
vim.keymap.set("n", "<leader>bA", ":qa!<cr>", { desc = "[B]uffer quit [A]ll!" })
vim.keymap.set("n", "<leader>bw", ":w<cr>", { desc = "[B]uffer [W]rite" })
vim.keymap.set("n", "<leader>bx", ":bd<CR>", { desc = "[B]uffer e[X]it" })
vim.keymap.set("n", "<leader>bX", ":bd!<CR>", { desc = "[B]uffer e[X]it!!" })
vim.keymap.set("n", "<leader>bn", ":ene<CR>", { desc = "[B]uffer [N]ew" })
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
vim.keymap.set("n", "<C-s>", 'yiw:s/<C-r>"/', { desc = "Replace" })

vim.keymap.set("t", "<ESC><ESC>", "<C-\\")
