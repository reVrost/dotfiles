require("nvchad.configs.lspconfig").defaults()

local attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Diagnostic configuration
vim.diagnostic.config {
  underline = true,
  virtual_text = true,
}

-- LSP servers with default config
local servers = { "pyright", "vls", "jdtls" }

for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  vim.lsp.enable(lsp) -- Enable each server
end

-- Solidity LSP
vim.lsp.config["solidity"] = {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = require("lspconfig.util").find_git_ancestor,
  single_file_support = true,
}
vim.lsp.enable "solidity"

-- Terraform LSP
vim.lsp.config["terraformls"] = {
  on_attach = attach,
  capabilities = capabilities,
  filetypes = { "terraform", "hcl" },
  flags = {
    exit_timeout = 5000,
    debounce_text_changes = 150,
  },
}
vim.lsp.enable "terraformls"

-- Go LSP
vim.lsp.config["gopls"] = {
  on_attach = attach,
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      -- linksInHover = false,
      -- codelenses = {
      --   generate = true,
      --   gc_details = true,
      --   regenerate_cgo = true,
      --   tidy = true,
      --   upgrade_depdendency = true,
      --   vendor = true,
      -- },
      -- usePlaceholders = true,
    },
  },
}
vim.lsp.enable "gopls"

-- TypeScript LSP (disable formatting)
vim.lsp.config["ts_ls"] = {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    attach(client) -- Ensure default on_attach is called
  end,
  capabilities = capabilities,
  flags = { debounce_text_changes = 300, exit_timeout = 5000 },
}
vim.lsp.enable "ts_ls"

-- Lua LSP
vim.lsp.config["lua_ls"] = {
  on_attach = attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
vim.lsp.enable "lua_ls"

-- Clangd LSP (excluding proto)
vim.lsp.config["clangd"] = {
  on_attach = attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- Exclude proto
}
vim.lsp.enable "clangd"

-- LspAttach autocommand for keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
