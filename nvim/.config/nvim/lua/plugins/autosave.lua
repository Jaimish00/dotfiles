-- auto-save.nvim is a lua plugin for automatically saving your changed buffers in Neovim
-- https://github.com/okuuva/auto-save.nvim
return {
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {},
    keys = {
      { "<leader>n", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
    },
  },
}
