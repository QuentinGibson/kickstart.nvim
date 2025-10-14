# IntelliJ IDEA Keymap Configuration (Based on Your Neovim Setup)

This guide helps you configure IntelliJ IDEA to match your Neovim keybindings.

## Setup Instructions

1. **Open IntelliJ IDEA**
2. **Go to**: `File → Settings → Keymap`
3. **Create Custom Keymap**: Click gear icon → Duplicate → Name it "Neovim Style"
4. **Apply the mappings below**

## Core Navigation & Editing

### Window/Split Navigation
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `<C-h>` | Focus Left | `Window → Editor Tabs → Select Previous Tab` |
| `<C-l>` | Focus Right | `Window → Editor Tabs → Select Next Tab` |
| `<C-j>` | Focus Down | `Window → Active Tool Window → Go to Next Splitter` |
| `<C-k>` | Focus Up | `Window → Active Tool Window → Go to Previous Splitter` |
| `H` | Line Start | `Move Caret to Line Start` |
| `L` | Line End | `Move Caret to Line End` |

### File Operations
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `<leader>w` | Save File | `File → Save All` |
| `<leader>sf` | Find Files | `Navigate → Go to File` |
| `<leader>sg` | Live Grep | `Edit → Find → Find in Files` |
| `<leader>sw` | Search Word | `Edit → Find → Find Word at Caret` |
| `<leader><leader>` | Buffer List | `Navigate → Recent Files` |

## LSP-Like Features

### Code Navigation
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `gd` | Go to Definition | `Navigate → Declaration or Usages` |
| `gr` | Go to References | `Navigate → Declaration or Usages` |
| `gI` | Go to Implementation | `Navigate → Implementation(s)` |
| `<leader>D` | Type Definition | `Navigate → Type Declaration` |
| `<leader>ds` | Document Symbols | `Navigate → File Structure` |
| `<leader>ws` | Workspace Symbols | `Navigate → Symbol` |

### Code Actions
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `<leader>ca` | Code Actions | `Show Context Actions` |
| `<leader>rn` | Rename | `Refactor → Rename` |
| `<leader>f` | Format | `Code → Reformat Code` |

### React/TypeScript Specific
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `<leader>ri` | Add Imports | `Code → Optimize Imports` |
| `<leader>ro` | Organize Imports | `Code → Optimize Imports` |
| `<leader>rf` | Fix All | `Code → Code Cleanup` |

## Search & Telescope Equivalents

### Search Functions
| Nvim Keybind | IntelliJ Action | Suggested Keybind |
|--------------|-----------------|-------------------|
| `<leader>sh` | Help | `Help → Find Action` |
| `<leader>sk` | Keymaps | `File → Settings → Keymap` |
| `<leader>sd` | Diagnostics | `View → Tool Windows → Problems` |
| `<leader>sr` | Resume Search | `Edit → Find → Find Next` |
| `<leader>s.` | Recent Files | `Navigate → Recent Files` |

## Git Integration
| Nvim Keybind | IntelliJ Action | IntelliJ Setting Path |
|--------------|-----------------|----------------------|
| `<leader>hs` | Stage Hunk | `VCS → Git → Stage Hunk` |
| `<leader>hr` | Reset Hunk | `VCS → Git → Revert Hunk` |
| `<leader>hp` | Preview Hunk | `VCS → Git → Show Diff` |
| `<leader>hb` | Blame Line | `VCS → Git → Annotate with Git Blame` |

## Custom Keymap XML Export

To import these settings quickly, you can create a custom keymap:

1. **Export Current Keymap**: `File → Manage IDE Settings → Export Settings`
2. **Create the mappings manually** or use this template:

### Key Remapping Steps:

1. **Open Keymap Settings**: `Ctrl+Alt+S` → `Keymap`
2. **For each mapping above**:
   - Search for the IntelliJ action name
   - Right-click → `Add Keyboard Shortcut`
   - Press your desired key combination
   - Click `OK`

## Essential IntelliJ Actions to Map

### High Priority:
```
Ctrl+P → Navigate → Go to File (like <leader>sf)
Ctrl+Shift+F → Edit → Find → Find in Files (like <leader>sg)
Space Space → Navigate → Recent Files (like <leader><leader>)
Space w → File → Save All (like <leader>w)
```

### LSP Features:
```
gd → Navigate → Declaration or Usages
gr → Navigate → Declaration or Usages (same action, different context)
Space ca → Show Context Actions
Space rn → Refactor → Rename
Space f → Code → Reformat Code
```

## Plugin Recommendations

1. **IdeaVim**: Essential vim emulation plugin
2. **AceJump**: Quick navigation similar to vim motions
3. **String Manipulation**: Text transformation tools
4. **GitToolBox**: Enhanced git integration

## IdeaVim Configuration

If you install IdeaVim plugin, create `~/.ideavimrc`:

```vim
" Leader key
let mapleader = " "

" Basic settings
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set hlsearch

" Clear search highlighting
nnoremap <Esc> :nohlsearch<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Line navigation
nnoremap H ^
nnoremap L $

" File operations
nnoremap <leader>w :w<CR>

" IntelliJ specific actions
nnoremap <leader>sf :action GotoFile<CR>
nnoremap <leader>sg :action FindInPath<CR>
nnoremap <leader><leader> :action RecentFiles<CR>
nnoremap gd :action GotoDeclaration<CR>
nnoremap gr :action FindUsages<CR>
nnoremap <leader>ca :action ShowIntentionActions<CR>
nnoremap <leader>rn :action RenameElement<CR>
nnoremap <leader>f :action ReformatCode<CR>
```

## Testing Your Setup

1. **Create a test file** in your project
2. **Test these key mappings**:
   - `gd` on a variable → Should go to definition
   - `<leader>sf` → Should open file picker
   - `<leader>ca` → Should show code actions
   - `<leader>rn` → Should rename symbol

Your IntelliJ should now feel much more like your Neovim setup!