# Reusable devenv module: Python base development toolchain
#
# Provides Python linters, formatters, and type checkers for Python projects.
# Import this module in project devenv shells to get a consistent Python toolchain.
#
# NOTE: pyright is NOT included here — it stays in nix-home global env so that
# IDEs (Cursor/VSCode) can find it in PATH for background linting without
# requiring a specific devenv to be active.
#
# Usage in a consumer devenv.nix:
#   { inputs, pkgs, ... }:
#   {
#     imports = [ inputs.nix-devenv.devenvModules.python-base ];
#     # ... project-specific config
#   }
#
# Or from a flake shell:
#   modules = [ nix-devenv.devenvModules.python-base ];
{ pkgs, ... }:
{
  packages = with pkgs; [
    ruff # Fast Python linter and formatter (replaces flake8, isort, black for most cases)
    black # Opinionated Python code formatter
    mypy # Static type checker for Python
    uv # Fast Python package manager (replaces pip/pipx)
  ];
}
