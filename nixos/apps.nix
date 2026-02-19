
{ config, inputs, pkgs, ... }:

{

environment.systemPackages = with pkgs; [
    hugo
    wiki-tui
    obs-studio
    mangowc
    nix-search-cli
    dmenu
    networkmanager_dmenu
    waybar
    mpv
    qutebrowser
    swaybg
    waypaper
    ripgrep
    hyprshot
    bluetuith
    pkgs.kitty
    pciutils
    gotop
    yazi
    fzf
    kdePackages.kdenlive
    git
    qbittorrent
    alsa-utils
    pulsemixer
    brightnessctl
    cmus
    cava
    zathura
    texliveFull
    typst
    dnsmasq
    zen-browser
  ];
}
