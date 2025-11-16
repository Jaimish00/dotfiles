vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- Helper function to get session file path for current directory
local function get_session_file()
  local cwd = vim.fn.getcwd()
  local session_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/")
  local session_name = cwd:gsub("/", "%%"):gsub(" ", "%%20")
  return session_dir .. session_name .. ".vim"
end

-- Auto-restore session early if it exists (before dashboard loads)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      local session_file = get_session_file()
      if vim.fn.filereadable(session_file) == 1 then
        vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
      end
    end
  end,
  nested = true,
  once = true,
})

vim.schedule(function()
  require "mappings"
end)
