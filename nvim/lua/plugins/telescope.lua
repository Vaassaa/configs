return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-project.nvim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        project = {
          -- directories the project picker searches. Empty by default;
          -- add your own project roots here, e.g. "~/dev/my-project"
          base_dirs = {},
          hidden_files = true,
          theme = "dropdown",
          order_by = "recent",
          search_by = "title",
          sync_with_nvim_tree = true,
        },
      },
    })
    require("telescope").load_extension("project")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>p", ":Telescope project<CR>", { desc = "Projects" })
  end,
}
