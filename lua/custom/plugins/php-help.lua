-- PHP/Laravel help documentation
return {
  {
    "folke/which-key.nvim",
    config = function()
      vim.keymap.set('n', '<leader>p?', function()
        local php_help = {
          '╭────────────────── PHP/Laravel Development Guide ──────────────────╮',
          '│                                                                    │',
          '│ 🐘 PHP LSP FEATURES:                                               │',
          '│   gd        → Go to definition                                    │',
          '│   gr        → Find references                                     │',
          '│   gI        → Go to implementation                                │',
          '│   K         → Show hover documentation                            │',
          '│   <leader>rn→ Rename symbol                                       │',
          '│   <leader>ca→ Code actions                                        │',
          '│   <leader>f → Format file                                         │',
          '│                                                                    │',
          '│ 📝 PHP SNIPPETS (type + Tab):                                     │',
          '│   lmethod   → Laravel controller method                           │',
          '│   lroute    → Laravel route definition                            │',
          '│   lvalidate → Request validation                                  │',
          '│   lfillable → Model fillable array                               │',
          '│   lrel      → Model relationship                                  │',
          '│                                                                    │',
          '│ 🌿 BLADE SNIPPETS:                                                │',
          '│   @if       → Blade if statement                                  │',
          '│   @foreach  → Blade foreach loop                                  │',
          '│   @component→ Blade component                                     │',
          '│                                                                    │',
          '│ 🔧 FORMATTING & LINTING:                                           │',
          '│   • PHP-CS-Fixer: Auto-formats on save                            │',
          '│   • Laravel Pint: Alternative formatter                           │',
          '│   • PHPStan: Static analysis tool                                 │',
          '│   • Blade formatter: For .blade.php files                         │',
          '│                                                                    │',
          '│ ⚙️  INSTALLED TOOLS:                                               │',
          '│   • Intelephense - PHP Language Server                            │',
          '│   • PHP CS Fixer - Code formatting                                │',
          '│   • PHPStan - Static analysis                                     │',
          '│   • Blade formatter - Blade template formatting                   │',
          '│                                                                    │',
          '│ 💡 TIPS:                                                           │',
          '│   • Run :Mason to manage PHP tools                                │',
          '│   • Format on save is enabled for PHP files                       │',
          '│   • Blade files have full HTML/PHP support                        │',
          '│   • Use :checkhealth to verify setup                              │',
          '│                                                                    │',
          '╰────────────────────────────────────────────────────────────────────╯',
        }
        
        -- Create a floating window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, php_help)
        
        local width = 72
        local height = #php_help
        local win_opts = {
          relative = 'editor',
          width = width,
          height = height,
          col = (vim.o.columns - width) / 2,
          row = (vim.o.lines - height) / 2 - 2,
          style = 'minimal',
          border = 'rounded',
        }
        
        local win = vim.api.nvim_open_win(buf, true, win_opts)
        
        -- Set buffer options
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)
        vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
        
        -- Add syntax highlighting for better readability
        vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:FloatBorder')
        
        -- Close on any key press
        vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':close<CR>', { noremap = true, silent = true })
      end, { desc = '[P]HP: Show [?]help for PHP/Laravel development' })
    end,
  },
}