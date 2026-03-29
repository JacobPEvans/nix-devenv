# Python interpreter binding
# Single source of truth for the Python version used across nix-devenv modules.
# Change this one line when upgrading (e.g., python314 -> python315).
{ pkgs }:
pkgs.python314
