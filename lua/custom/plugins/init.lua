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
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",
        inline_symbol = "󰝤 ",
      },
      conceal = {
        enabled = false,
      },
      custom_filetypes = {},
    },
    config = function(_, opts)
      require('tailwind-tools').setup(opts)
    end,
  },
  {
    'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = {},
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_mappings()
    end,
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>ud', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undotree' },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  { 'lambdalisue/suda.vim' },
}
