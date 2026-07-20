
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configure clipboard - use systems
vim.opt.clipboard = "unnamedplus"

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Enable line numbers globally
vim.opt.number = true -- Absolute line numbers
-- set CTRL + h to toggle nvimtree
--vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
-- set CTRL + h to toggle nvimtree
vim.api.nvim_set_keymap("n", "<C-s>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
-- set CTRL + hjkl to move between open buffers
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
-- set leader + sh to open a new buffer with horizontal split
vim.api.nvim_set_keymap("n", "<leader>sh", ":split | enew<CR>", { noremap = true, silent = true })
-- set leader + sv to open a new buffer with vertical split
vim.api.nvim_set_keymap("n", "<leader>sv", ":vnew<CR>", { noremap = true, silent = true })
-- set leader + tw to enable twiglight mode
vim.api.nvim_set_keymap("n", "<leader>tw", ":Twilight<CR>", { noremap = true, silent = true })
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    -- project finder
    {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
    require('telescope').load_extension('project')
    end
    },
    -- tree file explorer
    {"nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons"},
    -- super smooth scroling through document
    {"yuttie/comfortable-motion.vim"},
    -- colorschemes
    {"rebelot/kanagawa.nvim"},
	-- relative numbering
	{"sitiom/nvim-numbertoggle"},
	-- corrects relative number to be more comfy
	{'mluders/comfy-line-numbers.nvim'},
	{
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
},
	-- dims code thats not edited rn
	{
	  "folke/twilight.nvim",
	  opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	  }
	},
	--- add indent lines to code
	{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
	},
	--- adds status line
	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
    -- telescope file finder and locator
    {'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim'},
    -- comment any file and line
    {'preservim/nerdcommenter'},
    -- render markdown documents inside nvim
    {'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
-- set COLORSCHEME
vim.cmd("colorscheme kanagawa")
-- ######### --
-- TELESCOPE --
-- ######### --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>p", ":Telescope project<CR>", { desc = "Projects" }) -- project finder
-- ######### --
-- NVIM-TREE -- 
-- ######### --
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,     -- show dotfiles
    git_ignored = false,  -- show files ignored by .gitignore
    custom = {},          -- make sure no other patterns hide files
  },
  git = {
    ignore = false,       -- do NOT hide gitignored files
  },
})

-- To use systems clipboard
vim.api.nvim_set_option("clipboard","unnamed") 

-- Use 4 spaces for tabs and indentation
vim.opt.tabstop = 4        -- Number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 4     -- Number of spaces used for each step of (auto)indent

-- Telescope config for telescope-project
require('telescope').setup({
  extensions = {
    project = {
      base_dirs = {
        '~/Documents/PhD/Dissertation/Code/heatConductOpt_parallel/', 
	'~/Documents/PhD/Dissertation/Code/coupledOpt/',
	'~/.config/nvim',
	'~/Documents/PhD/Dissertation/Code/drutes-explr/',
      },
      hidden_files = true, -- show hidden files in project
      theme = "dropdown",
      order_by = "recent",
      search_by = "title",
      sync_with_nvim_tree = true,
    }
  }
})
-- Load the extension again just to be safe
require('telescope').load_extension('project')

--- Automaticaly close Nvim if the last buffer it NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") then
      vim.cmd("quit")
    end
  end,
})

--- CONFIG of STATUS LINE
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

--- Setup indent Colors
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }


