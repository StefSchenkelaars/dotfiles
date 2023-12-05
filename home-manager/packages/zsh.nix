{ ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      dev = "cd ~/Documents/Development";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
	"heroku"
      ];
    };
  };
}
