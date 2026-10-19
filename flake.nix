{
  description = "Tokyo Night wallpapers (only the tokyonight/ subset of atraxsrc/cool-wallpapers)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: {
    packages = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"] (
      system: {
        default = nixpkgs.legacyPackages.${system}.stdenvNoCC.mkDerivation {
          name = "tokyonight-wallpapers";
          src = self;
          dontBuild = true;
          installPhase = ''
            mkdir $out
            cp -r tokyonight/. $out/
          '';
        };
      }
    );
  };
}
