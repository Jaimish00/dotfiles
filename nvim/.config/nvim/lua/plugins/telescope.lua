return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-file-browser.nvim",
      "cljoly/telescope-repo.nvim",
      "debugloop/telescope-undo.nvim",
    },

    opts = {
      extensions_list = { "themes", "terms", "zoxide", "file_browser", "repo", "undo" },
      extensions = {
        zoxide = {
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end,
            },
            ["<C-s>"] = {
              before_action = function(selection)
                print "before C-s"
              end,
              action = function(selection)
                vim.cmd.edit(selection.path)
              end,
            },
            -- Opens the selected entry in a new split
            ["<C-q>"] = {
              action = function()
                require("telescope._extensions.zoxide.utils").create_basic_command "split"
              end,
            },
          },
        },
      },
    },
  },
}
