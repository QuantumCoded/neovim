{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
            wrapNeovimUnstable
            writeShellApplication
            ;

          inherit (pkgs.lib)
            concatStringsSep
            ;

          inherit (pkgs.neovimUtils)
            makeNeovimConfig
            ;

          pkgs = import nixpkgs { inherit system; };

          neovimConfigs = callPackage ./config { };
          neovimPlugins = callPackage ./plugins.nix { };
          neovimRuntime = callPackage ./runtime.nix { };

          resolvePaths = root: paths: map (relpath: "${root}/${relpath}") paths;

          sourcedLuaConfigs = map (path: "luafile ${path}") (resolvePaths "${neovimConfigs}/nvim/lua" luaInputs);
          sourcedVimConfigs = map (path: "source ${path}") (resolvePaths "${neovimConfigs}/nvim/vim" vimInputs);
          sourcedConfigs = sourcedVimConfigs ++ sourcedLuaConfigs;
          sourceString = concatStringsSep "\n" sourcedConfigs;

          neovimConfig = makeNeovimConfig {
            customRC = sourceString;
            plugins = map (plugin: { inherit plugin; }) neovimPlugins;
          };

          neovimWrapped = wrapNeovimUnstable neovim-unwrapped neovimConfig;
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

