{ pkgs, ... }:

{

  home.sessionVariables = {
    NIXOS_OZONE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "niri";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11.enable = true;
  };
  dconf.enable = true;
  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = "Bibata-Modern-Ice";
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = "gtk-cursor-theme-name=\"Bibata-Modern-Ice\"";
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
    };
  };

  programs.git.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""
    '';
  };

  programs.starship = {
    enable = true;
  };

  xdg.configFile."fish/conf.d/miyu.fish" = {
    source = ./miyu.fish;
  };

  xdg.configFile."rofi" = {
    source = ./rofi;
    recursive = true;
  };

  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  imports = [
    ./waybar
  ];

  home.packages = with pkgs; [
    pyright
  ];

  home.stateVersion = "26.11";
}
