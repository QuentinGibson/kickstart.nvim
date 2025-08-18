--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>ee', function()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end, { desc = 'Toggle relative line numbers' })

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>do', function()
  vim.diagnostic.open_float(nil, {
    focusable = true,
    border = 'rounded',
    source = true,
    scope = 'line', -- or 'cursor', or 'buffer'
  })
end, { desc = 'Open diagnostics popup' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', 'H', '^', { desc = 'Move cursor to start of the line' })
vim.keymap.set('n', 'L', '$', { desc = 'Move cursor to end of the line' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Save file quickly' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move cursor left in insert mode' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move cursor right in insert mode' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move cursor down in insert mode' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move cursor up in insert mode' })

-- React-specific keybindings
vim.keymap.set('n', '<leader>rc', function()
  -- Create a new React component in current buffer
  local component_name = vim.fn.input 'Component name: '
  if component_name == '' then
    return
  end
  local lines = {
    'interface ' .. component_name .. 'Props {',
    '  // Define props here',
    '}',
    '',
    'function ' .. component_name .. '({}: ' .. component_name .. 'Props) {',
    '  return (',
    '    <div>',
    '      ' .. component_name,
    '    </div>',
    '  )',
    '}',
    '',
    'export default ' .. component_name,
  }
  vim.api.nvim_put(lines, 'l', true, true)
end, { desc = '[R]eact: Create new [c]omponent' })

vim.keymap.set('v', '<leader>re', function()
  -- Extract selected JSX to a new component
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local component_name = vim.fn.input 'New component name: '
  if component_name == '' then
    return
  end

  -- Create the new component
  local new_component = {
    'interface ' .. component_name .. 'Props {',
    '  // Define props here',
    '}',
    '',
    'function ' .. component_name .. '({}: ' .. component_name .. 'Props) {',
    '  return (',
  }

  -- Add the selected lines with proper indentation
  for _, line in ipairs(lines) do
    table.insert(new_component, '    ' .. line)
  end

  table.insert(new_component, '  )')
  table.insert(new_component, '}')
  table.insert(new_component, '')

  -- Replace selection with component usage
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, { '<' .. component_name .. ' />' })

  -- Add the component definition at the end of file
  local buf_lines = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_buf_set_lines(0, buf_lines, buf_lines, false, new_component)

  print('Created component: ' .. component_name)
end, { desc = '[R]eact: [E]xtract to component' })

vim.keymap.set('n', '<leader>rh', function()
  -- Generate custom hook from selected code
  local hook_name = vim.fn.input 'Hook name (without "use" prefix): '
  if hook_name == '' then
    return
  end

  local lines = {
    'export function use' .. hook_name .. '() {',
    '  // Hook logic here',
    '  ',
    '  return {',
    '    // Return values',
    '  }',
    '}',
  }

  vim.api.nvim_put(lines, 'l', true, true)
end, { desc = '[R]eact: Create custom [h]ook' })

vim.keymap.set('n', '<leader>r?', function()
  local react_help = {
    '╭─────────────── React Development Tools ───────────────╮',
    '│                                                       │',
    '│ 📝 SNIPPETS (type + Tab):                            │',
    '│   sfc      → Simple functional component              │',
    '│   sfcp     → Functional component with props          │',
    '│   rfce     → React FC with export + import            │',
    '│   rafce    → Arrow FC with export                     │',
    '│   useState → const [state, setState] = useState()     │',
    '│   useEffect→ useEffect with cleanup                   │',
    '│   useCallback, useMemo, useRef → Hook snippets       │',
    '│   custom   → Custom hook template                     │',
    '│   ctx      → Context with provider & hook             │',
    '│                                                       │',
    '│ ⌨️  KEYBINDINGS:                                      │',
    '│   <leader>rc  → Create new component                  │',
    '│   <leader>re  → Extract JSX to component (visual)     │',
    '│   <leader>rh  → Create custom hook                    │',
    '│   <leader>ri  → Add missing imports                   │',
    '│   <leader>ro  → Organize imports                      │',
    '│   <leader>ru  → Remove unused imports                 │',
    '│   <leader>rf  → Fix all TypeScript errors             │',
    '│   <leader>rg  → Go to source definition               │',
    '│                                                       │',
    '│ 🚀 TIPS:                                              │',
    '│   • Ctrl+h/l in insert mode to move left/right       │',
    '│   • Auto-imports work on completion                   │',
    '│   • React hooks are prioritized in suggestions        │',
    '│                                                       │',
    '╰───────────────────────────────────────────────────────╯',
  }

  -- Create a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, react_help)

  local width = 60
  local height = #react_help
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- Close on any key press
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':close<CR>', { noremap = true, silent = true })
end, { desc = '[R]eact: Show [?]help for React tools' })

