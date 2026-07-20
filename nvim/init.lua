-- Leader keys must be set before lazy.nvim loads so mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.lazy")
