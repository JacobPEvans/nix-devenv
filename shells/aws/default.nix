{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    awscli2
    aws-vault
  ];
  shellHook = ''
    if [ -z "''${DIRENV_IN_ENVRC:-}" ]; then
      echo "AWS Cloud Shell"
      echo "  - aws-cli: $(aws --version 2>/dev/null)"
      echo ""
    fi
  '';
}
