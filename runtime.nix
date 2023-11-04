{ fish
, gcc
, lazygit
, libqalculate
, nil
, nodejs
, rust-analyzer
, rust-bin
, tree-sitter
}:

[
  fish
  gcc
  lazygit
  libqalculate
  nil
  nodejs
  rust-analyzer
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]

