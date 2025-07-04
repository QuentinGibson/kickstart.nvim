local function parse_emmet(input)
  local tag, class = input:match '([^%.]+)%.?(.*)'
  if class and class ~= '' then
    class = class:gsub('(%S):', '%1:') -- Keep pseudo-classes intact
    class = class:gsub('%.', ' ') -- Convert dots to spaces for regular classes
    return { { '<' .. tag .. ' className="' .. class .. '">' }, { '</' .. tag .. '>' } }
  else
    return { { '<' .. tag .. '>' }, { '</' .. tag .. '>' } }
  end
end

return {
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    hooks = {
      post_add = function()
        vim.lsp.buf.format()
      end,
    },
    config = function()
      require('nvim-surround').setup {
        surrounds = {
          ['e'] = {
            add = function()
              local input = vim.fn.input 'Enter Emmet abbreviation: '
              return parse_emmet(input)
            end,
          },
        },
      }
    end,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
  {
    'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = {},
  },
  -- CodeCompanion configuration moved to separate file
  -- Configuration is in ~/.config/nvim/lua/plugins/codecompanion.lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {}
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_mappings()
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'xiyaowong/transparent.nvim' },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'marilari88/neotest-vitest',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
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
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Open test output',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle test summary',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest' {
            vitestConfigFile = 'vitest.unit.config.ts',
          },
        },
      }
    end,
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>ud', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undotree' },
    },
    config = function()
      -- Optional: Configure undotree settings
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
}
