-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require("nvim-tree.api")

-- Custom keybinding function
local function change_root_to_node()
  local node = api.tree.get_node_under_cursor()
  if node and node.type == "directory" then
    api.tree.change_root_to_node(node)
  end
end

-- Attach custom mappings
local function on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)

  local function map(key, func, desc)
    vim.keymap.set("n", key, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end
  map("<leader>cd", change_root_to_node, "Change root to directory under cursor")
end

nvimtree.setup({
  on_attach = on_attach,
  actions = {
    open_file = {
      quit_on_open = true, -- 🔐 Automatically close the tree
    },
  },
  git = {
    enable = true,         -- ✅ turn on git status
    ignore = false,        -- show `.gitignored` files too (optional)
    timeout = 400,         -- ms to wait for git info
  },
  renderer = {
    highlight_git = true,  -- ✅ color code git status
    icons = {
      show = {
        git = false,        -- ✅ show git icons in file tree
      },
    },
  },
})
