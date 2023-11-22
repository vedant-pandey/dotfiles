vim.cmd([[
augroup _reason
autocmd!
autocmd BufRead,BufEnter *.re set filetype=reason
augroup end
]])