vim.keymap.set('n', '<leader>t?', function()
  local tmux_help = {
    '╭──────────────────── TMUX Keybindings ─────────────────────╮',
    '│  Prefix: Ctrl+a (C-a)                                      │',
    '│                                                            │',
    '│ 🪟 WINDOWS:                                                │',
    '│   C-a c      → Create new window                           │',
    '│   C-a ,      → Rename current window                       │',
    '│   C-a n/p    → Next/Previous window                        │',
    '│   C-a 0-9    → Switch to window by number                  │',
    '│   C-a w      → List all windows                            │',
    '│   C-a &      → Kill current window                         │',
    '│   C-a .      → Move window (prompt for new number)         │',
    '│   C-a </>    → Swap window left/right                      │',
    '│                                                            │',
    '│ 📐 PANES (tmux-pain-control):                              │',
    '│   C-a |      → Split vertically                            │',
    '│   C-a -      → Split horizontally                          │',
    '│   C-a h/j/k/l→ Navigate panes (vim-like)                   │',
    '│   C-a H/J/K/L→ Resize pane by 5 (shift + direction)        │',
    '│   C-a </>    → Move pane left/right                        │',
    '│   C-a z      → Toggle pane zoom                            │',
    '│   C-a x      → Kill current pane                           │',
    '│   C-a !      → Break pane into window                      │',
    '│   C-a Space  → Toggle pane layouts                         │',
    '│                                                            │',
    '│ 🎯 SESSIONS (tmux-sessionist):                             │',
    '│   C-a g      → Switch to session (prompt)                  │',
    '│   C-a C      → Create new session                          │',
    '│   C-a X      → Kill current session                        │',
    '│   C-a S      → Switch to last session                      │',
    '│   C-a @      → Promote window to session                   │',
    '│   C-a s      → List all sessions                           │',
    '│   C-a $      → Rename current session                      │',
    '│   C-a (/)    → Switch to previous/next session             │',
    '│                                                            │',
    '│ 📋 COPY MODE (vi-mode):                                    │',
    '│   C-a [      → Enter copy mode                             │',
    '│   v          → Start selection (in copy mode)              │',
    '│   V          → Line selection                              │',
    '│   C-v        → Rectangle selection                         │',
    '│   y          → Copy selection                              │',
    '│   C-a ]      → Paste                                       │',
    '│   q/Esc      → Exit copy mode                              │',
    '│                                                            │',
    '│ 🔍 SEARCH (tmux-copycat):                                  │',
    '│   C-a /      → Search (regex)                              │',
    '│   C-a C-f    → Simple file search                          │',
    '│   C-a C-g    → Git status files                            │',
    '│   C-a C-u    → URLs search                                 │',
    '│   C-a C-d    → Digits search                               │',
    '│   C-a M-h    → SHA-1 hashes                                │',
    '│   n/N        → Next/Previous match (in copy mode)          │',
    '│                                                            │',
    '│ 💾 RESURRECT:                                              │',
    '│   C-a C-s    → Save session                                │',
    '│   C-a C-r    → Restore session                             │',
    '│                                                            │',
    '│ 🎮 OTHER:                                                  │',
    '│   C-a ?      → Show all keybindings                        │',
    '│   C-a :      → Command prompt                              │',
    '│   C-a d      → Detach from session                         │',
    '│   C-a r      → Reload config                               │',
    '│   C-a t      → Show time                                   │',
    '╰────────────────────────────────────────────────────────────╯',
  }

  -- Create a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, tmux_help)

  local width = 65
  local height = #tmux_help
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
end, { desc = '[T]mux: Show [?]help for tmux keybindings' })

