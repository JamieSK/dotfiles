local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

  use 'ishan9299/nvim-solarized-lua'
  use 'kyazdani42/nvim-web-devicons'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end
  }

  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'lukas-reineke/indent-blankline.nvim'
  use 'neovim/nvim-lspconfig'
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq'
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
  }
  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = 'python3 -m chadtree deps'
  }
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup({
        path_display={'shorten'},
      })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
  local coq = require('coq')
  require('lspconfig').elixirls.setup(coq.lsp_ensure_capabilities({
    cmd = { '/Users/work/Multiverse/elixir-ls/language_server.sh' },
    capabilities = vim.lsp.protocol.make_client_capabilities() 
  }))
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'elixir' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    }
  })
  vim.cmd([[highlight IndentBlanklineIndent guifg=#353c3d gui=nocombine]])
  require('indent_blankline').setup({
    char_highlight_list = { 'IndentBlanklineIndent' },
    setColors = 0,
    char = '▏'
  })
  require('lualine').setup()
  require('gitsigns').setup()
  require('telescope').setup({})
  require('telescope').load_extension('fzf')
end)

