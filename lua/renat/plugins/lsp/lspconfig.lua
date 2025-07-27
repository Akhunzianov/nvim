local lspcnofig_status, lspconfig = pcall(require, "lspconfig")
if not lspcnofig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap

local on_attach = function (client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds keymap. set ("n"
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostics_jump_prev<CR>", opts)
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostics_jump_next<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function(fname)
    return require("lspconfig.util").find_git_ancestor(fname) or vim.loop.cwd()
  end,
})
