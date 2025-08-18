-- PHP specific keymaps

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>p", group = "[P]HP", icon = "🐘" },
      })
    end,
  },
}