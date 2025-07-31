return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {
      settings = {
        -- Array of strings to pass to tsserver as command line arguments
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = 'auto',
        },
        -- Configure tsserver to enable auto imports
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
        -- Enable auto-import suggestions
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        code_lens = 'off',
        -- Diagnostic options
        expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
      },
    },
    config = function(_, opts)
      require('typescript-tools').setup(opts)

      -- Set up keymaps when tsserver attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'typescript-tools' then
            local bufnr = args.buf
            local function buf_set_keymap(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- TypeScript specific keymaps
            buf_set_keymap('n', '<leader>ri', '<cmd>TSToolsAddMissingImports<cr>', '[R]eact: Add missing [i]mports')
            buf_set_keymap('n', '<leader>ro', '<cmd>TSToolsOrganizeImports<cr>', '[R]eact: [O]rganize imports')
            buf_set_keymap('n', '<leader>ru', '<cmd>TSToolsRemoveUnused<cr>', '[R]eact: Remove [u]nused')
            buf_set_keymap('n', '<leader>rf', '<cmd>TSToolsFixAll<cr>', '[R]eact: [F]ix all')
            buf_set_keymap('n', '<leader>rg', '<cmd>TSToolsGoToSourceDefinition<cr>', '[R]eact: [G]o to source definition')
          end
        end,
      })
    end,
  },
}