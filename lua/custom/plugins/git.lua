return {
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
      { '<leader>lf', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit Current File' },
      { '<leader>lc', '<cmd>LazyGitFilter<cr>', desc = 'LazyGit Filter Commits' },
    },
    config = function()
      -- Configure lazygit settings
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_corner_chars = { '╭', '╮', '╰', '╯' } -- customize border chars
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

      -- Auto-commands for lazygit
      local group = vim.api.nvim_create_augroup('LazyGit', { clear = true })

      -- Auto-refresh git status when lazygit closes
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'LazyGitClose',
        callback = function()
          -- Refresh any git-related plugins
          vim.cmd 'checktime'
        end,
      })
    end,
  },

  -- Optional: Add other git-related plugins here
  -- {
  --   'lewis6991/gitsigns.nvim',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   config = function()
  --     require('gitsigns').setup({
  --       signs = {
  --         add = { text = '+' },
  --         change = { text = '~' },
  --         delete = { text = '_' },
  --         topdelete = { text = '‾' },
  --         changedelete = { text = '~' },
  --       },
  --     })
  --   end,
  -- },
}
