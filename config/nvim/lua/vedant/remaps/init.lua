vim.g.mapleader = " "

-- basic stuff
vim.keymap.set("n", "<leader>e", ":Vex<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")
vim.keymap.set("n", "<leader><CR>", ":so %<CR>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>s", ":w<cr>:so %<CR>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<BS>", "X")

-- text editting skillz
vim.keymap.set("n", "<leader>P", [["+P<CR>]])
vim.keymap.set("v", "<leader>p", [["_dP<CR>]])
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>va", "ggVG")

-- highlight and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- window navigation
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- window sizing
vim.keymap.set("n", "<M-L>", "<C-w>>")
vim.keymap.set("n", "<M-H>", "<C-w><")
vim.keymap.set("n", "<M-J>", "<C-w>-")
vim.keymap.set("n", "<M-J>", "<C-w>-")
vim.keymap.set("n", "<M-W>", "<C-w>=")

-- Lunar vim remaps
vim.keymap.set("v", "<leader>v;", "g<C-g>")
vim.keymap.set("n", "<leader>vn", ":ene<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- set after plugin installs
-- vim.keymap.set("n", "<leader>x", ":BufferKill<CR>")
-- vim.keymap.set("n", "<leader>vb", "<cmd>vsplit<CR><cmd>Telescope find_files<cr>" -- split buffer and select what to open)
-- vim.keymap.set("n", "<leader>`", "<cmd>ToggleTerm<cr>")
require("vedant.remaps.telescope")
