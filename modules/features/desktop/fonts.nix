{ self, inputs, ... }:
{

  flake.nixosModules.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        # ===== Monospace / Coding =====
        jetbrains-mono
        fira-code
        fira-code-symbols
        cascadia-code
        source-code-pro
        hack-font
        inconsolata
        iosevka
        victor-mono

        # ===== Nerd Fonts (patched) =====
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.hack
        nerd-fonts.iosevka
        nerd-fonts.caskaydia-cove
        nerd-fonts.meslo-lg
        nerd-fonts.inconsolata
        nerd-fonts.symbols-only

        # ===== Sans-serif / UI =====
        inter
        roboto
        roboto-slab
        noto-fonts
        open-sans
        source-sans
        work-sans
        oxygenfonts
        montserrat
        poppins

        # ===== Serif =====
        noto-fonts-cjk-serif
        source-serif
        libre-baskerville
        merriweather
        crimson
        eb-garamond

        # ===== Symbols / Icons =====
        font-awesome
        material-design-icons
        material-icons
        powerline-fonts
        powerline-symbols

        # ===== Emoji =====
        noto-fonts-color-emoji
        twitter-color-emoji

        # ===== Retro / Pixel =====
        cozette
        spleen
        tamzen
        creep
      ];

      fonts.fontconfig.enable = true;

      fonts.fontconfig.defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [
          "Inter"
          "Noto Sans"
        ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };

    };

}
