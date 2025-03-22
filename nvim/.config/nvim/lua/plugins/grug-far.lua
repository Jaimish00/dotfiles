-- Find And Replace plugin for neovim
-- https://github.com/MagicDuck/grug-far.nvim
return {
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup {}
    end,
  },
}
