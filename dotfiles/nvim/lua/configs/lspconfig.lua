-- load defaults i.e lua_lsp
-- (also applies nvchad's capabilities/on_init to every server and its on_attach via LspAttach)
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pylsp"}

-- configuring single server, example: typescript
-- vim.lsp.config("ts_ls", { settings = { ... } })

vim.lsp.config("clangd", {
  cmd = { "clangd", "--clang-tidy", "--header-insertion=never", "--completion-style=detailed", "--background-index", "--pch-storage=memory","--fallback-style=llvm", "--function-arg-placeholders=0"}
})

vim.lsp.enable(servers)
