return {
  {
    "ya2s/nvim-cursorline",
    config = function()
      local cursorline = require "nvim-cursorline"
      cursorline.setup {
        cursorline = {
          enable = true,
          timeout = 500,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      }
    end,
  },
}
