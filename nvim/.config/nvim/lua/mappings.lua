require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- UNBINDS S KEY
map({ "n", "x" }, "s", "<Nop>")

-- Dismiss Noice Message
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
map("n", "<ESC><ESC>", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- Terminal Keybindings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

-- minimize terminal split
vim.keymap.set("n", "<C-g>", "3<C-w>_")

-- Telescope keybindings
local builtin = require "telescope.builtin"
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", function()
  builtin.find_files {
    hidden = true,
  }
end, { desc = "[S]earch [F]iles (all)" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

map("n", "<leader>zi", "<cmd>Telescope zoxide list<CR>", { desc = "Zoxide List Directories" })
map("n", "<leader>tfb", "<cmd>Telescope file_browser<CR>", { desc = "Open File Browser" })
map("n", "<leader>u", "<cmd>Telescope undo<cr>")

map("n", "<leader>v", "<cmd>ToggleTerm size=40 direction=vertical<CR>", { desc = "Toggle Terminal Vertical" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Cokeline Mappings
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true, desc = "Cokeline Focus Prev" })
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true, desc = "Cokeline Focus Next" })
map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true, desc = "Cokeline Switch Prev" })
map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true, desc = "Cokeline Switch Next" })
map("n", "<Leader>x", "<Plug>(cokeline-pick-delete)", { silent = true, desc = "Cokeline Pick Delete" })
map("n", "<leader>X", "<cmd>bd<CR>", { desc = "Force Close current buffer" })

for i = 1, 9 do
  map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
  map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
end

-- Glance Mappings
vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")

-- Persistance
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Load session (persistence)" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end, { desc = "Select session (persistence)" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load { last = true }
end, { desc = "Load last session (persistence)" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Stop persistence (persistence)" })
