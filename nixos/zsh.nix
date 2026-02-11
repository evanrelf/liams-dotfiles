
{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
          conf = "du -a ~/.config/* | awk '{print $2}' | fzf --preview 'less {}' | xargs -r $EDITOR";
          dox = "du -a ~/Documents/* | awk '{print $2}' | fzf --preview 'less {}' | xargs -r $EDITOR";
          tses = "session=$(tmux list-sessions -F '#S' | fzf) || exit tmux attach -t '$session' ";
          config = "doas vim /etc/nixos/configuration.nix";
          apps = "doas vim /etc/nixos/apps.nix";
          vimconf = "doas vim /etc/nixos/vim.nix";
          };
      ohMyZsh = {
        enable = true;
        plugins = ["vi-mode"];
        theme = "arrow";
      };
    };
}
