-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>") -- find marks in
keymap.set("n", "<leader>fp", function()
  require("telescope.builtin").grep_string({ search = vim.fn.getreg('+') })
end, { desc = "Search last yanked text" })

-- harpoon
local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end
keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
keymap.set("n", "<leader>ht", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
keymap.set("n", "<leader>hn", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
keymap.set("n", "<leader>hs", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

-- undotree
keymap.set("n", "<leader>u", ":UndotreeToggle | UndotreeFocus<CR>")

-- fugitive
keymap.set("n", "<leader>gs", ":vertical Git<CR>")           -- Git status
keymap.set("n", "<leader>gc", ":vertical Git commit<CR>")    -- Git commit
keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>")    -- Git diff in split
keymap.set("n", "<leader>gb", ":vertical Git branch | vertical resize 50<CR>")     -- Git blame

-- flash
keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
keymap.set("o", "r", function() require("flash").remote() end, { desc = "Flash remote" })
keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Flash TS search" })
keymap.set("c", "<C-s>", function() require("flash").toggle() end, { desc = "Flash toggle" })
