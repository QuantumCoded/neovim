{ fish
, gcc
, lazygit
, libqalculate
, nil
, nodejs
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
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]

