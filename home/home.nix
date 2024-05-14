{ config, pkgs, hyprland, user, ... }:

{

  imports = [
    hyprland.homeManagerModules.default
    ./programs
    ./scripts
  ];

  home = {
  username = user;
  # paths it should manage.
  homeDirectory = "/home/" + user;
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  stateVersion = "23.05";
  };
  home.packages = with pkgs; 
    [ 
      # app
      brave
      google-chrome
      discord
      vlc
      obsidian
      telegram-desktop
      #mattermost-desktop
      firefox-wayland
      thunderbird
      spotify
      anki-bin
      calibre
      xournalpp

      # utils
      obs-studio-plugins.obs-backgroundremoval
      wireguard-tools
      wlr-randr
      atool 
      httpie 
      lazygit 
      lazydocker
      mako
      xflux
      pavucontrol
      android-tools
      xfce.thunar
      xfce.tumbler
      jmtpfs
      scrcpy
      emote
      presenterm
      mpv
      imv
      watson
      networkmanagerapplet
      swww
      brightnessctl
      libnotify


      # dev
      glab
      rustc
      exercism
      go
      gcc
      nodejs
      nodePackages.npm
      nodePackages.yarn
      nodePackages.pnpm
      nodePackages.typescript
      cargo
      ghc
      cabal-install
      ripgrep
      python3Full 
      jq
      agda
      chezmoi fd
      tmux
      elixir

     ];

  programs.home-manager.enable = true;

  home.sessionPath = [
    "/home/${user}/.local/bin"
    "/home/${user}/.cargo/bin"
    "/home/${user}/.go/bin"
  ];

  # make all programs below one programs = {


  programs = {

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
    };
    gh = {
      enable = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output)
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      ];
    };

  };
  # GTK

  home.sessionVariables = {
    GTK_THEME = "Nordic";
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };


  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}
