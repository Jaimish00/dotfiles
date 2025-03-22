return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require("mini.surround").setup()

      -- Animate nvim actions
      require("mini.animate").setup()

      -- Go forward/backward with square brackets
      require("mini.bracketed").setup()

      -- Jump quickly in 2D space
      require("mini.jump2d").setup()

      -- Miscellaneous tools
      require("mini.misc").setup()

      -- Move lines and selections
      require("mini.move").setup()

      -- Split and join arguments
      require("mini.splitjoin").setup()

      -- Arround and Inside textobjects
      require("mini.ai").setup()
    end,
  },
}
