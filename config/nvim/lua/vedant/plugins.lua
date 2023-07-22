-- Lazy nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins list
require("lazy").setup({
    { 
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
})
