local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  {
    'ishan9299/nvim-solarized-lua',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme solarized-flat')
    end,
  },
  'kyazdani42/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      require('telescope').setup({})
      require('telescope').load_extension('fzf')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'elixir' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      }
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {},
    keys = {
      {"<leader>tt", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>"},
      {"<leader>ts", "<cmd>Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<cr>"},
    }
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {"<leader>?", "<cmd>Cheatsheet<cr>"}
    }
  },
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'tpope/vim-projectionist',
  'c-brenn/fuzzy-projectionist.vim',
  'andyl/vim-projectionist-elixir',
  {
    'vim-test/vim-test',
    keys = {
      {"<leader>tn", "<cmd>TestNearest<cr>"},
      {"<leader>tf", "<cmd>TestFile<cr>"},
      {"<leader>ta", "<cmd>TestSuite<cr>"},
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup({
        numhl = true,
        current_line_blame_opts = {
          delay = 0
        }
      })
    end,
    keys = {
      {"<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>"},
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    main = 'lualine',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    opts = { theme = 'solarized_dark' }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '▏' },
    }
  },
  'neovim/nvim-lspconfig',
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      local coq = require('coq')
      require('lspconfig').elixirls.setup(coq.lsp_ensure_capabilities({
        cmd = { '/Users/jamie/Multiverse-io/elixir-ls-release/language_server.sh' },
        capabilities = vim.lsp.protocol.make_client_capabilities() 
      }))
    end,
    build = ':COQdeps'
  },
  {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
  },
  {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = {
      'python3 -m chadtree deps',
      ':CHADdeps'
    },
    keys = {
      {"<leader>c", "<cmd>CHADopen<cr>"}
    }
  },
  {
    'rmagatti/auto-session',
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    }
  },
  {
    'rmagatti/session-lens',
    dependencies = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    opts = {
      path_display={'shorten'}
    },
    keys = {
      {"<leader>ff", "<cmd>Telescope find_files<cr>"},
      {"<leader>fg", "<cmd>Telescope live_grep<cr>"},
      {"<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>"},
      {"<leader>fb", "<cmd>Telescope buffers<cr>"}
    }
  }
}, {
  defaults = {
    lazy = false
  }
})

