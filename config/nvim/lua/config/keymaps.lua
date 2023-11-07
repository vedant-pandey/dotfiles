-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>a", ":qa<CR>", nil)
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<BS>", [["_X]])
vim.keymap.set({ "n", "v" }, "<leader>D", [["_D]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>p", [["+P<CR>]])
vim.keymap.set("v", "<leader>p", [["_d"+P<CR>]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>va", "ggVG")

vim.keymap.set("v", "<M-J>", ":t '><CR>gv=gv")
vim.keymap.set("n", "<M-J>", ":t .<CR>")
vim.keymap.set("v", "<M-K>", ":t '<-1<CR>")
vim.keymap.set("n", "<M-K>", ":t .-1<CR>")

vim.keymap.set("n", "<C-n>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww t-sesh<CR>")
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww cheet<CR>")

vim.keymap.set("n", "<leader>;", "<cmd>vsplit %<CR>")
vim.keymap.set("n", "<leader>'", "<cmd>split %<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "<C-c>", "<esc>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")

vim.keymap.set("n", "<leader>vk", "<cmd>silent !ssh-add -D<cr>")
vim.keymap.set("n", "<leader>vx", "<cmd>!chmod +x %<cr>")
vim.keymap.set("v", "<leader>vs", [["hy:%s/<C-r>h/<C-r>h/gc<left><left><left>]])
vim.keymap.set("n", "<leader>vs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>ui", ":DBUIToggle<cr>")
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
vim.keymap.set({'n', 'v'}, "<M-Left>", "B")
vim.keymap.set({'n', 'v'}, "<M-Right>", "E")

