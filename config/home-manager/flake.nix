{
  description = "Home Manager configuration of mzwallow";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    tree-sitter-repo.url = "github:tree-sitter/tree-sitter";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      tree-sitter-repo,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      #old # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.neovim-nightly-overlay.overlays.default
        ];
      };
    in
    {
      homeConfigurations."mzwallow" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit tree-sitter-repo; };
      };
    };
}
