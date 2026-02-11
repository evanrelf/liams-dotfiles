{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    #shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.gruvbox
    ];

    extraConfig = ''
      set -g default-terminal "kitty"
      setw -g mode-keys vi
      set -ga terminal-overrides ",*256col*:RGB"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      set -g @tmux-gruvbox 'dark256'

       # # easy-to-remember split pane commands
       # bind | split-window -h -c "#{pane_current_path}"
       # bind - split-window -v -c "#{pane_current_path}"
       # bind c new-window -c "#{pane_current_path}"
    '';
  };

}
