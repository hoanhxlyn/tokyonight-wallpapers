{
  description = "Tokyo Night wallpaper collection";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs {inherit system;}));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    packages = forAllSystems (pkgs: {
      default = pkgs.stdenv.mkDerivation {
        pname = "tokyonight-wallpapers";
        version = self.shortRev or "dev";
        src = ./.;
        installPhase = ''
          mkdir -p $out
          find . -maxdepth 1 -type f ! -name 'flake.*' -exec cp {} $out/ \;
        '';
      };
    });
  };
}
