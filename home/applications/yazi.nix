{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        scrolloff = 3;
      };
      tasks = {
        image_bound = [8192 8192];
      };
    };
  };
}
