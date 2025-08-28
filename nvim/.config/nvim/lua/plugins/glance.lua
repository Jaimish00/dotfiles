-- A pretty preview window for Neovim that provides VSCode-like peek preview functionality for LSP locations.
-- https://github.com/DNLHC/glance.nvim

return {
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    lazy = true,
    keys = {
      { "gD", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
      { "gR", "<cmd>Glance references<cr>", desc = "Glance references" },
      { "gY", "<cmd>Glance type_definitions<cr>", desc = "Glance type_definitions" },
      { "gM", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
    },
  },
}
