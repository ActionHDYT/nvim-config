return {
  "jameswolensky/marker-groups.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("marker-groups").setup({
      picker = "telescope",
    })
  end,
}
