{ ... }:

{
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
    445
    139
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
    137
    138
  ];

  # https://nixos.wiki/wiki/Samba
  services.samba = {
    enable = true;
    enableNmbd = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/public";
        browseable = "yes";
        "guest ok" = "yes";
        "public" = "yes";
        "read only" = "no";
        "writable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force group" = "users";
        "force user" = "share";
      };
    };
  };

  networking.firewall.allowPing = true;
  services.samba.openFirewall = true;
  systemd.tmpfiles.rules = [ "d /home/public 0755 share users" ];
  users.users.share = {
    isNormalUser = false;
    isSystemUser = true;
    group = "users";
  };
}
