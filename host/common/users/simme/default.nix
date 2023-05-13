{
  config,
  pkgs,
  lib,
  ...
}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users = {
    simme = {
      initialPassword = "ChangeMe!";
      shell = pkgs.zsh;
      isNormalUser = true;
      
      packages = [
        pkgs.home-manager
      ];
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "audio"
        "video"
      ]
      ++ ifExists [
        "docker"
        "plugdev"
        "render"
        "lxd"
      ];
      openssh = {
        authorizedKeys = {
          keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI4GSYHKigC9SvhQGUZUtP2yU+T84fpvyDB5T0xlU19b67rbImzmVk/U8wpn5syc9P918f4RWRYvo2DUai7EyZ3pB2RIdB7QM+FNMVZZg64CAUjs80oTQdJUd8I8H/x7vXMZS9MyOnYEpUf0Jp3JYfzd7O6SqeaBtugNZEQxrhTHVQQZu/tzHVjynibW94JoWXfKP28DBCaWWnRutT/kO457b+Rn7ld7/fDzJwipwmrj0ZdDcHO+vebbHfqNX588jNvR2AXUNlauc6uI+R7Bv8OvVUKnhsSmlCjhacLyHboYppQCyY7+FkukH0VrF3YV8X49DRczswm/k83vmh+GMF"
          ];
        };
      };
    };
  };
  
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

