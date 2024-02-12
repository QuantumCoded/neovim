{ clang-tools
, fish
, fzf
, gcc
, git
, lazygit
, libqalculate
, nil
, nodejs
, nodePackages
, ripgrep
, rust-analyzer
, rust-bin
, tree-sitter
}:
[
  clang-tools
  fish
  fzf
  gcc
  git
  lazygit
  libqalculate
  nil
  nodejs
  nodePackages.typescript-language-server
  ripgrep
  rust-analyzer
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]
