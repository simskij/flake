{ pkgs, ... }: {

  imports = [
    ./sway
    ./waybar
    ./mako 
  ];

  home = {
    packages = with pkgs; [
      (nerdfonts.override
        {
          fonts = [
            "FiraCode"
          ];
        })
      _1password-gui
      appimage-run
      blueberry
      cinnamon.nemo
      discord
      flameshot
      grim
      lutris
      mattermost-desktop
      mudlet
      obsidian
      pavucontrol
      playerctl
      slurp
      spicetify-cli
      spotify
      swayidle
      swaylock
      tdesktop
      ubuntu_font_family
      ubuntu_font_family
      via
      wdisplays
      wf-recorder
      wl-clipboard
      wlsunset
      xdg-utils
    ];
    pointerCursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  gtk = {
    enable = true;
    font.name = "Victor Mono SemiBold 12";
    theme = {
      name = "Catppuccin-Pink-Dark";
      package = pkgs.catppuccin-gtk;
    };
  };

  
}
