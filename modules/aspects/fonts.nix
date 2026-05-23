{
  den.aspects.custom.fonts.nixos =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          roboto
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          nerd-fonts.fira-mono
          nerd-fonts.space-mono
          nerd-fonts._0xproto
          noto-fonts
        ];
        fontDir.enable = true;
        fontconfig = {
          enable = true;
          defaultFonts = {
            sansSerif = [ "Inter" ];
            monospace = [ "SpaceMono Nerd Font" ];
          };
        };
      };
    };
}
