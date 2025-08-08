-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    layout_config = { horizontal = { preview_width = 0.5 } },
    vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
    },
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
      n = {
        ["q"] = require("telescope.actions").close,      -- Close with q in normal mode
        ["p"] = function()
          local picker = require("telescope.actions").get_current_picker(vim.fn.bufnr())
          local text = vim.fn.getreg('"') -- last yank
          local prompt = picker:_get_prompt()
          picker:set_prompt(prompt .. text)
        end,
      },
    }
  },
  pickers = {
    live_grep = {
        only_sort_text = true, -- Optional: Speeds up large searches
    },
  }
})

telescope.load_extension("fzf")
