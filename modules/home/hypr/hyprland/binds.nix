{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      "$MOD" = "SUPER";
      bind = [
        # app binds
        "$MOD, return, exec, ${lib.getExe config.programs.foot.package}"
        "$MOD, tab, exec, ${config.cfg.shell.launcher}"
        "$MOD, escape, exec, ${config.cfg.shell.power}"
        "$MOD, L, exec, ${lib.getExe config.programs.hyprlock.package}"

        # window management
        "$MOD, Q, killactive"
        "$MOD, F, fullscreen"
        ", F11, fullscreen"
        "$MOD, A, togglefloating"
        "$MOD, P, pseudo # dwindle"
        "$MOD, S, togglesplit # dwindle"

        # workspaces
        "$MOD, 1, workspace, r~1"
        "$MOD, 2, workspace, r~2"
        "$MOD, 3, workspace, r~3"
        "$MOD, 4, workspace, r~4"
        "$MOD, 5, workspace, r~5"
        "$MOD, 6, workspace, r~6"
        "$MOD, 7, workspace, r~7"
        "$MOD, 8, workspace, r~8"
        "$MOD, 9, workspace, r~9"
        "$MOD, 0, workspace, r~10"

        "$MOD SHIFT, 1, movetoworkspace, r~1"
        "$MOD SHIFT, 2, movetoworkspace, r~2"
        "$MOD SHIFT, 3, movetoworkspace, r~3"
        "$MOD SHIFT, 4, movetoworkspace, r~4"
        "$MOD SHIFT, 5, movetoworkspace, r~5"
        "$MOD SHIFT, 6, movetoworkspace, r~6"
        "$MOD SHIFT, 7, movetoworkspace, r~7"
        "$MOD SHIFT, 8, movetoworkspace, r~8"
        "$MOD SHIFT, 9, movetoworkspace, r~9"
        "$MOD SHIFT, 0, movetoworkspace, r~10"
      ];
      binde = [
        # TODO: audio package is not setup so this does not work...
        #volume scripts
        ", XF86AudioRaiseVolume, exec, audio.sh vol up 5"
        ", XF86AudioLowerVolume, exec, audio.sh vol down 5"
        ", XF86AudioMute, exec, audio.sh vol toggle"
        "$MOD, O, exec, audio.sh mic toggle"
      ];
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
    };
  };
}
