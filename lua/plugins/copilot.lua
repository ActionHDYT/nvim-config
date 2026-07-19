return {
  -- Copilot backend (no inline suggestions, chat only)
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'VeryLazy',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { ['*'] = true },
      })
    end,
  },

  -- CodeCompanion: Modern AI Chat & VS Code Style Inline Diffs
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/codecompanion-history.nvim', -- Native history plugin added here
    },
    config = function()

      require('codecompanion').setup({
        strategies = {
          chat = {
            adapter = 'copilot',
            slash_commands = {
              buffer = {
                opts = {
                  provider = 'telescope',
                },
              },
            },
          },
          inline = {
            adapter = 'copilot',
            keymaps = {
              accept_change = {
                modes = { n = '<leader>aa' }, -- Maps directly to your Accept Diff hotkey
                description = 'Accept Change',
              },
              reject_change = {
                modes = { n = '<leader>ad' },
                description = 'Reject Change',
              },
            },
          },
        },
        display = {
          diff = {
            enabled = true,
            opts = {
              number = true,
            },
            word_highlights = {
              additions = true,
              deletions = true,
            },
          },
          chat = {
            show_diffs = true,
            show_figure = 'ascii',
          },
          action_palette = {
            width = 95,
            height = 7,
          },
        },
        opts = {
          send_code = true,
          use_default_prompts = true,
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              auto_save = true,
              auto_generate_title = true,
              picker = 'telescope', -- Automatically uses Telescope if available
              
              -- Enforce per-folder history tracking
              chat_filter = function(chat_data)
                return chat_data.cwd == vim.fn.getcwd()
              end,
            },
          },
        },
      })
    end,
    keys = {
      -- Kept completely identical to your previous CopilotChat binds
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Copilot: Chat' },
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>',     desc = 'Copilot: Actions & Diffs' },
      { '<leader>ah', '<cmd>CodeCompanionHistory<cr>',     desc = 'Copilot: History Browser' }, -- Swapped to History command
      
      -- Inline prompts matching Explain, Fix, and Review via CodeCompanion's actions
      { '<leader>ab', '<cmd>CodeCompanion /buffer<cr>', desc = 'Copilot: Apply to Buffer', mode = { 'n', 'v' } },
      { '<leader>ae', '<cmd>CodeCompanion /explain<cr>',   desc = 'Copilot: Explain', mode = { 'n', 'v' } },
      { '<leader>af', '<cmd>CodeCompanion /fix<cr>',       desc = 'Copilot: Fix',     mode = { 'n', 'v' } },
    },
  },
}
