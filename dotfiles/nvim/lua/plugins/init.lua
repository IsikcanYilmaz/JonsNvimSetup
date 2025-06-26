return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
  	},
  },
  
  {
    "junegunn/fzf",
    lazy = false
  },

  {
    "mhinz/vim-grepper",
    lazy = false
  },

  {
    "preservim/tagbar",
    lazy = false
  },

  {
    'tpope/vim-fugitive'
  },

  {
    'tpope/vim-rhubarb'
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true, 
    lazy = false
  }, 

  { 'sindrets/diffview.nvim', 
    requires='nvim-lua/plenary.nvim' 
  },

}


