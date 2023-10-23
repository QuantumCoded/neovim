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
  nvim-web-devicons
  gitsigns-nvim

  (buildVimPlugin {
    pname = "nvim-tetris";
    version = "2021-06-28";
    src = fetchFromGitHub {
      owner = "alerc-gibson";
      repo = "nvim-tetris";
      rev = "d17c99fb527ada98ffb0212ffc87ccda6fd4f7d9";
      hash = "sha256-+69Fq5aMMzg9nV05rZxlLTFwQmDyN5/5HmuL2SGu9xQ=";
    };
  })
]
