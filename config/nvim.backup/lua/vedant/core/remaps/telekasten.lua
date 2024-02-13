-- On hesitation, bring up the command panel
vim.keymap.set("n", "<leader>z", ":lua require('telekasten').panel()<CR>")

-- Function mappings
vim.keymap.set("n", "<leader>zf", ":lua require('telekasten').find_notes()<CR>")
vim.keymap.set("n", "<leader>zd", ":lua require('telekasten').find_daily_notes()<CR>")
vim.keymap.set("n", "<leader>zg", ":lua require('telekasten').search_notes()<CR>")
vim.keymap.set("n", "<leader>zz", ":lua require('telekasten').follow_link()<CR>")
vim.keymap.set("n", "<leader>zT", ":lua require('telekasten').goto_today()<CR>")
vim.keymap.set("n", "<leader>zW", ":lua require('telekasten').goto_thisweek()<CR>")
vim.keymap.set("n", "<leader>zw", ":lua require('telekasten').find_weekly_notes()<CR>")
vim.keymap.set("n", "<leader>zn", ":lua require('telekasten').new_note()<CR>")
vim.keymap.set("n", "<leader>zN", ":lua require('telekasten').new_templated_note()<CR>")
vim.keymap.set("n", "<leader>zy", ":lua require('telekasten').yank_notelink()<CR>")
vim.keymap.set("n", "<leader>zc", ":lua require('telekasten').show_calendar()<CR>")
vim.keymap.set("n", "<leader>zC", ":CalendarT<CR>")
vim.keymap.set("n", "<leader>zi", ":lua require('telekasten').paste_img_and_link()<CR>")
vim.keymap.set("n", "<leader>zt", ":lua require('telekasten').toggle_todo()<CR>")
vim.keymap.set("n", "<leader>zb", ":lua require('telekasten').show_backlinks()<CR>")
vim.keymap.set("n", "<leader>zF", ":lua require('telekasten').find_friends()<CR>")
vim.keymap.set("n", "<leader>zI", ":lua require('telekasten').insert_img_link({ i=true })<CR>")
vim.keymap.set("n", "<leader>zp", ":lua require('telekasten').preview_img()<CR>")
vim.keymap.set("n", "<leader>zm", ":lua require('telekasten').browse_media()<CR>")
vim.keymap.set("n", "<leader>za", ":lua require('telekasten').show_tags()<CR>")
vim.keymap.set("n", "<leader>#", ":lua require('telekasten').show_tags()<CR>")
vim.keymap.set("n", "<leader>zr", ":lua require('telekasten').rename_note()<CR>")

-- we could define [[ in **insert mode** to call insert link
-- inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
-- alternatively: leader [
-- vim.keymap.set("i", "<leader>[", "<cmd>:lua require('telekasten').insert_link({ i=true })<CR>")
-- vim.keymap.set("i", "<leader>zt", "<cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>")
-- vim.keymap.set("i", "<leader>#", "<cmd>:lua require('telekasten').show_tags({i = true})<CR>")
