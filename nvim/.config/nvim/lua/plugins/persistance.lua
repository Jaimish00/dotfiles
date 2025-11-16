return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- Directory where session files are stored
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      -- What to save in the session
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    },
    config = function(_, opts)
      local persistence = require("persistence")
      persistence.setup(opts)

      -- Check if nvim-tree is currently open
      local function is_nvim_tree_open()
        local ok, nvim_tree = pcall(require, "nvim-tree.api")
        if not ok then
          return false
        end
        -- Check if nvim-tree window exists
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
          if filetype == "NvimTree" then
            return true
          end
        end
        return false
      end

      -- Before saving session, check if nvim-tree is open, close it, and store state
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          local nvim_tree_was_open = is_nvim_tree_open()
          if nvim_tree_was_open then
            local ok, nvim_tree = pcall(require, "nvim-tree.api")
            if ok then
              nvim_tree.tree.close()
            end
          end
          -- Store state in a global variable (will be saved in session via "globals" option)
          vim.g._persistence_nvim_tree_was_open = nvim_tree_was_open and 1 or 0
          persistence.save()
        end,
      })

      -- After session is loaded, clean up empty nvim-tree buffers and restore nvim-tree
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Use a timer to ensure session is fully loaded
          vim.defer_fn(function()
            -- Close any empty nvim-tree buffers that might have been restored
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
              if filetype == "NvimTree" then
                local line_count = vim.api.nvim_buf_line_count(buf)
                if line_count == 0 or (line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "") then
                  vim.api.nvim_buf_delete(buf, { force = true })
                end
              end
            end

            -- Reopen nvim-tree if it was open before session save
            if vim.g._persistence_nvim_tree_was_open == 1 then
              local ok, nvim_tree = pcall(require, "nvim-tree.api")
              if ok then
                nvim_tree.tree.open()
              end
              vim.g._persistence_nvim_tree_was_open = nil
            end
          end, 100) -- 100ms delay to ensure session is loaded
        end,
        nested = true,
      })
    end,
  },
}
