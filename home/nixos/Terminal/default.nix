{pkgs, ...}: {

  home.packages = with pkgs; [
    kitty
  ];

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };
  home.file.".config/starship.toml" = {
    source = ./starship.toml;
    recursive = true;
  };
}

