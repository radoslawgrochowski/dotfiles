{ ... }:

{

  services.printing.enable = true;

  # Use CUPS `localhost:631/admin` web gui to add printer,
  # e.g. `ipp://192.168.0.199` for my current Brother DSP-J105
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  users.groups.lpadmin.members = [ "radoslawgrochowski" ];
}
