return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    options = {
      triggers = {
        { "<auto>", mode = "nixsotc" },
        { "s", mode = { "n", "v" } },
      },
    },
  },
}
