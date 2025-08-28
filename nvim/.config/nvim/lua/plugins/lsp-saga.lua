return {
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    config = function()
      require("lspsaga").setup {
        breadcrumb = {
          enabled = true,
        },
      }
    end,
  },
}
