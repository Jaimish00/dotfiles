return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-file-browser.nvim",
      "cljoly/telescope-repo.nvim",
      "debugloop/telescope-undo.nvim",
      "tsakirist/telescope-lazy.nvim",
    },

    opts = {
      extensions_list = {
        "themes",
        "lazy",
        "terms",
        "zoxide",
        "file_browser",
        "repo",
        "undo",
      },
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
      defaults = {
        file_ignore_patterns = {
          -- Ignore gitignored files (this is handled by find_command)
        },
        -- Set default for find_files to show hidden files
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Show hidden files in grep
        },
      },
    },
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- Override the default find_files to always show hidden files but respect gitignore
      local builtin = require "telescope.builtin"
      local original_find_files = builtin.find_files

      builtin.find_files = function(opts)
        opts = opts or {}
        -- Always show hidden files unless explicitly disabled
        if opts.hidden == nil then
          opts.hidden = true
        end
        -- Respect gitignore by default
        if opts.no_ignore == nil then
          opts.no_ignore = false
        end
        if opts.no_ignore_parent == nil then
          opts.no_ignore_parent = false
        end

        -- Use fd if available and no custom find_command is provided
        if not opts.find_command and vim.fn.executable("fd") == 1 then
          -- fd respects .gitignore by default and --hidden shows dotfiles
          opts.find_command = {
            "fd",
            "--type",
            "f",
            "--hidden", -- Show dotfiles
            "--follow",
            "--exclude",
            ".git",
            -- Note: fd respects .gitignore by default (no --no-ignore flag)
          }
        end

        return original_find_files(opts)
      end

      -- Store the custom function globally for dashboard
      _G.telescope_find_files_custom = function()
        builtin.find_files()
      end
    end,
  },
}
