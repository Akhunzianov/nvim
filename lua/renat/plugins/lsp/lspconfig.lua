local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then return end

local cmp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status then return end

local saga_status, saga = pcall(require, "lspsaga")
if saga_status then
  saga.setup({})
end

local keymap = vim.keymap

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local servers = { "clangd", "pyright", "gopls" }  -- add more as needed

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function(fname)
      return require("lspconfig.util").find_git_ancestor(fname) or vim.loop.cwd()
    end,
  })
end

