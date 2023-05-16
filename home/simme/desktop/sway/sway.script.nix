{ ... }: {
  home.file = {
    ".config/sway/lock.sh" = {
      executable = true;
      text = ''
      swayidle \
          timeout 1 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' & 
      swaylock -c 000000ff --image ~/.wallpaper.png --blur 10
      kill %%
      '';
    };
  };
}
