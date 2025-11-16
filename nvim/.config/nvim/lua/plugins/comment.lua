-- Comment.nvim is a plugin that provides a way to comment out code in Neovim.
-- https://github.com/numToStr/Comment.nvim
return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  }
}