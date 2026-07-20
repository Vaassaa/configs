return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
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
        dotfiles = false, -- show dotfiles
        git_ignored = false, -- show files ignored by .gitignore
        custom = {}, -- make sure no other patterns hide files
      },
      git = {
        ignore = false, -- do NOT hide gitignored files
      },
    })

    vim.keymap.set("n", "<C-s>", ":NvimTreeToggle<CR>", { silent = true, noremap = true })

    -- Automatically close Nvim if nvim-tree is the last window left
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
