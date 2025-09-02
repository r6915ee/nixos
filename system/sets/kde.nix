{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    signond

    # KAccounts
    kaccounts-integration
    kaccounts-providers

    # Programs
    kate

    # KIO slaves
    kio-gdrive
  ];
}
