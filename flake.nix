{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs: (flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = with pkgs; mkShell {
        shellHook = ''
          eval "$(${fnm}/bin/fnm env --use-on-cd)"
        '';
        buildInputs = [
          fnm
        ];
      };
    }));
}
