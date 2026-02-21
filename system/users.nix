{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kolya = {
    isNormalUser = true;
    description = "Kolya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.fish;
    packages = [ ];
  };
}
