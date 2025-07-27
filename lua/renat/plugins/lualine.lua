-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local lualine_16color = require("lualine.themes.base16")

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_16color,
  },
  sections = {
    lualine_c = {
      { 'filename', path = 1 } -- relative path
      -- or path = 2 for full absolute path
    },
  },
})
