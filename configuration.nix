{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;

  # 使用 Linux-zen 内核
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableRedistributableFirmware = true;


  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org/"
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
    initialPassword = "766704";
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.niri-glass.enable = true;
  programs.sway = {
  enable = true;
  package = pkgs.swayfx;
  };
  programs.noctalia.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
 services.xserver.enable = true;
 services.xserver.xkb.layout = "us";


  #waydroid
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Waydroid 网络 NAT（容器上网必需，重启后自动生效）
  networking.nftables.enable = true;
  networking.nat = {
    enable = true;
    internalInterfaces = [ "waydroid0" ];
    externalInterface = "wlp2s0";
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    waybar
    thunar
    rofi
    wlogout
    matugen
    fish
    git
    gh
    hypridle
    hyprlock
    starship
    cava
    hyprshot
    mpv
    obs-studio
    btop
    wl-clipboard
    cliphist
    lua5_4
    opencode
    splayer
    unzip
    ntfsprogs
    nh
    fastfetch
    gtk3
    tty-clock
    python3
    hmcl
    quickshell
    inputs.caelestia-shell.packages.${pkgs.system}.default
    folia-major
    ffmpeg
    awww
    e2fsprogs
    qq
    ollama
    overskride
    #intel
    intel-media-driver
     libva-utils       # vainfo
    vulkan-tools      # vulkaninfo
    mesa-demos        # glxinfo / glxgears
    intel-gpu-tools   # intel_gpu_top 监控 GPU 使用率（可选）
    power-profiles-daemon
    podman
    distrobox
    #壁纸视差
    hyprlax


    # ---- Clavis core 插件编译依赖 ----
    cmake
    nodejs_24
    nodejs
    ninja
    gcc
    pkg-config
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtshadertools
    qt6.qttools
    qt6Packages.qtkeychain
    pipewire.dev
    ncurses.dev
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
