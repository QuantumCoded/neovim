{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    with inputs;
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);

      luaInputs = [
        "keymaps.lua"

        "barbar.lua"
        "coc.lua"
        "comment.lua"
        "guess-indent.lua"
        "hybrid-line-nums.lua"
        "leetcode.lua"
        "lspconfig.lua"
        "lualine.lua"
        "nvim-tree.lua"
        "telescope.lua"
        "todo-comments.lua"
        "toggleterm.lua"
        "trouble.lua"
        "vim-code-dark.lua"
      ];

      vimInputs = [
      ];
    in
    {
      packages = eachSystem (system: 
        let
          inherit (pkgs)
            callPackage
            neovim-unwrapped
            wrapNeovim
            writeShellApplication
            ;

          inherit (pkgs.lib)
            concatStringsSep
            ;

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

          sourcedLuaConfigs = map (path: "luafile ${path}") (resolvePaths "${neovimConfigs}/nvim/lua" luaInputs);
          sourcedVimConfigs = map (path: "source ${path}") (resolvePaths "${neovimConfigs}/nvim/vim" vimInputs);
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
        default = writeShellApplication {
          name = "nvim";
          runtimeInputs = neovimRuntime;
          text = ''
            ${neovimWrapped}/bin/nvim "$@"
          '';
        };
      });
    };
}

