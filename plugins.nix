{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  barbar-nvim
  coc-nvim
  coc-rust-analyzer
  lsp-zero-nvim
  nvim-cmp
  cmp-nvim-lsp
  nvim-lspconfig
  comment-nvim
  guess-indent-nvim
  direnv-vim
  vim-nix
  vim-code-dark
  toggleterm-nvim
  nvim-treesitter.withAllGrammars
  lualine-nvim
  lualine-lsp-progress
  nvim-web-devicons
  gitsigns-nvim
  nvim-tree-lua
  plenary-nvim
  telescope-fzf-native-nvim
  telescope-nvim

  (buildVimPlugin {
    pname = "lualine-time";
    version = "2023-04-28";
    src = fetchFromGitHub {
      owner = "archibate";
      repo = "lualine-time";
      rev = "71e368674ec59279e8429504074b15fecd758ea8";
      hash = "sha256-5vZVku4btbwGaPPev+bkWG4R7hLavP5ixN4v/FyJb4c=";
    };
  })

  (buildVimPlugin {
    pname = "nvim-tetris";
    version = "2021-06-28";
    src = fetchFromGitHub {
      owner = "alec-gibson";
      repo = "nvim-tetris";
      rev = "d17c99fb527ada98ffb0212ffc87ccda6fd4f7d9";
      hash = "sha256-+69Fq5aMMzg9nV05rZxlLTFwQmDyN5/5HmuL2SGu9xQ=";
    };
  })
]
