-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Line numbers
vim.opt.number = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- 24-bit colour support
vim.opt.termguicolors = true

-- Disable netrw at the very start, since nvim-tree replaces it
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
