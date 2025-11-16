-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "vesper",
  -- transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = function()
    -- Check if a persistence.nvim session exists for current directory
    -- Only show dashboard if no session exists
    if vim.fn.argc() == 0 then
      local cwd = vim.fn.getcwd()
      local session_dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/")
      local session_name = cwd:gsub("/", "%%"):gsub(" ", "%%20")
      local session_file = session_dir .. session_name .. ".vim"

      if vim.fn.filereadable(session_file) == 1 then
        return false -- Don't load dashboard if session exists
      end
    end
    return true
  end,
  header = {
    "                                                                       ",
    "                                                                     ",
    "       ████ ██████           █████      ██                     ",
    "      ███████████             █████                             ",
    "      █████████ ███████████████████ ███   ███████████   ",
    "     █████████  ███    █████████████ █████ ██████████████   ",
    "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
    "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
    " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
    "                                                                       ",
  },
  buttons = {
    { txt = "🔍 Find File", keys = "ff", cmd = "lua require('telescope.builtin').find_files()" },
    { txt = "♻️  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "💬 Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "🚀 Change Current Directory", keys = "zi", cmd = "Telescope zoxide list" },
    { txt = "📖 Open File Browser", keys = "tfb", cmd = "Telescope file_browser" },
    { txt = "🎨 Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "💻 Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {
  tabufline = {
    lazyload = false,
    enabled = false,
  },
  telescope = {
    style = "bordered",
  },
  cmp = {
    style = "atom_colored",
  },
}

return M
