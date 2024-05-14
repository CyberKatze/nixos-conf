{ config, lib, pkgs, ... }:

{
    # home.file.".config/Code/User/settings.json".source= ./settings.json;
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
  };
}
