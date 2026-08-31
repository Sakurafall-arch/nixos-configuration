
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./programs 
    ./music
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite # xwayland support
    libnotify
    pavucontrol # 图形化音量控制
  ];

  # 自动创建截图文件夹
  home.activation.ensureScreenshotDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/screenshot"
  '';

  services.polkit-gnome.enable = true; # 权限认证

  # 消息通知
  services.swaync.enable = true;

  # services.mako.enable = true;
  # catppuccin.mako = {
  #   enable = true;
  #   accent = "mauve";
  #   flavor = "mocha";
  # };
  # 文本文件默认用 kitty 打开 nvim（替代裸 nvim.desktop）
xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "kitty-nvim.desktop";
      "text/markdown" = "kitty-nvim.desktop";
      "text/x-markdown" = "kitty-nvim.desktop";
      "application/json" = "kitty-nvim.desktop";
      "text/x-shellscript" = "kitty-nvim.desktop";
      "text/x-python" = "kitty-nvim.desktop";
      "text/x-c" = "kitty-nvim.desktop";
      "text/x-csrc" = "kitty-nvim.desktop";
      "text/x-chdr" = "kitty-nvim.desktop";
      "text/x-c++src" = "kitty-nvim.desktop";
      "text/x-c++hdr" = "kitty-nvim.desktop";
      "text/x-java" = "kitty-nvim.desktop";
      "text/x-tex" = "kitty-nvim.desktop";
      "text/x-makefile" = "kitty-nvim.desktop";
      "text/yaml" = "kitty-nvim.desktop";
      "application/x-yaml" = "kitty-nvim.desktop";
    };
  };

  # 自定义 desktop entry：在 kitty 里打开 nvim
  xdg.desktopEntries."kitty-nvim" = {
    name = "Kitty Nvim";
    comment = "Open text files in Neovim via Kitty";
    exec = "kitty -e nvim %f";
    icon = "kitty";
    categories = [ "Utility" "TextEditor" ];
    terminal = false;
    mimeType = [
      "text/plain"
      "text/markdown"
      "text/x-markdown"
      "application/json"
      "text/x-shellscript"
      "text/x-python"
      "text/x-c"
      "text/x-csrc"
      "text/x-chdr"
      "text/x-c++src"
      "text/x-c++hdr"
      "text/x-java"
      "text/x-tex"
      "text/x-makefile"
      "text/yaml"
      "application/x-yaml"
    ];
  };
 home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11.enable = true;
  };
 home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PATH = "$HOME/.local/opt/node-v24.18.1-linux-x64/bin:$HOME/.local/bin:$PATH";
    LANG = "zh_CN.UTF-8"; # 系统主语言英文
    LC_CTYPE = "zh_CN.UTF-8"; # 字符显示支持中文
    LC_MESSAGES = "zh_CN.UTF-8"; # 程序输出信息保持中文
  };
 programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""
    '';
  };

 programs.starship = {
    enable = true;
  };
  

  home.stateVersion = "26.11";
  # home.enableNixpkgsReleaseCheck = false;
}
