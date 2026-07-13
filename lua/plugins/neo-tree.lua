return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      window = {
        mappings = {

          ["<C-b>"] = "",
        },
      },
    },
    config = function(_, opts)
      vim.keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<Cr>")
      require("neo-tree").setup(opts)
    end,
  },
}
