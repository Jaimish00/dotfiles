require "nvchad.options"

-- add yours here!
-- vim.api.nvim_create_autocmd("BufDelete", {
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
--       vim.cmd "Nvdash"
--     end
--   end,
-- })
--
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

-- To make sure virtual edit work in virtual block mode
vim.opt.virtualedit = "block"
-- To tell neovim when let's say find and replace is doing, show a preview window instead of directly replacing it
vim.opt.inccommand = "split"
-- To tell neovim to ignore case when searching
vim.opt.ignorecase = true

-- Synchronizes system's clipboard with NeoVim's clipboard
-- plus is the registry that neovim uses for clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Set scroll offset so that the cursor is in middle all the time
--
vim.opt.scrolloff = 999

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!

vim.o.hidden = false
