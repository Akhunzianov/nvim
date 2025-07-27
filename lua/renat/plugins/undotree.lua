-- import undotree plugin safely
local setup, undotree = pcall(require, "undotree")
if not setup then
  return
end

vim.g.undotree_SplitWidth = 50

-- enable undotree 
undotree.setup()
