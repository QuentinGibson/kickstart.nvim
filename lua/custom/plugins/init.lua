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
}
