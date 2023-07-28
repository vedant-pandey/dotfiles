-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.colorscheme = "catppuccin"
lvim.plugins = {
  { 'ThePrimeagen/vim-be-good' },
  {
    'catppuccin/nvim', name = 'catppuccin', priority = 1000
  },
  -- { 'wakatime/vim-wakatime' },
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
}

lvim.keys.normal_mode["<leader>pc"] = false
lvim.keys.normal_mode["<leader>pd"] = false
lvim.keys.normal_mode["<leader>pi"] = false
lvim.keys.normal_mode["<leader>pl"] = false
lvim.keys.normal_mode["<leader>pp"] = false
lvim.keys.normal_mode["<leader>ps"] = false
lvim.keys.normal_mode["<leader>pS"] = false
lvim.keys.normal_mode["<leader>pu"] = false


-- VeReMaps
lvim.keys.visual_mode["<leader>v;"] = "g<C-g>" -- count characters
lvim.keys.normal_mode["<leader>vn"] = ":ene<CR>" -- new empty
lvim.keys.normal_mode["<leader>va"] = "ggVG" -- select whole file
lvim.keys.normal_mode["<leader>vb"] = "<cmd>vsplit<CR><cmd>Telescope find_files<cr>" -- split buffer and select what to open
lvim.keys.normal_mode["<leader>vy"] = "VY"
lvim.keys.normal_mode["<leader>vd"] = "VD"

vim.opt.rnu = true
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"
lvim.keys.normal_mode["<leader>x"] = ":BufferKill<CR>"
-- lvim.builtin["terminal"].open_mapping = [[<leader>`]]
lvim.keys.normal_mode["<leader>`"] = "<cmd>ToggleTerm<cr>"
lvim.keys.normal_mode["<leader>1"] = "0"
-- lvim.builtin.execs = { { nil, "<M-1>", }, { nil, "<M-2>", }, { nil, "<M-3>", }, }
lvim.keys.normal_mode["<leader>2"] = "_"
lvim.keys.normal_mode["<leader>3"] = "0f="
lvim.keys.normal_mode["<leader>4"] = "$"
lvim.keys.visual_mode["<leader>1"] = "0"
lvim.keys.visual_mode["<leader>2"] = "_"
lvim.keys.visual_mode["<leader>3"] = "0f="
lvim.keys.visual_mode["<leader>4"] = "$"
vim.opt.wrap = true
vim.opt.clipboard = ""
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.insert_mode["jk"] = "<esc>"

lvim.keys.normal_mode["<BS>"] = [["_X]]
lvim.keys.normal_mode["D"] = [["_D]]
lvim.keys.normal_mode["d"] = [["_d]]
lvim.keys.visual_mode["D"] = [["_D]]
lvim.keys.visual_mode["d"] = [["_d]]
-- text editting skillz
lvim.keys.normal_mode["<leader>p"] = [["+P<CR>]]
lvim.keys.visual_mode["<leader>p"] = [["_d"+P<CR>]]
lvim.keys.normal_mode["<leader>y"] = [["+y]]
lvim.keys.visual_mode["<leader>d"] = [["_d]]
lvim.keys.normal_mode["<leader>va"] = "ggVG"
lvim.keys.normal_mode["<leader>va"] = "ggVG"

lvim.keys.normal_mode["<C-n>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>BufferLineCyclePrev<cr>"

vim.opt.scrolloff = 8
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.ww = "h,l"

