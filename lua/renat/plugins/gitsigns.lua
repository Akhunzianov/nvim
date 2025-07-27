-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
  return
end

gitsigns.setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
  },
  signcolumn = true,  -- ✅ show in signcolumn (left gutter)
  numhl      = false, -- or true to highlight line numbers instead
  linehl     = false, -- or true to highlight entire line
  word_diff  = false, -- or true for intra-line diff highlights
})
