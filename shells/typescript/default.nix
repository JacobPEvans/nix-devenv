# TypeScript Development Shell
#
# Node.js LTS runtime, pnpm package manager, TypeScript compiler + LSP,
# and Biome (formatter, linter, and LSP). Vitest is project-scoped via pnpm.
{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # === Runtime & Package Manager ===
    nodejs_22
    pnpm

    # === Language Tooling ===
    typescript
    typescript-language-server

    # === Formatter / Linter / LSP (single binary) ===
    biome # `biome lint`, `biome format`, `biome lsp-proxy`
  ];

  shellHook = ''
    if [ -z "''${DIRENV_IN_ENVRC:-}" ]; then
      echo "═══════════════════════════════════════════════════════════════"
      echo "TypeScript Development Environment"
      echo "═══════════════════════════════════════════════════════════════"
      echo ""
      echo "Runtime & Package Manager:"
      echo "  - node: $(node --version 2>/dev/null || echo 'available')"
      echo "  - npm:  $(npm --version 2>/dev/null || echo 'available')"
      echo "  - pnpm: $(pnpm --version 2>/dev/null || echo 'available')"
      echo ""
      echo "Language Tooling:"
      echo "  - tsc:                        $(tsc --version 2>/dev/null || echo 'available')"
      echo "  - typescript-language-server: $(typescript-language-server --version 2>/dev/null || echo 'available')"
      echo ""
      echo "Formatter / Linter / LSP:"
      echo "  - biome: $(biome --version 2>/dev/null || echo 'available')"
      echo ""
      echo "Getting Started:"
      echo "  Init project:  pnpm init && pnpm add -D typescript vitest @types/node"
      echo "  Format/lint:   biome check --write ."
      echo "  Test:          pnpm vitest        # vitest is project-scoped"
      echo "  Type-check:    tsc --noEmit"
      echo ""
      echo "Tip: Vitest is not in nixpkgs — install per-project via pnpm."
      echo ""
    fi
  '';
}
