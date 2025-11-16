-- Multiple cursors plugin for vim/neovim
-- https://github.com/mg979/vim-visual-multi
return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      -- Remap visual-multi keys - set as complete dictionary
      vim.g.VM_maps = {
        ["Find Under"] = "<leader>mn",
        ["Find Subword Under"] = "<leader>mn",
        ["Select All"] = "<leader>ma",
        ["Find Next"] = "<leader>mn",
        ["Find Prev"] = "<leader>mp",
        ["Skip Region"] = "<leader>ms",
        ["Remove Region"] = "<leader>mx",

         -- Vertical cursor creation (remapped from Ctrl+Down/Up for macOS)
         ["Add Cursor Down"] = "<leader>mj",      -- j for down
         ["Add Cursor Up"] = "<leader>mk",        -- k for up
      }
    end,
  }
}