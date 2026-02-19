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
  };

  # Flake outputs are the things you're producing/exporting. That could include
  # NixOS configurations, Home Manager configurations, packages, overlays, etc.
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { config, inputs', pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs { inherit system; };
      };
    };
}
