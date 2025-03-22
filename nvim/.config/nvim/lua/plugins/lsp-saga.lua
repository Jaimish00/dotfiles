return {
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        breadcrumb = {
          enabled = true,
        },
      }
    end,
  },
}
