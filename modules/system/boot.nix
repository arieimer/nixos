_: {
  config = {
    boot = {
      loader = {
        timeout = 0;
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
          editor = false;
          consoleMode = "max";
        };
        efi.canTouchEfiVariables = true;
      };
      kernelParams = [
        "quiet"
        "splash"
      ];
    };
  };
}
