{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    signond

    # KAccounts
    kaccounts-integration
    kaccounts-providers

    # Programs
    kate
    akregator

    # KIO slaves
    kio-gdrive
  ];
}
