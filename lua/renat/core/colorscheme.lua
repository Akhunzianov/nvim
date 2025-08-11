-- set colorscheme with protected call
local status, _ = pcall(vim.cmd, "colorscheme cyberdream")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end
