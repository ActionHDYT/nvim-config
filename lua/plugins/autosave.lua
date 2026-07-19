return {
	"pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			noautocmd = false,
		})
		vim.cmd("ASToggle")
		vim.keymap.set("n", "<leader><C-s>", ":ASToggle<Cr>", { remap = false, desc = "Toggle Autosave" })
	end,
}
