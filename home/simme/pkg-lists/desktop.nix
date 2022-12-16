{pkgs, ...}: {
  list = with pkgs; [
    (nerdfonts.override
      {
        fonts = [
          "FiraCode"
        ];
      })
    blueberry
    cinnamon.nemo
    flameshot
    grim
    kitty
    neofetch
    playerctl
    slurp
    swayidle
    swaylock
    wayfire
    wcm
    wdisplays
    wf-recorder
    wl-clipboard
  ];
}
