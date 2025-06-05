local options = {
  -- formatters = {
  --   buf = {
  --     command = "buf",
  --     args = { "format", "--global", "vim" },
  --     stdin = true,
  --   },
  -- },
  formatters_by_ft = {
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    less = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    markdown = { "prettierd" },
    graphql = { "prettierd" },
    handlebars = { "prettierd" },
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    proto = { "buf" },
    sh = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 300,
    lsp_format = "fallback",
  },
}

return options
