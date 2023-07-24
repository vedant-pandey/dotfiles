vim.g.mapleader = " "

-- basic stuff
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")
vim.keymap.set("n", "<leader><CR>", ":so %<CR>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>s", ":w<cr>:so %<CR>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<BS>", [["_X]])
vim.keymap.set("n", "D", [["_D]])
vim.keymap.set("n", "d", [["_d]])
vim.keymap.set("v", "D", [["_D]])
vim.keymap.set("v", "d", [["_d]])

-- text editting skillz
vim.keymap.set("n", "<leader>p", [["+P<CR>]])
vim.keymap.set("v", "<leader>p", [["_d"+P<CR>]])
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>va", "ggVG")

-- highlight and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- window stuff
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<M-W>", "<C-w>=")

-- Lunar vim remaps
vim.keymap.set("v", "<leader>v;", "g<C-g>")
vim.keymap.set("n", "<leader>vn", ":ene<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")
-- set after plugin installs
-- vim.keymap.set("n", "<leader>x", ":BufferKill<CR>")
-- vim.keymap.set("n", "<leader>`", "<cmd>ToggleTerm<cr>")
require("vedant.remaps.telescope")
