-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- disable some extension providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0

vim.opt_local.conceallevel = 2
vim.opt_global.conceallevel = 2
vim.wo.colorcolumn = ""

vim.g.background = "light"

vim.opt.termguicolors = true
