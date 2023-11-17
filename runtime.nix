{ fish
, fzf
, gcc
, git
, lazygit
, libqalculate
, nil
, nodejs
, ripgrep
, rust-analyzer
, rust-bin
, tree-sitter
}:

[
  fish
  fzf
  gcc
  git
  lazygit
  libqalculate
  nil
  nodejs
  ripgrep
  rust-analyzer
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]

