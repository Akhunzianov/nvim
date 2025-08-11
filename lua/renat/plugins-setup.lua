-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("bluz71/vim-nightfly-guicolors")
  use("VonHeikemen/little-wonder")
  use("mulianov/molokai")
  use("marko-cerovac/material.nvim")
  use("scottmckendry/cyberdream.nvim")

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  use("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  use("nvim-lua/plenary.nvim")

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- flash
  use {
    "folke/flash.nvim",
  }

  -- gitsigns
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- surround
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  }

  -- git actions support
  use("tpope/vim-fugitive")

  -- undo tree
  use("mbbill/undotree")

  -- harpoon
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",  -- use latest version (v2)
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- brackets autopair 
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",                            -- load before reading the file
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      -- put your setup here so it runs when plugin loads
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end
      configs.setup({
        ensure_installed = { "cpp","c","lua","python","bash","json","vim","markdown","javascript","typescript","html","css","yaml" },
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      })
    end,
  }

  -- managing and installing lsp server
  use {
    'williamboman/mason.nvim',
    run = ':MasonUpdate',               -- keep its catalog up-to-date
    config = function()
      require('mason').setup()          -- ← must happen before any :Mason command
    end,
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',               -- ensure mason is already loaded
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 'clangd', 'cmake' },
      }
    end,
  }

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    requires = { "nvim-tree/nvim-web-devicons" },
    -- lazy-load on any LSP attach (so your lspconfig has run and your setup is in place)
    -- event = "LspAttach",
    -- OR lazy-load only when you actually invoke a saga command:
    cmd = { "Lspsaga", "LSoutlineToggle", "Lspsaga lsp_finder" },

    config = function()
      require("lspsaga").setup({
        move_in_saga = { prev = "<C-k>", next = "<C-j>" },
        finder = { },
        definition = { edit = "<CR>" },
        symbol_in_winbar = { enable = false },
      })
    end,
  }
  if packer_bootstrap then
    require("packer").sync()
  end
end)
