#!/usr/bin/env bash
# install.sh — Instalador de completions de nftables
# Uso: sudo bash install.sh
# O sin sudo para instalar solo para tu usuario

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPLETIONS_DIR="$REPO_DIR/completions"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }

echo ""
echo "  nftables autocomplete installer"
echo "  ================================"
echo ""

install_bash() {
    if command -v bash &>/dev/null; then
        if [ "$EUID" -eq 0 ]; then
            if [ -d /etc/bash_completion.d ]; then
                cp "$COMPLETIONS_DIR/nft.bash" /etc/bash_completion.d/nft
                info "Bash: instalado en /etc/bash_completion.d/nft"
            else
                warn "Bash: /etc/bash_completion.d no existe"
                warn "  Ubuntu/Debian: sudo apt install bash-completion"
                warn "  RHEL/Fedora:   sudo dnf install bash-completion"
            fi
        else
            mkdir -p ~/.local/share/bash-completion/completions
            cp "$COMPLETIONS_DIR/nft.bash" ~/.local/share/bash-completion/completions/nft
            info "Bash: instalado en ~/.local/share/bash-completion/completions/nft"
            warn "Agrega esto a tu ~/.bashrc si no carga automático:"
            warn "  source ~/.local/share/bash-completion/completions/nft"
        fi
    else
        warn "Bash: no encontrado, saltando"
    fi
}

install_zsh() {
    if command -v zsh &>/dev/null; then
        if [ "$EUID" -eq 0 ]; then
            cp "$COMPLETIONS_DIR/nft.zsh" /usr/local/share/zsh/site-functions/_nft
            info "Zsh: instalado en /usr/local/share/zsh/site-functions/_nft"
        else
            mkdir -p ~/.zsh/completions
            cp "$COMPLETIONS_DIR/nft.zsh" ~/.zsh/completions/_nft
            info "Zsh: instalado en ~/.zsh/completions/_nft"
            warn "Asegúrate de tener en ~/.zshrc:"
            warn '  fpath=(~/.zsh/completions $fpath)'
            warn '  autoload -Uz compinit && compinit'
        fi
    else
        warn "Zsh: no encontrado, saltando"
    fi
}

install_fish() {
    if command -v fish &>/dev/null; then
        if [ "$EUID" -eq 0 ]; then
            mkdir -p /usr/share/fish/completions
            cp "$COMPLETIONS_DIR/nft.fish" /usr/share/fish/completions/nft.fish
            info "Fish: instalado en /usr/share/fish/completions/nft.fish"
        else
            mkdir -p ~/.config/fish/completions
            cp "$COMPLETIONS_DIR/nft.fish" ~/.config/fish/completions/nft.fish
            info "Fish: instalado en ~/.config/fish/completions/nft.fish"
        fi
    else
        warn "Fish: no encontrado, saltando"
    fi
}

install_bash
install_zsh
install_fish

echo ""
info "Instalación completa."
echo ""
echo "  Recarga tu shell:"
echo "    Bash:  source ~/.bashrc"
echo "    Zsh:   source ~/.zshrc"
echo "    Fish:  (automático)"
echo ""
echo "  Prueba:  nft <TAB>"
echo ""
