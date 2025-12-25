local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ===================
  -- Statusline + Tabline (lualine)
  -- ===================
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local c = {
        base03 = "#1c1c1c", base02 = "#262626", base01 = "#4e4e4e",
        base0 = "#808080", base2 = "#d7d7af", base3 = "#ffffd7",
        yellow = "#af8700", green = "#5f8700", blue = "#0087ff",
        magenta = "#af005f", red = "#af0000",
      }
      require("lualine").setup({
        options = { theme = {
          normal   = { a = { fg = c.base03, bg = c.green, gui = "bold" }, b = { fg = c.base2, bg = c.base01 }, c = { fg = c.base0, bg = c.base02 } },
          insert   = { a = { fg = c.base03, bg = c.blue, gui = "bold" } },
          visual   = { a = { fg = c.base03, bg = c.magenta, gui = "bold" } },
          replace  = { a = { fg = c.base03, bg = c.red, gui = "bold" } },
          command  = { a = { fg = c.base03, bg = c.yellow, gui = "bold" } },
          inactive = { a = { fg = c.base0, bg = c.base02 }, b = { fg = c.base0, bg = c.base02 }, c = { fg = c.base01, bg = c.base02 } },
        }},
        tabline = {
          lualine_a = {{ "buffers", symbols = { modified = " ●" },
            buffers_color = { active = { fg = c.base3, bg = c.base01, gui = "bold" }, inactive = { fg = c.base0, bg = c.base02 } } }},
          lualine_z = {{ "tabs",
            tabs_color = { active = { fg = c.base3, bg = c.base01, gui = "bold" }, inactive = { fg = c.base0, bg = c.base02 } } }},
        },
      })
    end,
  },


  -- ===================
  -- File tree
  -- ===================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = {
          icons = {
            show = {
              git = true,
              file = true,
              folder = true,
              folder_arrow = true,
            },
          },
        },
        -- Close vim if the only window left open is nvim-tree
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
      -- Auto-close if nvim-tree is the last window
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
          end
        end,
      })
    end,
  },

  -- ===================
  -- Treesitter
  -- Neovim 0.12+ has native treesitter
  -- ===================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
  },

  -- ===================
  -- Telescope
  -- ===================
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
    end,
  },

  -- ===================
  -- Git signs
  -- ===================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- ===================
  -- Git operations
  -- ===================
  { "tpope/vim-fugitive" },

  -- ===================
  -- Symbols outline
  -- ===================
  {
    "hedyhli/outline.nvim",
    config = function()
      require("outline").setup({
        outline_window = {
          position = "right",
          width = 25,
        },
        keymaps = {
          goto_location = { "<CR>", "<2-LeftMouse>" },  -- Enter or double-click to jump
        },
      })
    end,
  },

  -- ===================
  -- Auto-pairs
  -- ===================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,  -- Use treesitter
        map_cr = true,    -- Map <CR> to expand pairs (like delimitMate_expand_cr)
      })
    end,
  },

  -- ===================
  -- Completion
  -- ===================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP completion source
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },  -- LSP completions (highest priority)
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- ===================
  -- Easy align
  -- ===================
  { "junegunn/vim-easy-align" },

  -- ===================
  -- Mediawiki syntax
  -- ===================
  { "chikamichi/mediawiki.vim" },

  -- ===================
  -- Tmux navigator
  -- ===================
  { "christoomey/vim-tmux-navigator" },

})
