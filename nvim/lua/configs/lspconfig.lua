require("nvchad.configs.lspconfig").defaults()

local servers = require("configs.servers")

for _, name in ipairs(servers) do
  if name == "clangd" then
    vim.lsp.config(name, {
      on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
      end,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
    })
  elseif name == "elixirls" then
    vim.lsp.config(name, {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
      cmd = { "elixir-ls" },
      settings = {
        elixirLS = {
          dialyzerEnabled = true,
          fetchDeps = false,
          enableTestLenses = true,
        },
      },
    })
  end
end

vim.lsp.enable(servers)


-- read :h vim.lsp.config for changing options of lsp servers
