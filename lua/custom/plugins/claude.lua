-- ~/.config/nvim/lua/config/claude.lua

-- Check if we're running inside tmux
local function is_tmux()
  return vim.env.TMUX ~= nil
end

-- Check if claude-code window exists
local function claude_window_exists()
  local result = vim.fn.system "tmux list-windows -F '#{window_name}' | grep -x 'claude-code'"
  return result ~= ''
end

-- Launch Claude Code in new tmux window or jump to existing one
local function launch_claude_code_tmux()
  if not is_tmux() then
    vim.notify('Not running in tmux session', vim.log.levels.WARN)
    return
  end

  -- Check if claude-code window already exists
  if claude_window_exists() then
    -- Jump to existing window
    vim.fn.jobstart('tmux select-window -t claude-code', {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify('Switched to existing Claude Code window', vim.log.levels.INFO)
        else
          vim.notify('Failed to switch to Claude Code window', vim.log.levels.ERROR)
        end
      end,
    })
  else
    -- Create new window with shell that keeps it open
    local cwd = vim.fn.getcwd()
    local tmux_cmd = string.format('tmux new-window -n "claude-code" -c "%s" "claude; exec $SHELL"', cwd)

    vim.fn.jobstart(tmux_cmd, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify('Claude Code launched in new tmux window', vim.log.levels.INFO)
        else
          vim.notify('Failed to launch Claude Code in tmux', vim.log.levels.ERROR)
        end
      end,
    })
  end
end

-- Create user command
vim.api.nvim_create_user_command('ClaudeCode', function()
  launch_claude_code_tmux()
end, {
  desc = 'Launch Claude Code in new tmux window or jump to existing one',
})

-- Keymap
vim.keymap.set('n', '<leader>cc', launch_claude_code_tmux, { desc = 'Claude Code' })
return {}
