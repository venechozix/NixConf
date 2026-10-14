local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
        },
      },
    },
  },
})

-- Nix
vim.lsp.config("nil_ls", {
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" }
      },
    },
  },
})

-- C/C++
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  init_options = {
    fallbackFlags = { "-std=c23" },
  },
})

-- Enable servers
vim.lsp.enable({
  "lua_ls",
  "nil_ls",
  "clangd",
})
