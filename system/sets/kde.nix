{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    signond

    # KAccounts
    kaccounts-integration
    kaccounts-providers

    # Dolphin plugins
    dolphin-plugins

    # Programs
    kate
    akregator
    kclock

    # KIO slaves
    kio-gdrive
  ];
}
