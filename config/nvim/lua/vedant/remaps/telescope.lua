local telescope_builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>F', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>st', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>bf', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', telescope_builtin.marks, {})

-- file browser remaps
vim.keymap.set('n', '<leader>e', "<cmd>Telescope find_files<CR>", {})
