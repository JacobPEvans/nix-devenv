# Reusable devenv module: Python AI development
#
# Provides Python with LangChain, LangGraph, and OpenTelemetry packages.
# Import this module in custom devenv shells to get the AI Python stack.
#
# Usage in a consumer flake:
#   modules = [ nix-devenv.devenvModules.python-ai ];
{ pkgs, ... }:
{
  languages.python = {
    enable = true;
    package = pkgs.python314;
    venv.enable = true;
    venv.requirements = ''
      langchain
      langchain-core
      langchain-openai
      langgraph
      opentelemetry-api
      opentelemetry-sdk
      opentelemetry-exporter-otlp
      opentelemetry-instrumentation
    '';
  };
}
