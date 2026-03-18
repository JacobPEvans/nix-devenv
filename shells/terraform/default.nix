# Terraform/Terragrunt Infrastructure as Code Shell
#
# Complete IaC environment with Terraform, Terragrunt, security scanners,
# and AWS/Docker integration.
#
# NOTE: Caller must pass pkgs with config.allowUnfree = true for Terraform's BSL license.
{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # === Infrastructure as Code ===
    terraform
    terragrunt
    opentofu
    terraform-docs
    tflint

    # === Security & Compliance ===
    # checkov and terrascan removed: checkov is broken in nixpkgs-unstable
    # (pycep-parser fails to build with uv_build backend). Both hooks are
    # also disabled in terraform-proxmox .pre-commit-config.yaml. Re-add
    # when the upstream nixpkgs pycep-parser derivation is fixed.
    tfsec
    trivy

    # === Secrets Management ===
    sops
    age

    # === Cloud & Development ===
    awscli2
    git
    python3

    # === Utilities ===
    jq
    yq
  ];

  shellHook = ''
    if [ -z "''${DIRENV_IN_ENVRC:-}" ]; then
      echo "═══════════════════════════════════════════════════════════════"
      echo "Terraform/Terragrunt Infrastructure as Code Environment"
      echo "═══════════════════════════════════════════════════════════════"
      echo ""
      echo "Infrastructure as Code:"
      echo "  - terraform: $(terraform version -json 2>/dev/null | jq -r '.terraform_version' 2>/dev/null || terraform version | head -1)"
      echo "  - terragrunt: $(terragrunt --version 2>/dev/null | cut -d' ' -f3)"
      echo "  - opentofu: $(tofu version 2>/dev/null | head -1)"
      echo ""
      echo "Security & Compliance:"
      echo "  - tfsec: $(tfsec --version 2>/dev/null)"
      echo ""
      echo "Secrets Management:"
      echo "  - sops: $(sops --version 2>/dev/null)"
      echo "  - age: $(age --version 2>/dev/null)"
      echo ""
      echo "Cloud:"
      echo "  - aws-cli: $(aws --version 2>/dev/null)"
      echo ""
      echo "Getting Started:"
      echo "  1. Configure AWS credentials: aws configure"
      echo "  2. Configure Proxmox API token (environment variable or file)"
      echo "  3. Initialize Terraform: terragrunt init"
      echo "  4. Setup pre-commit hooks: pre-commit install"
      echo ""
    fi
  '';
}
