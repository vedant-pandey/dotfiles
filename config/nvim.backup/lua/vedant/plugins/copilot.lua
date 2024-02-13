vim.g.copilot_no_tab_map = true

vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-K>", "copilot#Previous()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Next()", { silent = true, expr = true })

vim.g.copilot_filetypes = {
	["javascript"] = true,
	["typescript"] = true,
	["lua"] = true,
	["rust"] = true,
	["c"] = true,
	["c#"] = true,
	["c++"] = true,
	["go"] = true,
	["python"] = true,
}
