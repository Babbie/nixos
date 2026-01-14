{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pinentry-qt 
    yubioath-flutter
  ];
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentry = {
      package = pkgs.pinentry-qt;
      program = "pinentry-qt";
    };
  };
  programs.password-store.enable = true;
  services.pass-secret-service.enable = true;
}
