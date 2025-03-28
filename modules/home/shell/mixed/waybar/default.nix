{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.shell.mixed.waybar.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.shell.mixed.enable;
  };
  imports = [
    ../../../../../packages/scripts/waybar
  ];  
  config = lib.mkIf config.cfg.shell.mixed.waybar.enable {
    stylix.targets.waybar.enable = false;
    wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          mode = "dock";
          gtk-layer-shell = true;
          output = [
            "DP-1"
            "HDMI-A-1"
          ];
          modules-left = [
            "custom/ws"
            "custom/left1"
  
            "hyprland/workspaces"
            "custom/right1"
  
            "custom/paddw"
            "hyprland/window"
          ];
          modules-center = [
            "custom/paddc"
            "custom/left2"
            "custom/cpuinfo"
  
            "custom/left3"
            "memory"
  
            "custom/left4"
            "custom/cpu"
            "custom/leftin1"
  
            "custom/left5"
            "idle_inhibitor"
            "custom/right2"
  
            "custom/rightin1"
            "clock#time"
            "custom/right3"
  
            "clock#date"
            "custom/right4"
  
            "pulseaudio#mic"
            "custom/update"
            "custom/right5"
          ];
          modules-right = [
            "tray"
  
            "custom/left6"
            "pulseaudio"
  
            "custom/left7"
            "custom/backlight"
  
            "custom/left8"
            "battery"
  
            "custom/leftin2"
            "custom/power"
          ];
          "pulseaudio#mic" = {
            format = "{format_source}";
            format-source = "";
            format-source-muted = " ";
            tooltip = "false";
            on-click = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
          };
          "custom/ws" = {
            format = "  ";
            tooltip = false;
            min-length = 3;
            max-length = 3;
            on-click = "fuzzel";
          };
          "hyprland/workspaces" = {
            on-scroll-up = "hyprctl dispatch workspace -1";
            on-scroll-down = "hyprctl dispatch workspace +1";
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
              "11" = "1";
              "12" = "2";
              "13" = "3";
              "14" = "4";
              "15" = "5";
              "16" = "6";
              "17" = "7";
              "18" = "8";
              "19" = "9";
              "20" = "10";
            };
          };
          "hyprland/window" = {
            format = "{}";
            min-length = 5;
            rewrite = {
              "~" = "  Terminal";
              "fish" = "  Terminal";
              "kitty" = "  Terminal";
              "ari@hydrogen:(.*)" = "  Terminal";
              "(.*)ari@hydrogen:~" = "  Terminal";
              "(.*)Zen Browser" = "<span foreground='#cdd6f4'>󰈹 </span> Zen Browser";
              "(.*) — Zen Browser" = "<span foreground='#cdd6f4'>󰈹 </span> $1";
            };
          };
          "custom/cpuinfo" = {
            exec = "waybar-cpu-temp"; # TODO: turn into Lib.getexe
            return-type = "json";
            format = "{}";
            tooltip = "true";
            interval = 5;
            min-length = 8;
            max-length = 8;
          };
          "memory" = {
            states = {
              warning = 75;
              critical = 90;
            };
            format = "󰘚 {percentage}%";
            format-critical = "󰀦 {percentage}%";
            tooltip = "true";
            tooltip-format = "Memory Used: {used:0.1f} GB / {total:0.1f} GB";
            interval = 6;
            min-length = 7;
            max-length = 7;
          };
          "custom/cpu" = {
            exec = "waybar-cpu-usage"; # See above comment
            return-type = "json";
            tooltip = "true";
            interval = 5;
            min-length = 6;
            max-length = 6;
          };
          "idle_inhibitor" = {
            format = " ";
            tooltip = "true";
            tooltip-format-activated = "Presentation Mode";
            tooltip-format-deactivated = "Idle Mode";
            start-activated = "false";
            timeout = 5;
          };
          "clock#time" = {
            format = "󱑂 {:%I:%M}";
            tooltip = "true";
            tooltip-format = "Standard Time: {:%I:%M %p}";
            min-length = 8;
            max-length = 8;
          };
          "clock#date" = {
            format = "󰨳 {:%m-%d}";
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 6;
              on-click-right = "mode";
              format = {
                months = "<span color='#b4befe'><b>{}</b></span>";
                weekdays = "<span color='#a6adc8' font='7'>{}</span>";
                today = "<span color='#f38ba8'><b>{}</b></span>";
              };
              actions = {
                on-click = "mode";
                on-click-right = "mode";
              };
            };
            min-length = 8;
            max-length = 8;
          };
          "custom/wifi" = {
            exec = "~/nixos/resources/waybar/wifi-status.sh";
            return-type = "json";
            format = "{}";
            tooltip = "true";
            interval = 1;
            min-length = 1;
            max-length = 1;
          };
          "bluetooth" = {
            format = "󰂰";
            format-disabled = "󰂲";
            format-connected = "󰂱 ";
            format-connected-battery = "󰂱 ";
            tooltip-format = "{num_connections} connected";
            tooltip-format-disabled = "Bluetooth Disabled";
            tooltip-format-connected = "{num_connections} connected\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}";
            tooltip-format-enumerate-connected-battery = "{device_alias}: {device_battery_percentage}%";
            #on-click
            #on-click-right
            interval = 1;
            min-length = 1;
            max-length = 1;
          };
          "custom/update" = {
            #exec ##TODO
            return-type = "json";
            format = "{}";
            #on-click
            interval = 60;
            tooltip = "true";
            min-length = 1;
            max-length = 1;
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-muted = "󰝟 {volume}%";
            format-icons = {
              default = [
                "󰕿"
                "󰖀"
                "󰕾"
              ];
              headphone = "󰋋";
              headset = "󰋋";
            };
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            min-length = 6;
            max-length = 6;
          };
          "custom/backlight" = {
            #exec ##TODO
            return-type = "json";
            format = "{}";
            tooltip = "true";
            min-length = 6;
            max-length = 6;
          };
          "battery" = {
            format = "{icon} {capacity}%";
            format-icons = [
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
            ];
            format-full = "󱃌 {capacity}%";
            format-warning = "󰁻 {capacity}%";
            format-critical = "󱃍 {capacity}%";
            format-charging = "󱘖 {capacity}%";
            tooltip-format = "Discharging: {time}";
            tooltip-format-charging = "Charging: {time}";
            interval = 1;
            min-length = 6;
            max-length = 6;
          };
          "custom/power" = {
            format = " ";
            tooltip = "false";
            on-click = "wlogout";
          };
          "custom/paddw" = {
            format = " ";
            tooltip = "false";
          };
          "custom/paddc" = {
            format = " ";
            tooltip = "false";
          };
          "custom/left1" = {
            format = "";
            tooltip = "false";
          };
          "custom/left2" = {
            format = "";
            tooltip = "false";
          };
          "custom/left3" = {
            format = "";
            tooltip = "false";
          };
          "custom/left4" = {
            format = "";
            tooltip = "false";
          };
          "custom/left5" = {
            format = "";
            tooltip = "false";
          };
          "custom/left6" = {
            format = "";
            tooltip = "false";
          };
          "custom/left7" = {
            format = "";
            tooltip = "false";
          };
          "custom/left8" = {
            format = "";
            tooltip = "false";
          };
          "custom/right1" = {
            format = "";
            tooltip = "false";
          };
          "custom/right2" = {
            format = "";
            tooltip = "false";
          };
          "custom/right3" = {
            format = "";
            tooltip = "false";
          };
          "custom/right4" = {
            format = "";
            tooltip = "false";
          };
          "custom/right5" = {
            format = "";
            tooltip = "false";
          };
          "custom/leftin1" = {
            format = "";
            tooltip = "false";
          };
          "custom/leftin2" = {
            format = "";
            tooltip = "false";
          };
          "custom/rightin1" = {
            format = "";
            tooltip = "false";
          };
        };
      };
      style = ''
  
        * {
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 10px;
          min-height: 0;
          padding: 0;
          border: none;
          margin: 0;
        }
  
        /* === theme.css === */ 
        @define-color main-fg         ${config.lib.stylix.colors.withHashtag.base01}; 
        @define-color main-bg         ${config.lib.stylix.colors.withHashtag.base00};
        @define-color main-br         ${config.lib.stylix.colors.withHashtag.base03};
  
        @define-color active-bg       ${config.lib.stylix.colors.withHashtag.base03};
        @define-color active-fg       #11111b;
  
        @define-color hover-bg        ${config.lib.stylix.colors.withHashtag.base04};
        @define-color hover-fg        rgba(205, 214, 244, 0.75);
  
        @define-color white           #ffffff;
        @define-color black           #000000;
  
        /* Module Colors */
  
        @define-color module-fg       ${config.lib.stylix.colors.withHashtag.base05};
        @define-color workspaces      ${config.lib.stylix.colors.withHashtag.base01};
  
        @define-color cpuinfo         ${config.lib.stylix.colors.withHashtag.base01};
        @define-color memory          ${config.lib.stylix.colors.withHashtag.base02};
        @define-color cpu             ${config.lib.stylix.colors.withHashtag.base03};
        @define-color distro-fg       #000000;
        @define-color distro-bg       ${config.lib.stylix.colors.withHashtag.base04};
        @define-color time            ${config.lib.stylix.colors.withHashtag.base03};
        @define-color date            ${config.lib.stylix.colors.withHashtag.base02};
        @define-color tray            ${config.lib.stylix.colors.withHashtag.base01}; /* Probably doesnt do anything*/
  
        @define-color pulseaudio      ${config.lib.stylix.colors.withHashtag.base01};
        @define-color backlight       ${config.lib.stylix.colors.withHashtag.base02};
        @define-color battery         ${config.lib.stylix.colors.withHashtag.base03};
        @define-color power           ${config.lib.stylix.colors.withHashtag.base02};
  
        /* State Colors */
  
        @define-color good            #f5e0dc;
        @define-color warning         ${config.lib.stylix.colors.withHashtag.base0A};
        @define-color critical        ${config.lib.stylix.colors.withHashtag.base08};
        @define-color full            #a6e3a1;
        @define-color charging        #cdd6f4;
        /* === Main Background === */
  
        window#waybar {
          background: @main-bg;
        }
  
        /* === Drop Shadow === */
  
        window#waybar > box {
          background-color: transparent;
          box-shadow: 0 0 2px 1px rgba(0, 0, 0, 1);
          margin: 2px;
        }
  
        /* === Tooltip === */
  
        tooltip {
          background: @main-bg;
          border: solid;
          border-width: 1.5px;
          border-radius: 8px;
          border-color: @main-br;
        }
        tooltip label {
          color: @main-fg;
          font-weight: normal;
          margin: -1.5px 3px;
        }
  
        /* === Workspace Buttons === */
  
        #workspaces button {
          color: @module-fg;
          border-radius: 8px;
          box-shadow: none;
          margin: 2px 0;
          padding: 0 2px;
          transition: none;
        }
        #workspaces button:hover {
          color: @hover-fg;
          background: @hover-bg;
          text-shadow: none;
          box-shadow: none;
        }
        #workspaces button.active {
          color: @active-fg;
          background: @active-bg;
          text-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
          box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.4);
          margin: 2px;
          padding: 0 6px;
        }
  
        /* === General === */
  
        #custom-ws,
        #workspaces,
        #window,
        #custom-cpuinfo,
        #memory,
        #custom-cpu,
        #clock,
        #custom-wifi,
        #bluetooth,
        #custom-update,
        #custom-media,
        #pulseaudio,
        #custom-backlight,
        #battery,
        #custom-power {
          opacity: 1;
          color: @module-fg;
          margin-bottom: 0;
          padding: 0 4px;
          text-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
        }
  
        #custom-left1,
        #custom-left2,
        #custom-left3,
        #custom-left4,
        #custom-left5,
        #custom-left6,
        #custom-left7,
        #custom-left8 {
          font-size: 11pt;
          text-shadow: -2px 0 2px rgba(0, 0, 0, 0.5);
        }
  
        #custom-right1,
        #custom-right2,
        #custom-right3,
        #custom-right4,
        #custom-right5 {
          font-size: 11pt;
          padding-right: 3px;
          text-shadow: 2px 0 2px rgba(0, 0, 0, 0.5);
        }
  
        /* === Modules === */
  
        /* == Window Icon == */
  
        #custom-ws {
          background: @main-bg;
        }
  
        /* == Workspaces == */
  
        #custom-left1 {
          color: @workspaces;
          background: @main-bg;
          padding-left: 2px;
        }
        #workspaces {
          background: @workspaces;
        }
        #custom-right1 {
          color: @workspaces;
          background: @main-bg;
          text-shadow: 3px 0 2px rgba(0, 0, 0, 0.4);
        }
  
        /* == Temperature == */
  
        #custom-paddc {
          padding-right: 22px;
        }
        #custom-left2 {
          color: @cpuinfo;
          background: @main-bg;
          padding-left: 3px;
        }
        #custom-cpuinfo {
          background: @cpuinfo;
          padding-left: 1px;
          padding-right: 0;
        }
  
        /* == Memory == */
  
        #custom-left3 {
          color: @memory;
          background: @cpuinfo;
          padding-left: 3px;
        }
        #memory {
          background: @memory;
          padding-left: 1px;
          padding-right: 0;
        }
        #memory.warning {
          color: @warning;
        }
        #memory.critical {
          color: @critical;
        }
  
        /* == CPU == */
  
        #custom-left4 {
          color: @cpu;
          background: @memory;
          padding-left: 3px;
        }
        #custom-cpu {
          background: @cpu;
        }
        #custom-leftin1 {
          color: @cpu;
          font-size: 12.2pt;
          margin-bottom: -2px;
        }
  
        /* == Distro Icon == */
  
        #custom-left5 {
          color: @distro-bg;
          background: @main-bg;
          text-shadow: -2px 0 2px rgba(0, 0, 0, 0.6);
          padding-left: 3px;
        }
        #idle_inhibitor {
          color: @distro-fg;
          background: @distro-bg;
          font-size: 11pt;
          margin-right: -1px;
          margin-bottom: -2px;
          padding-right: 0;
          padding-left: 3px;
          text-shadow: 0 0 1.5px rgba(0, 0, 0, 1);
        }
        #custom-right2 {
          color: @distro-bg;
          background: @main-bg;
        }
  
        /* == Time == */
  
        #custom-rightin1 {
          color: @time;
          font-size: 12.2pt;
          margin-bottom: -2px;
        }
        #clock.time {
          background: @time;
        }
        #custom-right3 {
          color: @time;
          background: @date;
        }
  
        /* == Date == */
  
        #clock.date {
          background: @date;
        }
        #clock.date:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
        #custom-right4 {
          color: @date;
          background: @tray;
        }
  
        /* == Tray == */
  
        #custom-wifi {
          padding-left: 5px;
          padding-right: 8px;
          background: @tray;
        }
        #custom-wifi:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
  
        #bluetooth {
          padding-right: 5px;
          background: @tray;
        }
        #bluetooth:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
  
        #custom-update {
          padding-right: 8px;
          background: @tray;
        }
        #custom-update:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
        #custom-right5 {
          color: @tray;
          background: @main-bg;
        }
  
        /* == Media Info == */
  
        #custom-media {
          font-weight: normal;
          background-color: @main-bg;
          padding-right: 8px;
          padding-left: 8px;
        }
        #custom-media:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
  
        /* == Output Device == */
  
        #custom-left6 {
          color: @pulseaudio;
          background: @main-bg;
          padding-left: 3px;
        }
        #pulseaudio {
          background: @pulseaudio;
        }
        #pulseaudio:hover {
          color: @hover-fg;
          text-shadow: none;
          box-shadow: none;
        }
  
        /* == Brightness == */
  
        #custom-left7 {
          color: @backlight;
          background: @pulseaudio;
          padding-left: 2px;
        }
        #custom-backlight {
          background: @backlight;
        }
  
        /* == Battery == */
  
        #custom-left8 {
          color: @battery;
          background: @backlight;
          padding-left: 2px;
        }
        #battery {
          background: @battery;
        }
        #battery.full {
          color: @full;
        }
        #battery.good {
          color: @module-fg;
        }
        #battery.warning {
          color: @warning;
        }
        #battery.critical {
          color: @critical;
        }
        #battery.charging {
          color: @charging;
        }
  
        /* == Power Button == */
  
        #custom-leftin2 {
          color: @battery;
          background: @main-bg;
          font-size: 12.2pt;
          margin-bottom: -2px;
        }
        #custom-power {
          color: @main-bg;
          background: @power;
          text-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
          box-shadow: 1px 0 2px 1px rgba(0, 0, 0, 0.6);
          border-radius: 10px;
          margin: 2px 4px 2px 0;
          padding-right: 6px;
          padding-left: 9px;
        }
        #custom-power:hover {
          color: @hover-fg;
          background: @hover-bg;
          text-shadow: none;
          box-shadow: none;
        }
      '';
    };
  };
}
  
  
