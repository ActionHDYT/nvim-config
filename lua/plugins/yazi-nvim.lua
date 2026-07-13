return {
	"mikavilpas/yazi.nvim",
	version = "*", -- use the latest stable version
	event = "VeryLazy",
	init = function()
		-- Disable the classic netrw explorer
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Disable Neovim 0.12+ built-in directory explorer
		vim.g.loaded_nvim_dir_plugin = 1
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			-- Open in the current working directory
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
		-- Hijack directory buffers when opening folders
		open_for_directories = true,
    open_file_function = function(chosen_file)
      vim.cmd.edit(vim.fn.fnameescape(chosen_file))
    end,
	},
}
