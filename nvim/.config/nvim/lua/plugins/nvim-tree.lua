return {
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 40,
        side = "right",
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      renderer = {
        root_folder_modifier = ":t",
        icons = {
          git_placement = "after",
          show = {
            hidden = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        custom = {},
        dotfiles = false,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true, -- Show folders even if they don't match, but their children might
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      local api = require("nvim-tree.api")

      -- Map 'f' to search_node which searches all nodes including collapsed ones
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "NvimTree",
        callback = function()
          vim.keymap.set("n", "f", api.tree.search_node, {
            buffer = true,
            desc = "Search node (deep search)",
            silent = true,
          })
        end,
      })
    end,
  },
}
