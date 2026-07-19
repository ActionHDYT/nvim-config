return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')
    npairs.setup({
      fast_wrap = {},
      check_ts = true,
    })
    npairs.add_rules({
            rule("<", ">", "cs") -- Only apply to C# ("cs") filetype
                -- Only auto-pair if the previous character is a letter or number (e.g. List<)
                :with_pair(cond.before_regex("%a+")) 
                -- Don't auto-pair if the next character is a space
                :with_pair(cond.not_after_regex("%s")) 
                -- Enable basic moving out of the closing bracket by typing ">"
                :with_move(function(opts)
                    return opts.char == ">"
                end)
        })
  end,
}
