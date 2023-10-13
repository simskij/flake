_ : let on = { enable = true; }; in
{
  arctic = { 
    settings = {
      audio = true;
      unfree = true;
      timezone = "Europe/Stockholm";
      recycle-after-days = 3;
      nerd-fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    };
    
    desktop = on // {
      keyboard = {
        layout = "us";
        variant = "mac";
      };
    };

    apps = {
      gpg         = on;
      lxd         = on;
      netutils    = on;
      onepassword = on;
      steam       = on;
      tailscale   = on;
      zip         = on;
    };
    
    network = {
      ssh = on // {
        keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI4GSYHKigC9SvhQGUZUtP2yU+T84fpvyDB5T0xlU19b67rbImzmVk/U8wpn5syc9P918f4RWRYvo2DUai7EyZ3pB2RIdB7QM+FNMVZZg64CAUjs80oTQdJUd8I8H/x7vXMZS9MyOnYEpUf0Jp3JYfzd7O6SqeaBtugNZEQxrhTHVQQZu/tzHVjynibW94JoWXfKP28DBCaWWnRutT/kO457b+Rn7ld7/fDzJwipwmrj0ZdDcHO+vebbHfqNX588jNvR2AXUNlauc6uI+R7Bv8OvVUKnhsSmlCjhacLyHboYppQCyY7+FkukH0VrF3YV8X49DRczswm/k83vmh+GMF"
        ];
      };
      firewall = on;
      dns = [
        "10.0.0.1"
        "1.1.1.1"
      ];
    };
  };
}
