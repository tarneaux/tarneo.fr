{
  description = "tarneo.fr";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      nativeBuildInputs = [ pkgs-unstable.hugo pkgs.gnumake ];
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        inherit nativeBuildInputs;
      };
      packages.x86_64-linux = {
        dev = pkgs.writeShellScriptBin "dev" ''
          #!/usr/bin/env bash
          ${pkgs-unstable.hugo}/bin/hugo server -D --disableFastRender
        '';
      };
      apps.x86_64-linux = {
        dev = {
          type = "app";
          program = "${self.packages.x86_64-linux.dev}/bin/dev";
        };
      };
    };
}
