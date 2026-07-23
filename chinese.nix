{ config, pkgs, lib, ... }: {
# 设置系统的中文环境
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
   };

   supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # 输入法配置（Fcitx5 + Rime Ice 雾凇拼音）
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        (fcitx5-rime.override {
          rimeDataPkgs = [ rime-ice ];
        })
        fcitx5-gtk
        qt6Packages.fcitx5-configtool
      ];
    };
  };

  # 中文字体优化
  fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans    # 思源黑体 (无衬线)
    noto-fonts-cjk-serif   # 思源宋体 (衬线)
    noto-fonts-color-emoji       # Emoji 表情符号支持
    nerd-fonts.jetbrains-mono    # JetBrains Mono Nerd Font (等宽代码字体)

    # 中文补充字体
    lxgw-wenkai-screen           # 霞鹜文楷 GB Screen (中文正文)
    google-fonts                 # Google Fonts 大合集
    material-symbols             # Material Symbols Outlined/Rounded (UI 图标)
    font-awesome                 # Font Awesome 图标
    nerd-fonts.symbols-only      # Symbols Nerd Font Mono (Nerd Font 图标)
  ];

  fontconfig = {
    enable = true;
    defaultFonts = {
      # 无衬线字体：优先思源黑体，后备 Noto Sans 和 Emoji
      sansSerif = [ "Noto Sans CJK SC" "Noto Sans" "Noto Color Emoji" ];
      
      # 衬线字体：优先思源宋体，后备 Noto Serif 和 Emoji
      serif = [ "Noto Serif CJK SC" "Noto Serif" "Noto Color Emoji" ];
      
      # 等宽字体：优先 JetBrains Mono，后备 Noto Sans Mono CJK (防止代码里中文乱码)
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
   };
 };
}
