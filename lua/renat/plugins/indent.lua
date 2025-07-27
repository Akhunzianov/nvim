-- import indent plugin safely
local status, ibl = pcall(require, "ibl")
if not status then
  return
end

ibl.setup({
  indent = {
    char = "┃",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
  },
})
