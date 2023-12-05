{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Mouse mode to scroll and switch windows etc
      set -g mouse on

      # Status bar settings
      set-option -g status-position top
    '';
  };
}
