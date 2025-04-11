-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

local function parse_emmet(input)
  local tag, class = input:match '([^%.]+)%.?(.*)'
  if class and class ~= '' then
    -- Replace dots with spaces but preserve pseudo-classes like hover: and before:
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
    version = '*', -- Use the latest stable version
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
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {}, -- your configuration
  },
  {
    'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = {
      -- an empty table will work for default config
      --- if you use functions, or whichkey, or lazy to map keys
      --- then please see the API below for options
    },
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
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
}
