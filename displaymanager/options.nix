{ config, lib, ...}:

{
  options = with lib; {
    displayManager = mkOption {
      type = types.str;
      default = "ly";
      example = "ly";
      description = "The display manager to use";
    };
  };
}
