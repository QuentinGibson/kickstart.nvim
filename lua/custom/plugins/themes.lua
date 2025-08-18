-- ~/.config/nvim/lua/plugins/themes.lua

return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        -- Add any cyberdream-specific config here
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        theme = {
          variant = 'default', -- use "light" for the light variant. Also accepts "auto" to set it based on vim.o.background
          highlights = {
            -- Highlight groups to override, adding new groups is also possible
            -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

            -- Example:
            Comment = { fg = '#696969', bg = 'NONE', italic = true },

            -- Complete themes can be found on https://github.com/scottmckendry/cyberdream.nvim/wiki
          },

          -- Override a highlight group entirely using the color palette
          overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
            -- Example:
            return {
              Comment = { fg = colors.green, bg = 'NONE', italic = true },
              ['@property'] = { fg = colors.magenta, bold = true },
            }
          end,

          -- Override a color entirely
          colors = {
            -- For a list of colors see `lua/cyberdream/colours.lua`
            -- Example:
            bg = '#000000',
            green = '#00ff00',
            magenta = '#ff00ff',
          },
        },

        -- Disable or enable colorscheme extensions
        extensions = {
          telescope = true,
          notify = true,
          mini = true,
        },
      }

      -- Set the default colorscheme on startup
      vim.cmd.colorscheme 'cyberdream'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
          },
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
      }

      -- Set catppuccin as the default colorscheme
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
      require('transparent').setup {
        groups = {
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLineNr',
          'EndOfBuffer',
        },
        extra_groups = {},
        exclude_groups = {},
      }

      -- Uncomment to enable transparency by default
      -- require('transparent').clear_prefix('BufferLine')
      -- require('transparent').clear_prefix('NeoTree')
    end,
    keys = {
      { '<leader>tt', '<cmd>TransparentToggle<cr>', desc = 'Toggle Transparency' },
    },
  },
  -- Theme toggler plugin
  {
    "theme-toggler",
    dir = vim.fn.stdpath("config") .. "/lua/custom/plugins",
    name = "theme-toggler",
    lazy = false,
    config = function()
      local current_theme_index = 1
      local themes = {
        'cyberdream',
        'catppuccin',
        'default', -- Neovim's default theme
      }

      local function toggle_theme()
        current_theme_index = current_theme_index + 1
        if current_theme_index > #themes then
          current_theme_index = 1
        end

        local theme = themes[current_theme_index]
        vim.cmd.colorscheme(theme)

        -- Show notification of current theme
        vim.notify('Theme: ' .. theme, vim.log.levels.INFO, { title = 'Colorscheme' })
      end

      -- Telescope theme picker
      local function theme_picker()
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local conf = require('telescope.config').values
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        -- Get all available colorschemes
        local colorschemes = vim.fn.getcompletion('', 'color')

        pickers.new({}, {
          prompt_title = 'Select Theme',
          finder = finders.new_table {
            results = colorschemes,
          },
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                vim.cmd.colorscheme(selection[1])
                vim.notify('Theme set to: ' .. selection[1], vim.log.levels.INFO, { title = 'Colorscheme' })
              end
            end)
            
            -- Preview theme on selection
            local function preview_theme()
              local selection = action_state.get_selected_entry()
              if selection then
                vim.cmd.colorscheme(selection[1])
              end
            end
            
            map('i', '<C-p>', preview_theme)
            map('n', '<C-p>', preview_theme)
            
            -- Auto-preview on navigation
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = prompt_bufnr,
              callback = preview_theme,
            })
            
            return true
          end,
        }):find()
      end

      -- Global keymaps
      vim.keymap.set('n', '<leader>to', toggle_theme, { desc = 'Toggle themes' })
      vim.keymap.set('n', '<leader>tp', theme_picker, { desc = 'Pick theme with Telescope' })
    end,
  },
}
