return {
  "stevearc/overseer.nvim",
  keys = {
    { "<leader>r", desc = "Overseer: Save and Run Code" },
  },
  opts = {
    templates = {"builtin"},
    output = {
      use_terminal = true,
    },
    task_list = {
      direction = "right",
      binding_keys = {
        ["q"] = "Close",
      },
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)
    vim.keymap.set("n", "<leader>r", function ()
      pcall(vim.cmd, "write")
      local filetype = vim.bo.filetype
      local filename = vim.fn.expand("%:p")
      local cmd = nil
      local cwd = vim.fn.getcwd()

      if filetype == "python" then
        cmd = { "python", filename}

      elseif filetype == "cs" then
        local root = vim.fs.root(0, {"*.csproj", "*.sln"})
        cmd = {"dotnet", "run"}
        if root then cwd = root end

      end

      if cmd then
        local task = overseer.new_task({
          cmd = cmd,
          cwd = cwd,
          components = {
            {"on_output_quickfix", open_on_exit = "failure"},
            {"open_output", direction = "horizontal", on_start = "always", focus = true},
            "unique",
            "default",
          },
        })
        task:start()
      else
        vim.notify("Overseer: No run command mapped for '" .. filetype .. "'", vim.log.levels.WARN)
      end
    end, {desc = "Overseer: Save and Run Code"})
    end,
}
