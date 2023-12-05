-- Vimspector
vim.cmd([[
nmap <F5> <cmd>call vimspector#Launch()<cr>
nmap <F9> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
vim.keymap.set("n", "Db", ":call vimspector#ToggleBreakpoint()<cr>")
vim.keymap.set("n", "Dw", ":call vimspector#AddWatch()<cr>")
vim.keymap.set("n", "De", ":call vimspector#Evaluate()<cr>")
