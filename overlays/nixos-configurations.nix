final: prev:

{
  # Here we're packaging the NixOS configuration for your `liam-tpad` machine.
  # That means you can build it with a command like:
  #
  #   $ nixos-rebuild build --flake .#liam-tpad
  #
  # (no `sudo`) or switch to it with:
  #
  #   $ sudo nixos-rebuild switch --flake .#liam-tpad
  #
  # The part before `#` is the path to the flake (in this case the `flake.nix`
  # file is in the current directory, so we use `.`). The part after the `#` is
  # the attribute name, i.e. a package name or path to something buildable.
  #
  # Working with a NixOS configuration doesn't require that any files be
  # placed in the `/etc/nixos/` directory like you would traditionally. It
  # only requires super user privileges to _apply_ to the system.
  #
  # By default, `nixos-rebuild` infers the attribute name from the hostname, so
  # if e.g. `hostname -s` prints `liam-tpad`, you could elide it from the
  # command:
  #
  #   $ sudo nixos-rebuild switch --flake .
  #
  # Additionally, if you create a symlink at `/etc/nixos/flake.nix` pointing to
  # your dotfiles repo's `flake.nix` file, you can also elide the `--flake .`
  # bit:
  #
  #   $ sudo nixos-rebuild switch
  #
  nixosConfigurations = {
    liam-tpad =
      final.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = final;
        modules = [ ../nixos/configuration.nix ];
        specialArgs = { inherit (final) inputs; };
      };
  };
}
