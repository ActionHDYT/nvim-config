return {
    "echasnovski/mini.ai",
    version = false,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
    local ai = require("mini.ai")
		
		ai.setup({
			-- Increase search lines so it captures large functions
			n_lines = 500, 
			
			custom_textobjects = {
				-- 1. 'F' for Function Definitions (Implementation)
				F = ai.gen_spec.treesitter({ 
					a = "@function.outer", 
					i = "@function.inner" 
				}),
				
				-- 2. 'C' for Class Definitions
				C = ai.gen_spec.treesitter({ 
					a = "@class.outer", 
					i = "@class.inner" 
				}),
			},
		})
    end
}