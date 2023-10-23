{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs:
    with inputs;
    let
      inherit (lib)
        concatStringsSep
        ;

      inherit (pkgs)
        callPackage
        lib
        neovim-unwrapped
        wrapNeovim
        writeShellApplication
        ;

      luaInputs = [
        "coc.lua"
        "guess-indent.lua"
        "hybrid-line-nums.lua"
        "lspconfig.lua"
        "lualine.lua"
        "toggleterm.lua"
      ];

      vimInputs = [
        "vim-code-dark.vim"
      ];

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          rust-overlay.overlays.default
        ];
      };

      neovimConfigs = callPackage ./config { };
      neovimPlugins = callPackage ./plugins.nix { };
      neovimRuntime = callPackage ./runtime.nix { };

      resolvePaths = root: paths: map (relpath: "${root}/${relpath}") paths;

      sourcedLuaConfigs = map (path: "luafile ${path}") (resolvePaths "${neovimConfigs}/lua" luaInputs);
      sourcedVimConfigs = map (path: "source ${path}") (resolvePaths "${neovimConfigs}/vim" vimInputs);
      sourcedConfigs = sourcedVimConfigs ++ sourcedLuaConfigs;
      sourceString = concatStringsSep "\n" sourcedConfigs;

      neovimWrapped = wrapNeovim neovim-unwrapped {
        configure = {
          customRC = sourceString;
          packages.all.start = neovimPlugins;
        };
      };
    in
    {
      packages.${system}.default = writeShellApplication {
        name = "nvim";
        runtimeInputs = neovimRuntime;
        text = ''
          ${neovimWrapped}/bin/nvim "$@"
        '';
      };
    };
}

