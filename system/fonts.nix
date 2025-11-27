{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    roboto
    inter
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.space-mono
  ];
}
