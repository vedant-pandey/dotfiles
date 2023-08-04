-- Lazy nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins list
require("lazy").setup({
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "yamatsum/nvim-cursorline",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {
            ensure_installed = {
                "gopls",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},             -- Required
                {                                      -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
    {
        'hrsh7th/nvim-cmp'
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'rhysd/git-messenger.vim'
    },
  { 'ThePrimeagen/vim-be-good' },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'octo'.setup()
    end
  },
  {
    'nacro90/numb.nvim',
    event = 'BufRead',
    config = function()
      require('numb').setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require 'marks'.setup {
        default_mappings = true, -- whether to map keybinds or not. default true
        builtin_marks = { ".", "<", ">", "^" }, -- which builtin marks to show. default {}
        cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
        force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
        refresh_interval = 1000, -- how often (in ms) to redraw signs/recompute mark positions.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 22 }, -- sign priorities for each type of mark 
        excluded_filetypes = {}, -- disables mark tracking for specific filetypes. default {}
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "BM0",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = true,
        },
        mappings = {
          preview = "<leader>bm"
        }
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
})


-- plugin configs
-- telescope file browser
require("telescope").load_extension "file_browser"

require("nvim-tree").load_extension "file_browser"

require("nvim-cursorline").setup {
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

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end
}

require('cmp').setup()

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
