# Neovim Configuration Guide for Claude Code

This document describes the current language setups and provides a template for adding new languages to your Neovim configuration.

## Current Language Support

### TypeScript/React
- **LSP**: typescript-tools.nvim (via lua/custom/plugins/react.lua)
- **Formatting**: prettier (via conform.nvim)
- **Features**: Auto imports, organize imports, TSX support, React hooks
- **Snippets**: Extensive shadcn/ui snippets and React components
- **Keybinds**: `<leader>r*` for React tools

### PHP/Laravel  
- **LSP**: intelephense (configured in init.lua:1239-1310)
- **Formatting**: php-cs-fixer, pint (Laravel), blade-formatter
- **Tools**: phpcs, phpstan for linting/analysis
- **Features**: Blade template support, Laravel stubs
- **Files**: lua/custom/plugins/php-laravel.lua

### Lua
- **LSP**: lua_ls (configured in init.lua:1317-1330)
- **Formatting**: stylua
- **Features**: Neovim API completion, lazydev integration

### HTML/CSS
- **LSP**: html (with Blade support)
- **LSP**: emmet_language_server for snippets

## Commands for Adding New Languages

### Basic Steps
1. Add LSP server to `servers` table in init.lua (~line 1224)
2. Add formatting tools to `ensure_installed` in init.lua (~line 1346) 
3. Add formatter to `formatters_by_ft` in init.lua (~line 1404)
4. Add treesitter parser to `ensure_installed` in init.lua (~line 1679)

### Java Setup Template
```lua
-- In servers table (init.lua:1224)
jdtls = {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/",
          }
        }
      },
      format = {
        settings = {
          url = vim.fn.stdpath('config') .. '/eclipse-java-google-style.xml',
        }
      }
    }
  }
},

-- In ensure_installed table (init.lua:1346)
'google-java-format', -- Java formatter
'checkstyle', -- Java linter

-- In formatters_by_ft (init.lua:1404)  
java = { 'google-java-format' },

-- In treesitter ensure_installed (init.lua:1679)
'java',
```

### Python Setup Template
```lua
-- In servers table
pyright = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
},

-- Tools
'black', 'isort', 'flake8', 'mypy',

-- Formatting
python = { 'black', 'isort' },
```

### Go Setup Template  
```lua
-- In servers table
gopls = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    }
  }
},

-- Tools
'gofumpt', 'golangci-lint',

-- Formatting
go = { 'gofumpt' },
```

### Rust Setup Template
```lua
-- In servers table
rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    }
  }
},

-- Tools (handled by rustup)
-- Formatting handled by rust-analyzer
```

## File Structure

### Main Configuration
- `init.lua` - Main config with LSP servers, formatting, keybinds
- `lua/custom/plugins/` - Language-specific plugin configurations
- `lua/kickstart/plugins/` - Kickstart base plugins

### Language-Specific Files
- `lua/custom/plugins/react.lua` - TypeScript/React setup
- `lua/custom/plugins/php-laravel.lua` - PHP/Laravel setup  
- `lua/custom/plugins/snippet.lua` - Custom snippets
- `lua/custom/plugins/themes.lua` - Catppuccin theme configuration

## Key Configuration Sections

### LSP Configuration (init.lua:988-1371)
- Server definitions in `servers` table (line 1224)
- Mason tool installer setup (line 1346)
- Auto-formatting with conform.nvim (line 1374)

### Completion Configuration (init.lua:1418-1607)
- nvim-cmp with radix-ui filtering
- Snippet integration with LuaSnip
- Custom entry filtering and prioritization

### Keybind Patterns
- `<leader>s*` - Search/Telescope commands
- `<leader>r*` - React/Rename commands  
- `<leader>c*` - Code actions
- `<leader>d*` - Diagnostics/Document
- `<leader>w*` - Workspace
- `<leader>f` - Format buffer

### Auto Commands
- Auto-save after 20 seconds in normal mode (line 681)
- LSP attach configurations (line 1018)
- Highlight on yank (line 672)

## Testing Commands

After adding a new language:
```bash
# Check LSP status
:LspInfo

# Check Mason installations  
:Mason

# Check formatting
:ConformInfo

# Test completion in a file of that language
# Test go-to-definition with gd
# Test formatting with <leader>f
```

## Adding Custom Snippets

Add to `lua/custom/plugins/snippet.lua`:
```lua
ls.add_snippets('java', {
  s('class', {
    t('public class '), i(1, 'ClassName'), t(' {'),
    t({'', '\t'}), i(2, '// class body'),
    t({'', '}'}),
  }),
})
```

## Notes
- Mason automatically installs LSP servers and tools
- Conform.nvim handles formatting with fallback to LSP
- Treesitter provides syntax highlighting
- Most LSP features work automatically once server is configured
- Check `:checkhealth` for any issues after adding languages