
{ config, pkgs, ... }:

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
    timeshift
    swaybg
    waypaper
    ripgrep
    hyprshot
    bluetuith
    pkgs.kitty
    pciutils
    gotop
    nemo
    yazi
    fzf
    kdePackages.kdenlive
    git
    qbittorrent
    wiremix
    alsa-utils
    brightnessctl
    cmus
    cava
    zathura
    texliveFull
    typst
    gnome-boxes
    dnsmasq
  ];
}
