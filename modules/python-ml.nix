# Reusable devenv module: Python ML development
#
# Provides Python with uv package management for ML workloads.
# Import this module in custom devenv shells for ML/inference environments.
#
# Usage in a consumer flake:
#   modules = [ nix-devenv.devenvModules.python-ml ];
{ pkgs, ... }:
{
  languages.python = {
    enable = true;
    package = import ../lib/python.nix { inherit pkgs; };
    uv = {
      enable = true;
      sync.enable = true;
    };
  };
}
