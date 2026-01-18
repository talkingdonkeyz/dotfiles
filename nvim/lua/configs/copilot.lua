local M = {}

M.options = {
  suggestion = { enabled = false },
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>",
    },
  },
  filetypes = {
    markdown = true,
    help = false,
    gitcommit = true,
    gitrebase = true,
    ["dap-repl"] = false,
    ["*"] = true,
  },
  server_opts_overrides = {
    settings = {
      advanced = {
        inlineSuggestCount = 3,
      },
    },
  },
}

function M.setup()
  local ok_copilot, copilot = pcall(require, "copilot")
  if ok_copilot then
    copilot.setup(M.options)
  end

  local ok_cmp, copilot_cmp = pcall(require, "copilot_cmp")
  if ok_cmp then
    copilot_cmp.setup()
  end

  local ok_nvim_cmp, cmp = pcall(require, "cmp")
  if not ok_nvim_cmp then
    return
  end

  local sources = cmp.get_config().sources or {}
  local has_copilot = false

  for _, source in ipairs(sources) do
    if source.name == "copilot" then
      has_copilot = true
      break
    end
  end

  if not has_copilot then
    table.insert(sources, 1, { name = "copilot", group_index = 2 })
    cmp.setup { sources = sources }
  end
end

return M

