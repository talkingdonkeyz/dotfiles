local ok, obsidian = pcall(require, "obsidian")
if not ok then
  return
end

obsidian.setup({
  workspaces = {
    -- Dynamic workspace so Obsidian features work outside a fixed vault too
    {
      name = "no-vault",
      path = function()
        return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
      end,
      overrides = {
        notes_subdir = vim.NIL,
        new_notes_location = "current_dir",
        templates = { folder = vim.NIL },
        disable_frontmatter = true,
      },
    },
  },

  -- Optional: use Telescope as picker if available
  picker = {
    name = "telescope.nvim",
  },

  -- Recommended keymaps: let plugin set buffer-local maps (e.g., gf passthrough)
  mappings = {},

  -- Completion is auto-enabled via nvim-cmp when in markdown buffers
})



