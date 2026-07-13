return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						case_mode = "smart_case",
					},
				},
			})
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Find in help" })
			vim.keymap.set("n", "gr", builtin.lsp_references, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
