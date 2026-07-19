return {
  -- The core Debug Adapter Protocol client
  { 'mfussenegger/nvim-dap' },

  -- A beautiful UI layer that gives you visual variable inspection panels
  { 
    'rcarriga/nvim-dap-ui', 
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 25,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 1.0 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      dap.adapters.coreclr = {
        type = 'executable',
        command = 'C:\\LegacyApp\\tools\\netcoredbg\\netcoredbg.exe',
        args = {'--interpreter=vscode'}
      }

      -- Sucht NUR nach der ausführbaren Datei, baut NICHT selbst
      local function get_program_path()
        local exes = vim.fn.glob(vim.fn.getcwd() .. '/**/bin/Debug/**/*.exe', false, true)
        local proj_exes = vim.tbl_filter(function(f)
            local normalized = f:gsub('\\', '/')
            local name = normalized:match('.+/(.-)%.exe$')
            local proj = normalized:match('/([^/]+)/bin/Debug/')
            return name and proj and name == proj
        end, exes)
        if #proj_exes == 1 then
            return proj_exes[1]
        end

        local dlls = vim.fn.glob(vim.fn.getcwd() .. '/**/bin/Debug/**/*.dll', false, true)
        local proj_dlls = vim.tbl_filter(function(f)
            local normalized = f:gsub('\\', '/')
            local name = normalized:match('.+/(.-)%.dll$')
            local proj = normalized:match('/([^/]+)/bin/Debug/')
            return name and proj and name == proj
        end, dlls)
        if #proj_dlls == 1 then
            return proj_dlls[1]
        end

        return vim.fn.input('Path to exe/dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end

      dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = get_program_path,
            console = "internalConsole",
            -- BEHOBEN: Nutzt die DAP-eigene Variable, um get_program_path() nicht doppelt aufzurufen
            cwd = "${fileDirname}", 
        },
      }
      
      -- Automatically open/close UI panels
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- KEYMAPS
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })

      -- BEHOBEN: Smarter F5-Keymap (Baut nur, wenn keine Session aktiv ist)
      vim.keymap.set('n', '<F5>', function()
        if dap.session() ~= nil then
          dap.continue()
        else
          vim.notify("Building .NET project...", vim.log.levels.INFO)
          vim.fn.jobstart({ "dotnet", "build" }, {
            on_exit = function(_, exit_code, _)
              if exit_code == 0 then
                vim.notify("Build succeeded!", vim.log.levels.INFO)
                dap.continue()
              else
                vim.notify("Build Failed...", vim.log.levels.ERROR)
              end
            end,
          })
        end
      end, { desc = 'Debug: Smart Build & Start/Continue' })

      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI Panels' })

      vim.keymap.set('n', '<leader>dw', function()
        local expr = vim.fn.expand('<cexpr>')
        if expr ~= nil and expr ~= '' then
          require('dapui').elements.watches.add(expr)
        else
          vim.notify('Debug: No expression under cursor', vim.log.levels.WARN)
        end
      end, { desc = 'Debug: Watch Expression Under Cursor' })

    end
  },
}
