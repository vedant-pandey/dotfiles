-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

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
        config = true
    },
    {
        'rhysd/git-messenger.vim'
    },
    {
        'kevinhwang91/nvim-bqf'
    },
}


lvim.keys.normal_mode["<leader>p"] = nil
lvim.keys.normal_mode["<leader>pc"] = nil
lvim.keys.normal_mode["<leader>pd"] = nil
lvim.keys.normal_mode["<leader>pi"] = nil
lvim.keys.normal_mode["<leader>pl"] = nil
lvim.keys.normal_mode["<leader>pp"] = nil
lvim.keys.normal_mode["<leader>ps"] = nil
lvim.keys.normal_mode["<leader>pS"] = nil
lvim.keys.normal_mode["<leader>pu"] = nil

-- basic stuff
lvim.keys.normal_mode["<leader>q"] = ":q<cr>"
lvim.keys.normal_mode["<leader>a"] = ":qa<cr>"
lvim.keys.normal_mode["<leader>h"] = ":noh<CR>"
lvim.keys.normal_mode["<leader><CR>"] = ":so %<CR>"
lvim.keys.normal_mode["<leader><ESC>"] = ":so ~/.config/nvim/init.lua<CR>"
lvim.keys.normal_mode["<leader>w"] = ":w<cr>"
lvim.keys.insert_mode["jk"] = "<esc>"
lvim.keys.normal_mode["<BS>"] = [["_X]]
lvim.keys.normal_mode["D"] = [["_D]]
lvim.keys.visual_mode["D"] = [["_D]]
lvim.keys.normal_mode["d"] = [["_d]]
lvim.keys.visual_mode["d"] = [["_d]]

-- text editting skillz
lvim.keys.normal_mode["<leader>p"] = [["+P<CR>]]
lvim.keys.visual_mode["<leader>p"] = [["_d"+P<CR>]]
lvim.keys.normal_mode["<leader>y"] = [["+y]]
lvim.keys.visual_mode["<leader>y"] = [["+y]]
lvim.keys.normal_mode["<leader>va"] = "ggVG"

-- Text moving skills
lvim.keys.visual_mode["<M-j>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<M-k>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode["<M-J>"] = ":t '><CR>gv=gv"
lvim.keys.visual_mode["<M-K>"] = ":t '<-1<CR>"
lvim.keys.normal_mode["<M-j>"] = ":m .+1<CR>"
lvim.keys.normal_mode["<M-k>"] = ":m .-2<CR>"
lvim.keys.normal_mode["<M-J>"] = ":t .<CR>"
lvim.keys.normal_mode["<M-K>"] = ":t .-1<CR>"

-- window stuff
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
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
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

-- local telescope_builtin = require('telescope.builtin')

-- vim.keymap.set({'n', 'v'}, '<leader>f', telescope_builtin.find_files, {})
-- vim.keymap.set({'n', 'v'}, '<leader>F', telescope_builtin.git_files, {})
-- vim.keymap.set({'n', 'v'}, '<leader>st', telescope_builtin.live_grep, {})
-- vim.keymap.set({'n', 'v'}, '<leader>bf', telescope_builtin.buffers, {})
-- vim.keymap.set({'n', 'v'}, '<leader>mf', telescope_builtin.marks, {})
-- vim.keymap.set({'n', 'v'}, '<leader>vf', '<cmd>vsplit<CR><cmd>Telescope find_files<cr>') -- split buffer and select what to open
--

require('todo-comments').setup()

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
vim.opt.clipboard=""

vim.cmd([[
if executable('opam')
    let g:opamshare=substitute(system('opam var share'),'\n$','','''')
    if isdirectory(g:opamshare."/merlin/vim")
        execute "set rtp+=" . g:opamshare."/merlin/vim"
    endif
endif
]])

