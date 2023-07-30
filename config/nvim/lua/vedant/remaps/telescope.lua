local telescope_builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>F', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>f', telescope_builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>st', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>bf', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>mf', telescope_builtin.marks, {})
vim.keymap.set("n", "<leader>vf", "<cmd>vsplit<CR><cmd>Telescope find_files<cr>") -- split buffer and select what to open

-- file browser remaps
-- vim.keymap.set('n', '<leader>fe', "<cmd>Telescope file_browser<CR>", {})
