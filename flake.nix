{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      perSystem =
        { pkgs, self', ... }:
        {
          apps.default = {
            type = "app";
            program = pkgs.lib.getExe' self'.packages.default "jupyter-lab";
          };
          devShells.default = pkgs.mkShell {
            packages = [
              self'.packages.default
            ];
          };
          packages.default = pkgs.python3.withPackages (
            ps: with ps; [
              # keep-sorted start
              example-robot-data
              ipywidgets
              jupyterlab
              matplotlib
              meshcat
              scipy
              # keep-sorted end
            ]
          );
        };
    };
}
