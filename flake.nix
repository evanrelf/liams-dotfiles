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
        _module.args.pkgs = import inputs.nixpkgs { inherit system; };

        # Here we're providing the NixOS configuration for your `liam-tpad`
        # machine as a flake output. That means you can build it with a command
        # like `nixos-rebuild build --flake .#liam-tpad` (no `sudo`) or switch
        # to it with `sudo nixos-rebuild switch --flake .#liam-tpad`.
        #
        # Working with a NixOS configuration doesn't require that any files be
        # placed in the `/etc/nixos/` directory like you would traditionally. It
        # only requires super user privileges to _apply_ to the system.
        legacyPackages.nixosConfigurations.liam-tpad =
          inputs.nixpkgs.lib.nixosSystem {
            inherit system pkgs;
            # Seed this build with the root `configuration.nix` file, which then
            # pulls in other dependencies in its own `imports` section.
            modules = [ ./nixos/configuration.nix ];
            # Here's where we thread the flake inputs into the NixOS module
            # system.
            specialArgs = { inherit inputs; };
          };
      };
    };
}
