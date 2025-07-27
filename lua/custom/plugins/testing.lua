return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'marilari88/neotest-vitest',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Add more test adapters as needed
      -- 'nvim-neotest/neotest-jest',
      -- 'nvim-neotest/neotest-python',
      -- 'rouge8/neotest-rust',
    },
    keys = {
      {
        '<leader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run current file',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run last test',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Open test output',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle test output panel',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle test summary',
      },
      {
        '<leader>tw',
        function()
          require('neotest').run.run { jestCommand = 'jest --watch ' }
        end,
        desc = 'Run tests in watch mode',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop running tests',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest' {
            vitestConfigFile = 'vitest.unit.config.ts',
            -- Additional vitest options
            filter_dir = function(name, rel_path, root)
              return name ~= 'node_modules'
            end,
          },
          -- Add more adapters as needed
          -- require('neotest-jest')({
          --   jestCommand = 'npm test --',
          --   jestConfigFile = 'custom.jest.config.js',
          --   env = { CI = true },
          --   cwd = function(path)
          --     return vim.fn.getcwd()
          --   end,
          -- }),
        },

        -- Configure test discovery and execution
        discovery = {
          enabled = true,
          concurrent = 1,
        },

        -- Configure test running
        running = {
          concurrent = true,
        },

        -- Configure test output
        output = {
          enabled = true,
          open_on_run = 'short',
        },

        -- Configure quickfix integration
        quickfix = {
          enabled = true,
          open = false,
        },

        -- Configure status signs
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },

        -- Configure summary window
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          mappings = {
            expand = { '<CR>', '<2-LeftMouse>' },
            expand_all = 'e',
            output = 'o',
            run = 'r',
            stop = 'u',
            watch = 'w',
          },
        },

        -- Configure diagnostic integration
        diagnostic = {
          enabled = true,
          severity = 1,
        },

        -- Configure floating windows
        floating = {
          border = 'rounded',
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },

        -- Configure icons
        icons = {
          child_indent = '│',
          child_prefix = '├',
          collapsed = '─',
          expanded = '╮',
          failed = '✖',
          final_child_indent = ' ',
          final_child_prefix = '╰',
          non_collapsible = '─',
          passed = '✓',
          running = '󰑮',
          running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
          skipped = '○',
          unknown = '?',
          watching = '👁',
        },
      }

      -- Auto-commands for test-related functionality
      local group = vim.api.nvim_create_augroup('NeotestConfig', { clear = true })

      -- Auto-open summary when tests fail
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'NeotestRunComplete',
        callback = function()
          local results = require('neotest').state.get_results()
          local has_failures = false
          for _, result in pairs(results) do
            if result.status == 'failed' then
              has_failures = true
              break
            end
          end
          if has_failures then
            require('neotest').summary.open()
          end
        end,
      })
    end,
  },
}
