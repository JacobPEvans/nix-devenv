# Orchestrator Development Module (devenv)
#
# Skill orchestration: LangGraph, LlamaIndex, embeddings.
# Uses uv for Python package management (reads pyproject.toml/uv.lock).
{ pkgs, ... }:
let
  pwd = builtins.getEnv "PWD";
  pwdIsOrchestratorRoot =
    pwd != ""
    && builtins.pathExists (pwd + "/pyproject.toml")
    &&
      builtins.match ".*name = \"orchestrator\".*" (builtins.readFile (pwd + "/pyproject.toml")) != null;
in
{
  devenv.root = if pwdIsOrchestratorRoot then pwd else builtins.toString ./.;

  languages.python = {
    enable = true;
    package = pkgs.python314;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  enterShell = ''
    echo "Orchestrator environment ready ($(python3 --version))"
  '';
}
