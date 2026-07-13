return {
	"SCJangra/table-nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("table-nvim").setup({})
	end,
}