vim.keymap.set('n', '<leader>q?', function()
  local quickfix_help = {
    '╭────────────────── Quickfix List Guide ────────────────────╮',
    '│                                                            │',
    '│ 📋 OPENING QUICKFIX:                                       │',
    '│   :copen     → Open quickfix window                        │',
    '│   :cclose    → Close quickfix window                       │',
    '│   :cwindow   → Open only if there are items                │',
    '│   <leader>q  → Open diagnostic quickfix (configured)       │',
    '│                                                            │',
    '│ 🔍 NAVIGATION:                                             │',
    '│   :cnext/:cn → Go to next item                             │',
    '│   :cprev/:cp → Go to previous item                         │',
    '│   :cfirst    → Go to first item                            │',
    '│   :clast     → Go to last item                             │',
    '│   :[n]cc     → Go to item number [n]                       │',
    '│   <CR>       → Jump to item under cursor (in QF window)    │',
    '│                                                            │',
    '│ 📝 POPULATING QUICKFIX:                                    │',
    '│   :vimgrep /pattern/ **/*.js  → Search files               │',
    '│   :grep pattern files         → Use external grep          │',
    '│   :make                       → Run make & populate errors  │',
    '│   <leader>sd → Search diagnostics (Telescope)              │',
    '│   <leader>sg → Live grep (Telescope)                       │',
    '│                                                            │',
    '│ 🔧 QUICKFIX BUFFER COMMANDS:                               │',
    '│   o          → Open item (stay in QF)                      │',
    '│   <CR>       → Open item (close QF)                        │',
    '│   p          → Preview item                                │',
    '│   dd         → Remove item from list                       │',
    '│   :cdo {cmd} → Execute {cmd} on each file                  │',
    '│   :cfdo {cmd}→ Execute {cmd} on each unique file           │',
    '│                                                            │',
    '│ 📚 QUICKFIX HISTORY:                                       │',
    '│   :colder    → Go to older quickfix list                   │',
    '│   :cnewer    → Go to newer quickfix list                   │',
    '│   :chistory  → Show quickfix lists history                 │',
    '│                                                            │',
    '│ 🌍 LOCATION LIST (local to window):                        │',
    '│   :lopen     → Open location list                          │',
    '│   :lclose    → Close location list                         │',
    '│   :lnext     → Next location                               │',
    '│   :lprev     → Previous location                           │',
    '│                                                            │',
    '│ 💡 TIPS:                                                   │',
    '│   • :cgetbuffer → Load QF from current buffer              │',
    '│   • :caddexpr → Add expression results to QF               │',
    '│   • Set height: :copen 10                                  │',
    '│   • Filter list: :Cfilter[!] /pattern/                     │',
    '│   • QF is just a buffer - you can edit it!                 │',
    '╰────────────────────────────────────────────────────────────╯',
  }

  -- Create a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, quickfix_help)

  local width = 65
  local height = #quickfix_help
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
end, { desc = '[Q]uickfix: Show [?]help for quickfix list' })

