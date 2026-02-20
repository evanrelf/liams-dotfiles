{
  # Flake inputs are your dotfiles' dependencies. Add something here and its Git
  # commit and content hash will be managed automatically in `flake.lock`. Run
  # `nix flake update` to update all these inputs, or `nix flake update <input>`
  # to update a specific one.
  inputs = {
    # This is Nixpkgs, the Nix package set, which you're probably already
    # familiar with.
    nixpkgs.url = "github:NixOS/nixpkgs";
    # These are some flake helper libraries that make writing a flake nicer.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs are the things you're producing/exporting. That could include
  # NixOS configurations, Home Manager configurations, packages, overlays, etc.
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { config, inputs', pkgs, system, ... }: {
        _module.args.pkgs =
          import inputs.nixpkgs {
            inherit system;
            # Overlays are layers of modifications applied to the package set.
            overlays = [
              # This is a very simple overlay that adds flake inputs into the
              # package set so they're accessible in overlays and elsewhere.
              (_: _: { inherit inputs; })
              (import ./overlays/packages.nix)
              (import ./overlays/nixos-configurations.nix)
            ];
          };

        # To keep things simple and easy (and match what I do in my dotfiles) we
        # re-export the entire (modified!) package set as flake outputs. That
        # means you can `nix build` anything from Nixpkgs, plus any new stuff
        # you add, or with modifications you've made. For example:
        #
        #   $ nix build .#hello
        #
        # will build the `hello` package from Nixpkgs, as provided by this
        # flake.
        legacyPackages = pkgs;
      };
    };
}
