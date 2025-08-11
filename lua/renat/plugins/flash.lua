-- import flash safely
local ok, flash = pcall(require, "flash")
if not ok then
  return
end

flash.setup({
  modes = {
    search = {
        enable = true;
    },
    char = {
      jump_labels = true,
    },
  },
})
