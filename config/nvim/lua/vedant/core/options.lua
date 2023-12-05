vim.o.so = 8
vim.o.nu = true
vim.o.rnu = true
vim.o.ts = 4
vim.o.sts = 4
vim.o.sw = 4
vim.o.et = true
vim.o.si = true
vim.o.wrap = true
vim.o.ww = "h,l"
vim.o.tgc = true
vim.o.ic = true
vim.o.signcolumn = "yes:1"

vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess = vim.opt.shortmess + "c"

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.cmd.colorscheme("catppuccin")

vim.loader.enable()
