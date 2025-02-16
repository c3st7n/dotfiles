return {
    "tanvirtin/monokai.nvim",
    "folke/tokyonight.nvim",
--  "folke/neodev.nvim",
  "folke/which-key.nvim",
  --{ "folke/neoconf.nvim", cmd = "Neoconf" },
   {
    "neovim/nvim-lspconfig",  -- Core LSP configurations
    dependencies = {
      "williamboman/mason.nvim",          -- LSP installer
      "williamboman/mason-lspconfig.nvim" -- Bridge between Mason & LSPConfig
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "gopls" },  -- Automatically install Go LSP
      }

      local lspconfig = require("lspconfig")
      lspconfig.gopls.setup {} -- Enable Go LSP
    end,
  },

  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",  -- LSP completion source
    "L3MON4D3/LuaSnip"       -- Snippet support
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }
      })
    })
  end
},

    {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },


    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
          local configs = require("nvim-treesitter.configs")
          configs.setup({
              ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "javascript", "html" },
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true },
            })
        end
    }

}
