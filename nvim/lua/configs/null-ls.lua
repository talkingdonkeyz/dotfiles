local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.credo.with({
      command = "mix",
    }),
  },
}

return opts



