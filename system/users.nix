{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kolya = {
    isNormalUser = true;
    description = "Kolya";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = [ ];
  };
  home-manager = {
    users.kolya =
      { ... }:
      {
        home.stateVersion = "25.05";
      };
  };
}
