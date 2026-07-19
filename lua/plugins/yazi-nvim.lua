return {
	"mikavilpas/yazi.nvim",
	version = "*", -- Verwendet die neueste stabile Version
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>-",
			"<cmd>Yazi<cr>",
			mode = { "n", "v" },
			desc = "Open yazi at the current file",
		},
		{
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},
		-- 👇 DIESER BLOCK BEHEBT DEN FEHLER IN NEOVIM 0.12+
		-- Ersetzt nvim_exec2() durch das native, sichere vim.cmd.edit
		open_file_function = function(chosen_file)
			vim.cmd.edit(vim.fn.fnameescape(chosen_file))
		end,
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
}
