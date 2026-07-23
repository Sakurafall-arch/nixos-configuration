{ pkgs, ... }:

let
  nord = {
    nord0 = "#2e3440";
    nord1 = "#3b4252";
    nord2 = "#434c5e";
    nord3 = "#4c566a";
    nord4 = "#d8dee9";
    nord5 = "#e5e9f0";
    nord6 = "#eceff4";
    nord7 = "#8fbcbb";
    nord8 = "#88c0d0";
    nord9 = "#81a1c1";
    nord10 = "#5e81ac";
    nord11 = "#bf616a";
    nord12 = "#d08770";
    nord13 = "#ebcb8b";
    nord14 = "#a3be8c";
    nord15 = "#b48ead";
  };

  sharedScripts = import ./share_scripts.nix { inherit pkgs; };
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      targets = [ "graphical-session.target" ];
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        font-weight: bold;
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      @keyframes blink_red {
        to {
          background-color: ${nord.nord11};
          color: ${nord.nord0};
        }
      }

      .warning,
      .critical,
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      window#waybar {
        background-color: transparent;
      }

      window>box {
        margin-left: 5px;
        margin-right: 5px;
        margin-top: 5px;
        background-color: ${nord.nord1};
      }

      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
      }

      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
        color: ${nord.nord4};
      }

      #workspaces button.active {
        background-color: ${nord.nord7};
        color: ${nord.nord0};
      }

      #workspaces button.urgent {
        color: ${nord.nord0};
      }

      #workspaces button:hover {
        background-color: ${nord.nord15};
        color: ${nord.nord0};
      }

      tooltip {
        background: ${nord.nord1};
      }

      tooltip label {
        color: ${nord.nord5};
      }

      #custom-launcher {
        font-size: 20px;
        padding-left: 8px;
        padding-right: 6px;
        color: ${nord.nord8};
      }

      #mode,
      #clock,
      #memory,
      #temperature,
      #cpu,
      #mpd,
      #custom-wall,
      #temperature,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #custom-powermenu,
      #custom-cava-internal {
        padding-left: 10px;
        padding-right: 10px;
      }

      #memory {
        color: ${nord.nord7};
      }

      #cpu {
        color: ${nord.nord15};
      }

      #clock {
        color: ${nord.nord5};
      }

      #custom-wall {
        color: ${nord.nord15};
      }

      #temperature {
        color: ${nord.nord9};
      }

      #backlight {
        color: ${nord.nord14};
      }

      #pulseaudio {
        color: ${nord.nord13};
      }

      #network {
        color: ${nord.nord14};
      }

      #network.disconnected {
        color: ${nord.nord4};
      }

      #battery.charging,
      #battery.full,
      #battery.discharging {
        color: ${nord.nord12};
      }

      #battery.critical:not(.charging) {
        color: ${nord.nord4};
      }

      #custom-powermenu {
        color: ${nord.nord11};
      }

      #tray {
        padding-right: 8px;
        padding-left: 10px;
      }

      #tray menu {
        background: ${nord.nord1};
        color: ${nord.nord4};
      }

      #mpd.paused {
        color: ${nord.nord9};
        font-style: italic;
      }

      #mpd.stopped {
        background: transparent;
      }

      #mpd {
        color: ${nord.nord5};
      }

      #custom-cava-internal {
        font-family: "JetBrainsMono Nerd Font";
        color: ${nord.nord7};
      }
    '';
    settings = [
      {
        mode = "dock";
        start_hidden = false;
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "temperature"
          "custom/wall"
          "mpd"
          "custom/cava-internal"
          "custom/recgif"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "battery"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };
        "custom/recgif" = {
          "format" = "{icon}";
          "return-type" = "json";
          "format-icons" = {
            "recording" = "<span foreground='${nord.nord11}'> </span>";
            "stopped" = " ";
          };
          "exec" =
            "pgrep -x recgif >/dev/null && echo '{\"alt\": \"recording\"}' || echo '{\"alt\": \"stopped\"}'";
          "interval" = 1;
          "exec-if" = "sleep 0.1";
          "on-click" = "pkill -SIGINT wf-recorder || ${sharedScripts.recgif}/bin/recgif";
          "on-click-right" = "flameshot_watermark";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "${sharedScripts.wallpaper_random}/bin/wallpaper_random";
          "on-click-middle" = "${sharedScripts.default_wall}/bin/default_wall";
          "on-click-right" =
            "killall dynamic_wallpaper || ${sharedScripts.dynamic_wallpaper}/bin/dynamic_wallpaper &";
          "format" = " 󰠖 ";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && ${sharedScripts.cava-internal}/bin/cava-internal";
          "tooltip" = false;
        };
        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
          active-only = false;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "brightnessctl -d intel_backlight set +5%";
          "on-scroll-down" = "brightnessctl -d intel_backlight set 5%-";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            "󰃝"
            "󰃞"
            "󰃟"
            "󰃠"
          ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='${nord.nord13}'><b>{}</b></span>";
              "days" = "<span color='${nord.nord15}'><b>{}</b></span>";
              "weeks" = "<span color='${nord.nord7}'><b>W{}</b></span>";
              "weekdays" = "<span color='${nord.nord13}'><b>{}</b></span>";
              "today" = "<span color='${nord.nord11}'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='${nord.nord15}'>󰎈</span> {title}";
          "format-paused" = "󰎈 {title}";
          "format-stopped" = "<span foreground='${nord.nord15}'>󰎈</span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "interval" = 1;
          "format-wifi" = "󰖩 {essid} ({ipaddr})";
          "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-disconnected" = "󰯡 Disconnected";
          "tooltip" = false;
        };
        "temperature" = {
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "~/.config/rofi/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
