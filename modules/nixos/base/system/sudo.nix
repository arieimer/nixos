_: {
  config = {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults lecture = never
        Defaults pwfeedback
        Defaults passprompt = "[sudo 󱅞 ]: "
      '';
    };
  };
}
