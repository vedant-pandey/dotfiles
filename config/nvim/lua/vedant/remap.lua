vim.g.mapleader = " "

-- basic stuff
vim.keymap.set("n", "<leader>e", ":Vex<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")
vim.keymap.set("n", "<leader><CR>", ":so %<CR>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>s", ":w<cr>:so %<CR>")
vim.keymap.set("i", "jk", "<esc>")

-- text editting skillz
vim.keymap.set("n", "<leader>P", [["+P<CR>]])
vim.keymap.set("v", "<leader>p", [["_dP<CR>]])
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>y", [["+y]])
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
vim.keymap.set("n", "<C-L>", "<C-w>>")
vim.keymap.set("n", "<C-H>", "<C-w><")
vim.keymap.set("n", "<C-J>", "<C-w>-")
vim.keymap.set("n", "<C-K>", "<C-w>+")
