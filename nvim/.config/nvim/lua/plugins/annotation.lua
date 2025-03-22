-- Annotation using neogen
return {
  {
    "danymat/neogen",
    config = function()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>ga", ":lua require('neogen').generate()<CR>", opts)
    end,
    version = "*",
  },
}
