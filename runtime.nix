{ gcc
, nodejs
, rust-bin
, tree-sitter
,
}:

[
  gcc
  nodejs
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]

