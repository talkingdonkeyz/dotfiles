require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- LSP telescope mappings
map("n", "<leader>lD", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP: Telescope definitions" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP: Telescope references" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP: Telescope implementations" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
