{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types concatMapStrings splitString elemAt imap1;
    labels = [
      "一"
      "二"
      "三"
      "四"
      "五"
      "六"
      "七"
      "八"
      "九"
      "十"
    ];
  monitorRules =
    builtins.concatStringsSep "\n"
      (imap1
        (i: monitor:
          builtins.concatStringsSep "\n"
            (imap1
              (j: label: ''
                hl.workspace_rule({
                    workspace = tostring(${toString ((i - 1) * 10 + j)}),
                    monitor = "${monitor}",
                    default = ${if i == 1 && j == 1 then "true" else "false"},
                    default_name = "${label}",
                })
              '')
              labels)
        )
        config.cfg.hypr.hyprland.monitors.list);
in
{
  options.cfg.hypr.hyprland = {
    enable = mkEnableOption "Hyprland";
    monitors = {
      list = mkOption {
        type = types.listOf types.str;
         default = [];
         # "DP-1"
      };
      settings = mkOption {
        type = types.listOf types.str;
        default = [];
      };
    };
  };
  config = mkIf config.cfg.hypr.hyprland.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland.enable = true;
    hj.xdg.config.files."hypr/hyprland.lua".text = /* lua */''
      ${concatMapStrings (m:
        let
          parts = splitString ", " m;
        in ''
          hl.monitor({
            output = "desc:${elemAt parts 0}",
            mode = "${elemAt parts 1}",
            position = "${elemAt parts 2}",
            scale = ${elemAt parts 3},
        })
        '') config.cfg.hypr.hyprland.monitors.settings}
        ${monitorRules}
        local mainMod = "SUPER"
        local ipc = "noctalia msg"

        hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
        hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher"))
        hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. " panel-toggle control-center"))
        hl.bind("ALT + SHIFT + 3", hl.dsp.exec_cmd(ipc .. " screenshot-fullscreen"))
        hl.bind("ALT + SHIFT + 4", hl.dsp.exec_cmd(ipc .. " screenshot-region"))
        hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(ipc .. " panel-toggle session"))
        hl.bind(mainMod .. " + Q", hl.dsp.window.close())

        hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
        hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
        hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
        hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

        hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        hl.bind(mainMod .. " + PERIOD", hl.dsp.layout("move +col"))
        hl.bind(mainMod .. " + COMMA", hl.dsp.layout("move -col"))
        hl.bind(mainMod .. " + SHIFT + PERIOD", hl.dsp.layout("swapcol l"))
        hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.layout("swapcol r"))

        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"))
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"))
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"))
        hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness-up"))
        hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"))

        for i = 1, 10 do
          local key = i == 10 and "0" or tostring(i)
          hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = "r~" .. i }))
          hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "r~" .. i }))
        end

        hl.config({
          misc = {
            disable_hyprland_logo = 1,
            disable_splash_rendering = 1,
            background_color = "0x000000",
            middle_click_paste = false,
            vrr = 2,
          },
          general = {
            -- layout = "scrolling",
            gaps_in = 5,
            gaps_out = 10,
          },
          scrolling = {
            column_width = 0.75 
          },
          decoration = {
            rounding = 20,
            rounding_power = 2,
            active_opacity = 0.95,
            inactive_opacity = 0.9,
            shadow = {
              enabled = true,
              range = 4,
              render_power = 3,
              color = 0xee1a1a1a,
            },
            blur = {
              enabled = true,
              size = 3,
              passes = 2,
              vibrancy = 0.1696,
            },
          },
          cursor = {
            default_monitor = "${elemAt config.cfg.hypr.hyprland.monitors.list 0}",
          },
          ecosystem = {
            no_update_news = 1,
            no_donation_nag = 1,
          },
        })
        hl.window_rule({
          match = { class = "zen" },
          opacity = "1.0 override 1.0 override",
        })
        hl.layer_rule({
          name = "noctalia",
          match = {
            namespace = "^noctalia-(bar-.+|notification|dock|panel)$",
          },
          ignore_alpha = 0.5,
          blur = true,
          blur_popups = true,
        })
        hl.on("hyprland.start", function ()
          hl.exec_cmd("fish -c \"noctalia && hyprctl reload\"")
          hl.exec_cmd("fcitx5 -d")
      end)
        require("noctalia")
        -- dofile(os.getenv("HOME") .. "/.config/hypr/noctalia.lua")
      '';
  };
}
