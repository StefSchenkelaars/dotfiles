{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Stef Schenkelaars";
    userEmail = "stef.schenkelaars@gmail.com";
    ignores = [
      # Compiled Python files
      "*.pyc"
   
      # Folder view configuration files
      ".DS_Store"
      "Desktop.ini"
      
      # Thumbnail cache files
      "._*"
      ".Thumbs.db"
    
      # Files that might appear on external disks
      ".Spotlight-V100"
      ".Trashes"
      
      # Ignore the asdf tool versions
      ".tool-versions"
    ];
  };
}