vim.keymap.set('n', '<leader>c?', function()
  local commands_help = {
    '╭──────── Power Commands for React Development (: mode) ────────╮',
    '│                                                                │',
    '│ 🔄 MULTI-FILE OPERATIONS:                                      │',
    '│   :args **/*.tsx        → Load all TSX files into args        │',
    '│   :args `find . -name "*.test.tsx"` → Load all test files     │',
    '│   :argdo %s/old/new/ge | update → Replace in all arg files    │',
    '│   :bufdo %s/old/new/ge | update → Replace in all buffers      │',
    '│   :windo diffthis       → Diff all visible windows            │',
    '│   :tabdo windo set wrap → Set wrap in all tabs/windows        │',
    '│                                                                │',
    '│ 🎯 TARGETED SEARCH & REPLACE:                                  │',
    '│   :vimgrep /useState/ **/*.tsx → Find in all TSX files        │',
    '│   :cdo s/useState/React.useState/g → Replace in quickfix      │',
    '│   :cfdo %s/old/new/ge | update → Replace in QF files          │',
    '│   :g/console.log/d      → Delete all console.log lines        │',
    '│   :g!/^import/d         → Delete all non-import lines         │',
    '│   :v/test/d             → Keep only lines with "test"         │',
    '│                                                                │',
    '│ 🚀 REACT REFACTORING:                                          │',
    '│   :argdo %s/class=/className=/ge → Fix all class attributes   │',
    '│   :bufdo %s/<(\\w+)>/<\\1 \\/>/ge → Self-close empty tags      │',
    '│   :args src/**/*.tsx | argdo %s/Component/FC/ge → Rename type │',
    '│   :%s/\\v(use\\w+)\\(/const \\1 = \\1(/g → Destructure hooks    │',
    '│                                                                │',
    '│ 📦 IMPORT MANAGEMENT:                                          │',
    '│   :g/^import.*\\.css/m0 → Move CSS imports to top             │',
    '│   :g/^import {/s/}/} from/ → Fix import formatting            │',
    '│   :sort u /^import/     → Sort and dedupe imports             │',
    '│   :%!npx organize-imports-cli → Use external tool             │',
    '│                                                                │',
    '│ 🧪 TEST OPERATIONS:                                            │',
    '│   :Telescope grep_string search=describe → Find all tests     │',
    '│   :vimgrep /it\\(/ **/*.test.tsx → Find all test cases        │',
    '│   :args **/*.test.tsx | argdo normal gg=G → Format tests     │',
    '│   :cexpr system("npm test -- --listTests") → List tests in QF│',
    '│                                                                │',
    '│ 📝 CODE GENERATION:                                            │',
    '│   :read !echo "interface Props {}" → Insert interface         │',
    '│   :0read !cat ~/.config/nvim/templates/component.tsx → Template│',
    '│   :put =range(1,10)->map("v:val . \'. \'") → Number list     │',
    '│   :.!jq .              → Format JSON under cursor              │',
    '│                                                                │',
    '│ 🔍 ADVANCED PATTERNS:                                          │',
    '│   :%s/\\v<(\\w+)\\s+(\\w+)>/\\2 \\1/g → Swap word pairs          │',
    '│   :g/^\\s*\\/\\//d       → Remove all comment lines             │',
    '│   :%s/\\v"([^"]+)"/`\\1`/g → Convert quotes to backticks      │',
    '│   :g/TODO\\|FIXME\\|XXX/ → Show all code markers              │',
    '│                                                                │',
    '│ ⚡ PRODUCTIVITY COMBOS:                                        │',
    '│   :Telescope find_files | :argadd → Add found files to args   │',
    '│   :argdo TSToolsAddMissingImports | update → Fix imports     │',
    '│   :cdo normal @q       → Run macro on quickfix items          │',
    '│   :bufdo setlocal syntax=off | e → Reload all buffers        │',
    '│   :%s//\\=@"/g          → Replace with yanked text            │',
    '│                                                                │',
    '│ 💡 TIPS:                                                       │',
    '│   • Add "e" flag to suppress errors: /ge                      │',
    '│   • Use \\v for "very magic" regex mode                       │',
    '│   • Combine with | update to save changes                     │',
    '│   • Use :cdo for quickfix, :ldo for location list            │',
    '╰────────────────────────────────────────────────────────────────╯',
  }

  -- Create a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, commands_help)

  local width = 68
  local height = #commands_help
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
end, { desc = '[C]ommand-line: Show [?]help for power commands' })

-- NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>W', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              -- Highlight when yanking (copying) text
              --  Try it with `yap` in normal mode
              --  See `:help vim.highlight.on_yank()`
              vim.api.nvim_create_autocmd('TextYankPost', {
                desc = 'Highlight when yanking (copying) text',
                group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                callback = function()
                  vim.highlight.on_yank()
                end,
              })

              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {}, -- Disabled in favor of typescript-tools.nvim
        emmet_language_server = {},

        -- PHP Language Server
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
              },
              environment = {
                phpVersion = '8.2',
              },
              format = {
                enable = true,
              },
              stubs = {
                'bcmath',
                'bz2',
                'calendar',
                'Core',
                'curl',
                'date',
                'dba',
                'dom',
                'enchant',
                'fileinfo',
                'filter',
                'ftp',
                'gd',
                'gettext',
                'hash',
                'iconv',
                'imap',
                'intl',
                'json',
                'ldap',
                'libxml',
                'mbstring',
                'mcrypt',
                'mysql',
                'mysqli',
                'password',
                'pcntl',
                'pcre',
                'PDO',
                'pdo_mysql',
                'Phar',
                'readline',
                'recode',
                'Reflection',
                'regex',
                'session',
                'SimpleXML',
                'soap',
                'sockets',
                'sodium',
                'SPL',
                'standard',
                'superglobals',
                'sysvsem',
                'sysvshm',
                'tokenizer',
                'xml',
                'xdebug',
                'xmlreader',
                'xmlwriter',
                'yaml',
                'zip',
                'zlib',
                'wordpress',
                'phpunit',
              },
            },
          },
        },

        -- HTML Language Server (for Blade templates)
        html = {
          filetypes = { 'html', 'blade' },
        },

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'phpcs', -- PHP Code Sniffer
        'php-cs-fixer', -- PHP formatter
        'phpstan', -- PHP static analysis
        'blade-formatter', -- Laravel Blade formatter
        'pint', -- Laravel Pint formatter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 10000,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true, timeout_ms = 10000 },
        typescriptreact = { 'prettier', stop_after_first = true, timeout_ms = 10000 },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, true, true), 'n', true)
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Left>', true, true, true), 'n', true)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          {
            name = 'nvim_lsp',
            priority = 1000,
            entry_filter = function(entry, ctx)
              -- Prioritize React imports
              local kind = entry:get_kind()
              local label = entry:get_completion_item().label

              -- Check if it's a React-related import
              if
                label
                and (
                  label:match '^useState'
                  or label:match '^useEffect'
                  or label:match '^useCallback'
                  or label:match '^useMemo'
                  or label:match '^useRef'
                  or label:match '^useContext'
                  or label:match '^React'
                  or label:match '^Component'
                  or label:match '^Fragment'
                )
              then
                entry.completion_item.sortText = '0' .. (entry.completion_item.sortText or label)
              end

              return true
            end,
          },
          { name = 'luasnip', priority = 750 },
          { name = 'path', priority = 500 },
          { name = 'nvim_lsp_signature_help', priority = 400 },
        },
        sorting = {
          priority_weight = 1.0,
          comparators = {
            -- Prioritize exact matches and React imports
            function(entry1, entry2)
              local label1 = entry1.completion_item.label
              local label2 = entry2.completion_item.label

              -- Prioritize React hooks
              local react_hooks = { 'useState', 'useEffect', 'useCallback', 'useMemo', 'useRef', 'useContext' }
              for _, hook in ipairs(react_hooks) do
                if label1 and label1:match('^' .. hook) then
                  return true
                end
                if label2 and label2:match('^' .. hook) then
                  return false
                end
              end

              return nil
            end,
            require('cmp.config.compare').offset,
            require('cmp.config.compare').exact,
            require('cmp.config.compare').score,
            require('cmp.config.compare').recently_used,
            require('cmp.config.compare').locality,
            require('cmp.config.compare').kind,
            require('cmp.config.compare').sort_text,
            require('cmp.config.compare').length,
            require('cmp.config.compare').order,
          },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.move').setup()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
