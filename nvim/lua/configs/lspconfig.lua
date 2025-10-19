require("nvchad.configs.lspconfig").defaults()

-- Ported servers and settings from your old custom config
local servers = { "clangd", "elixirls", "rust_analyzer", "html", "cssls" }

for _, name in ipairs(servers) do
  local opts = {
    on_attach = require("nvchad.configs.lspconfig").on_attach,
    capabilities = require("nvchad.configs.lspconfig").capabilities,
  }

  if name == "clangd" then
    opts.on_attach = function(client, bufnr)
      client.server_capabilities.signatureHelpProvider = false
      require("nvchad.configs.lspconfig").on_attach(client, bufnr)
    end
  elseif name == "elixirls" then
    opts.cmd = { "elixir-ls" }
    opts.settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
        enableTestLenses = true,
      },
    }
  end

  if vim.lsp and vim.lsp.config and vim.lsp.enable then
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
  else
    -- Fallback for older Neovim
    require("lspconfig")[name].setup(opts)
  end
end

-- read :h vim.lsp.config for changing options of lsp servers 
