-- Move between windows with Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Splits
vim.keymap.set("n", "<leader>sh", ":split | enew<CR>", { noremap = true, silent = true, desc = "New horizontal split" })
vim.keymap.set("n", "<leader>sv", ":vnew<CR>", { noremap = true, silent = true, desc = "New vertical split" })
