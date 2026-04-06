---@module "lazy"
---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  ---@module "gitsigns"
  ---@type Gitsigns.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    on_attach = function(buf)
      local gitsigns = require("gitsigns")

      -- Navigation
      Snacks.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { buf = buf, desc = "gitsigns: next hunk" })

      Snacks.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { buf = buf, desc = "gitsigns: previous hunk" })

      Snacks.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buf = buf, desc = "gitsigns: diff hunk" })
      Snacks.keymap.set("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { buf = buf, desc = "gitsigns: diff file" })

      -- Toggles
      Snacks.keymap.set(
        "n",
        "<leader>tb",
        gitsigns.toggle_current_line_blame,
        { buf = buf, desc = "gitsigns: toggle blame line" }
      )
      Snacks.keymap.set(
        "n",
        "<leader>tw",
        gitsigns.toggle_word_diff,
        { buf = buf, desc = "gitsigns: toggle word diff" }
      )
    end,
  },
}
