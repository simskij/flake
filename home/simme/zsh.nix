{ pkgs, lib, config, ... }:

{
  programs = {
    starship = {
      enable = true;
    };
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };

      shellAliases = {
        auth = "ssh-add ~/.ssh/id_rsa";
        code = "codium";
        dust = "dust --si";
        jj = "juju";
        k = "kubectl";
        ll = "ls -la";
        ls = "exa";
        nano = "nvim";
        reload = "source ~/.zshrc";
        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";
        vi = "nvim";
        vim = "nvim";
        whatsmyip = "curl ifconfig.co";
        "reload.nixos" = "sudo nixos-rebuild switch --flake /home/simme/code/simskij/nixos-config";
        "reload.home" = "home-manager switch --flake /home/simme/code/simskij/nixos-config";
      };
    };
  };
}
