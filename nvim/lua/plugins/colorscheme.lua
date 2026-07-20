return {
  "rebelot/kanagawa.nvim",
  priority = 1000, -- load before other plugins so the colorscheme is ready
  config = function()
    vim.cmd("colorscheme kanagawa")
  end,
}
