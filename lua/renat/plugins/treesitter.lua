-- import treesitter plugin safely
local setup, treesitter = pcall(require, "nvim-treesitter")
if not setup then
  return
end

-- enable treesitter 
treesitter.setup({
  ensure_installed = {
    "lua", "python", "c", "cpp", "bash", "json", "vim", "markdown",
    "javascript", "typescript", "html", "css", "yaml"
  }, -- parsers to install

  sync_install = false,

  auto_install = true,       -- auto-install missing parsers on buffer open
  highlight = {
    enable = true,           -- enable Tree-sitter-based syntax highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,           -- enable better indentation
  },
})
