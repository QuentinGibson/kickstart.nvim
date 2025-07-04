-- ~/.config/nvim/lua/plugins/codecompanion.lua
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp', -- For slash commands and variables in chat
    'nvim-telescope/telescope.nvim', -- For file selection in slash commands
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
  },
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
  },
  keys = {
    { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'Code Companion Actions' },
    { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'Toggle Chat' },
    { '<leader>ac', '<cmd>CodeCompanionChat<cr>', mode = 'n', desc = 'New Chat' },
    { '<leader>ai', '<cmd>CodeCompanion<cr>', mode = 'n', desc = 'Inline Assistant' },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add to Chat' },
  },
  opts = {
    -- Enhanced adapter configuration for Claude
    adapters = {
      anthropic = function()
        return require('codecompanion.adapters').extend('anthropic', {
          env = {
            api_key = 'ANTHROPIC_API_KEY',
          },
          schema = {
            -- Use the latest Claude model
            model = {
              default = 'claude-sonnet-4-20250514',
              -- Alternative models you can switch to
              choices = {
                ['claude-opus-4-20250514'] = { opts = { can_reason = true, has_vision = true } },
                ['claude-sonnet-4-20250514'] = { opts = { can_reason = true, has_vision = true } },
                ['claude-3-5-sonnet-20241022'] = { opts = { has_vision = true } },
              },
            },
            -- Fine-tune model parameters
            temperature = {
              default = 0.1, -- Lower for more consistent code
            },
            max_tokens = {
              default = 8192, -- Increased for longer responses
            },
            -- Enable advanced reasoning (Claude 4 feature)
            use_reasoning = {
              default = true,
            },
          },
          -- Enable prompt caching for better performance
          opts = {
            cache_breakpoints = 6, -- Cache more messages
            cache_over = 200, -- Lower threshold for caching
            stream = true,
            tools = true,
            vision = true,
          },
        })
      end,
    },

    -- Strategy configuration
    strategies = {
      chat = {
        adapter = 'anthropic',
        roles = {
          llm = 'Claude', -- Custom name for the assistant
          user = 'You',
        },
        slash_commands = {
          buffer = {
            opts = {
              provider = 'telescope', -- Use telescope for file selection
            },
          },
          file = {
            opts = {
              provider = 'telescope',
            },
          },
          help = {
            opts = {
              provider = 'telescope',
            },
          },
        },
      },
      inline = {
        adapter = 'anthropic',
      },
      agent = {
        adapter = 'anthropic',
      },
    },

    -- Enhanced display options
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt> ',
        provider = 'telescope',
      },
      chat = {
        window = {
          layout = 'vertical', -- or 'horizontal', 'float'
          width = 0.45, -- 45% of screen width
          height = 0.8, -- 80% of screen height
          relative = 'editor',
          border = 'rounded',
          title = 'Code Companion',
        },
        render_headers = false, -- Disable if using render-markdown.nvim
        show_settings = true,
        show_token_count = true,
        buf_options = {
          buflisted = false,
        },
      },
      inline = {
        -- Configure inline assistant appearance
        layout = 'vertical',
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close chat after 4 minutes of inactivity
        },
      },
    },

    -- Enhanced prompt library
    prompt_library = {
      ['Custom Code Review'] = {
        strategy = 'chat',
        description = 'Thorough code review with TypeScript focus',
        opts = {
          index = 10,
          is_default = false,
          is_slash_cmd = false,
          user_prompt = true,
        },
        prompts = {
          {
            role = 'system',
            content = function()
              return 'You are an expert TypeScript developer and code reviewer. '
                .. 'Provide detailed, constructive feedback on code quality, '
                .. 'performance, maintainability, and TypeScript best practices. '
                .. 'Focus on type safety, modern patterns, and potential issues.'
            end,
          },
          {
            role = 'user',
            content = function(context)
              return 'Please review this TypeScript code:\n\n' .. '```typescript\n' .. context.selection .. '\n```'
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ['Explain with Context'] = {
        strategy = 'chat',
        description = 'Explain code with full file context',
        opts = {
          index = 11,
          user_prompt = true,
        },
        prompts = {
          {
            role = 'user',
            content = function(context)
              return 'Explain this code in the context of the entire file. '
                .. 'Consider the surrounding code, imports, and overall structure:\n\n'
                .. '```typescript\n'
                .. context.selection
                .. '\n```\n\n'
                .. 'Full file for context:\n\n'
                .. '```typescript\n'
                .. context.buffer
                .. '\n```'
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
    },

    -- Enhanced logging and debugging
    opts = {
      log_level = 'INFO', -- Change to 'DEBUG' for troubleshooting
      send_code = true, -- Allow sending code to LLM
      use_default_actions = true,
      use_default_prompt_library = true,
    },

    -- Advanced slash commands configuration
    slash_commands = {
      buffer = {
        callback = 'strategies.chat.slash_commands.buffer',
        description = 'Insert open buffers',
        opts = {
          provider = 'telescope',
        },
      },
      file = {
        callback = 'strategies.chat.slash_commands.file',
        description = 'Insert a file',
        opts = {
          provider = 'telescope',
          max_lines = 1000, -- Limit file size
        },
      },
      symbols = {
        callback = 'strategies.chat.slash_commands.symbols',
        description = 'Insert symbols from the current buffer',
        opts = {
          provider = 'telescope',
        },
      },
    },

    -- Configure agent/tool capabilities
    agents = {
      opts = {
        system_prompt = function()
          return 'You are an expert TypeScript/JavaScript developer assistant. '
            .. 'You have access to tools to help analyze and modify code. '
            .. 'Always consider type safety, performance, and maintainability.'
        end,
      },
    },
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)

    -- Additional command abbreviations
    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab ccc CodeCompanionChat]]
    vim.cmd [[cab cca CodeCompanionActions]]

    -- Auto-commands for enhanced workflow
    local codecompanion_augroup = vim.api.nvim_create_augroup('CodeCompanion', { clear = true })

    -- Auto-focus chat window when opened
    vim.api.nvim_create_autocmd('FileType', {
      group = codecompanion_augroup,
      pattern = 'codecompanion',
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
      end,
    })

    -- Enhanced keymaps for TypeScript files
    vim.api.nvim_create_autocmd('FileType', {
      group = codecompanion_augroup,
      pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      callback = function()
        local opts_local = { buffer = true, silent = true }
        vim.keymap.set('n', '<leader>ar', '<cmd>CodeCompanion Custom Code Review<cr>', vim.tbl_extend('force', opts_local, { desc = 'Code Review' }))
        vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanion Explain with Context<cr>', vim.tbl_extend('force', opts_local, { desc = 'Explain with Context' }))
      end,
    })
  end,
}
