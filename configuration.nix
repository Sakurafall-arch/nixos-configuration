{ config, pkgs, lib, inputs, ... }:
{

  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5"
      "https://cache.soopy.moe?priority=10"
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=10"
      "https://nixmirror.linuxir.org/store?priority=10"
    ];
    trusted-substituters = [
      "https://cache.soopy.moe"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
    ];
    trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # === tmpfs 根模式配置 ===
  # 将 / 挂载为 tmpfs，每次重启干净如新
  # /nix, /var, /etc, /home 分别在 Btrfs 子卷上持久化
  boot.initrd.systemd.enable = true;

  hardware.apple-t2.firmware.enable = true;

  # 网络配置
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # DNS 配置：使用 systemd-resolved 替代 glibc 的解析器
  services.resolved.enable = true;
  # 让 NetworkManager 使用 systemd-resolved 管理 DNS
  networking.networkmanager.dns = "systemd-resolved";


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Shanghai";

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver.xkb.layout = "us";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  virtualisation.docker.enable = true;
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    hashedPassword = "$y$j9T$OL5X/329A2WEE3V83UDJF/$LDx1TIaYz0MetwL7sM/A6yP47pkLoh/qV/qBY9TJB13";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  programs.firefox.enable = true;
  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;

  # niri 官方模块
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # 用 wlr 来提供 ScreenCast（gnome 后端没 GNOME Shell 时不行）
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
  xdg.portal.config.niri = {
    default = lib.mkForce [ "gnome" "gtk" "wlr" ];
    "org.freedesktop.impl.portal.ScreenCast" = lib.mkForce "wlr";
  };

  systemd.user.services.niri = {
    restartIfChanged = false;
    enableDefaultPath = false;
  };

  # graphical-session.target 默认 RefuseManualStart=yes 阻止 niri 和
  # xdg-desktop-portal-gnome 等依赖它的服务启动。覆盖掉这两个限制。
  systemd.user.targets.graphical-session = {
    unitConfig = {
      RefuseManualStart = false;
      StopWhenUnneeded = false;
    };
  };

  # 全局 Ozone Wayland 支持：自动为 Electron/Chromium 应用添加 --ozone-platform=wayland
  environment.sessionVariables.NIXOS_OZONE_WAYLAND = "1";

  # 让 systemd user services（如 xdg-desktop-portal）能读取 XDG_CURRENT_DESKTOP
  environment.sessionVariables.XDG_CURRENT_DESKTOP = "niri";
  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    waybar
    thunar
    rofi
    wlogout
    matugen
    (writeShellScriptBin "qq" ''
      exec ${pkgs.qq}/bin/qq --ozone-platform=wayland "$@"
    '')
   (writeShellScriptBin "splayer" ''
      exec ${pkgs.splayer}/bin/splayer --ozone-platform=wayland "$@"
    '')
    git
    awww
    hypridle
    hyprlock
    starship
    cava
    hyprshot
    neovim
    go-musicfox
    mpv
    obs-studio
    btop
    google-chrome
    wl-clipboard
    cliphist
    fastfetch
    niri
    gcc
    gnumake
    clang
    cmake
    cpio
    ffmpeg
    flameshot
    fzf
    hyprland
    mako
    nh
    opencode
    p7zip
    pkg-config
    (pkgs.symlinkJoin {
      name = "quickshell-wrapped";
      paths = [ pkgs.quickshell ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/quickshell \
          --set QML_IMPORT_PATH "${pkgs.qt6.qt5compat}/lib/qt-6/qml:/home/nixos/.config/quickshell/core/build:/home/nixos/.cache/m3shapes"
      '';
    })
    rustc
    tree-sitter
    docker
    inputs.miyu.packages.x86_64-linux.default
    killall
    mpvpaper
    ntfs3g
    pyright
    rime-ice
    waypaper
    wlroots
    yazi
  ];

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  services.openssh.enable = true;
  system.stateVersion = "26.11";
}
