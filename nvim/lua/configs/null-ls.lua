local null_ls = require "null-ls"

local opts = {
  sources = {
    null_ls.builtins.diagnostics.credo.with({
      command = "mix",
    }),
  },
}

return opts
