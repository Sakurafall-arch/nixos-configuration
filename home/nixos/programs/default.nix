{pkgs, ...}: {
  imports = [
    ./scripts
    #./waybar/waybar.nix
    ./wlogout/wlogout.nix
    ./hyprlock/hyprlock.nix
  ];

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };
  home.file.".config/rofi" = {
    source = ./rofi;
    recursive = true;
  };
  home.file.".config/niri" = {
    source = ./niri;
    recursive = true;
  };
 

    home.file.".config/sway" = {
    source = ./sway;
    recursive = true;
  };

}


