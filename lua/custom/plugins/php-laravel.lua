-- PHP and Laravel development setup

return {
  -- PHP Treesitter grammar
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "php",
        "phpdoc",
        "html",
        "blade",
      })
    end,
  },

  -- Blade syntax highlighting
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },

  -- PHP CS Fixer for formatting
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        php = { "php_cs_fixer", "pint" },
        blade = { "blade-formatter" },
      })
      
      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
            "--using-cache=no",
            "--allow-risky=yes",
          },
          stdin = false,
        },
        pint = {
          command = "vendor/bin/pint",
          args = { "$FILENAME" },
          stdin = false,
          cwd = require("conform.util").root_file({ "composer.json" }),
        },
      })
      
      return opts
    end,
  },

  -- PHP Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local fmt = require("luasnip.extras.fmt").fmt

      -- PHP specific snippets
      ls.add_snippets("php", {
        -- Laravel controller method
        s("lmethod", fmt([[
public function {}({})
{{
    {}
}}
        ]], {
          i(1, "index"),
          i(2, "Request $request"),
          i(3, "// TODO: Implement method"),
        })),

        -- Laravel route model binding
        s("lroute", fmt([[
Route::{}('{}', [{}::class, '{}']){};
        ]], {
          c(1, {
            t("get"),
            t("post"),
            t("put"),
            t("patch"),
            t("delete"),
          }),
          i(2, "path"),
          i(3, "Controller"),
          i(4, "method"),
          i(5, ""),
        })),

        -- Laravel validation
        s("lvalidate", fmt([[
$request->validate([
    '{}' => '{}',
]);
        ]], {
          i(1, "field"),
          i(2, "required|string"),
        })),

        -- Laravel model fillable
        s("lfillable", fmt([[
protected $fillable = [
    '{}',
];
        ]], {
          i(1, "field"),
        })),

        -- Laravel relationship
        s("lrel", fmt([[
public function {}()
{{
    return $this->{}({});
}}
        ]], {
          i(1, "relation"),
          c(2, {
            t("hasMany"),
            t("belongsTo"),
            t("hasOne"),
            t("belongsToMany"),
          }),
          i(3, "Model::class"),
        })),
      })

      -- Blade snippets
      ls.add_snippets("blade", {
        s("@if", fmt([[
@if({})
    {}
@endif
        ]], {
          i(1, "condition"),
          i(2, "<!-- content -->"),
        })),

        s("@foreach", fmt([[
@foreach({} as {})
    {}
@endforeach
        ]], {
          i(1, "$items"),
          i(2, "$item"),
          i(3, "<!-- content -->"),
        })),

        s("@component", fmt([[
<x-{} {}>
    {}
</x-{}>
        ]], {
          i(1, "component-name"),
          i(2, ":prop=\"$value\""),
          i(3, "<!-- slot content -->"),
          f(function(args) return args[1][1] end, {1}),
        })),
      })
    end,
  },

  -- PHP Debug Adapter
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "php-debug-adapter" })
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },

  -- Better PHP indentation
  {
    "2072/PHP-Indenting-for-VIm",
    ft = "php",
  },

  -- PHPActor - PHP refactoring tool
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev -o",
    config = function()
      vim.keymap.set("n", "<leader>pm", ":PhpactorContextMenu<CR>", { desc = "PHPActor Menu" })
      vim.keymap.set("n", "<leader>pn", ":PhpactorClassNew<CR>", { desc = "PHPActor New Class" })
      vim.keymap.set("n", "<leader>pe", ":PhpactorExtractMethod<CR>", { desc = "PHPActor Extract Method" })
    end,
  },
}