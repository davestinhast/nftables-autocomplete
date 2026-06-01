# nftables-autocomplete

Shell completions + helper interactivo para `nft` (nftables).  
Presiona `Tab` para autocompletar comandos, o corre `nft-helper` para ver una guía interactiva completa basada en [NFTABLES-Examn](https://github.com/davestinhast/NFTABLES-Examn).

Soporta **bash**, **zsh** y **fish**.

## Instalación rápida

```bash
git clone https://github.com/davestinhast/nftables-autocomplete
cd nftables-autocomplete
bash install.sh          # instala para tu usuario
# o
sudo bash install.sh     # instala de forma global (todos los usuarios)
```

Recarga tu shell y listo. Escribe `nft ` y presiona `Tab`.

---

## nft-helper — Ayuda interactiva

Un menú interactivo con toda la guía de tu repo [NFTABLES-Examn](https://github.com/davestinhast/NFTABLES-Examn).

```bash
# Instalar el helper
sudo cp nft-helper /usr/local/bin/nft-helper
sudo chmod +x /usr/local/bin/nft-helper

# Correrlo
nft-helper
```

Muestra un menú con 15 temas. Seleccionas el que quieres y te muestra los comandos con ejemplos.

**Modo offline** (recomendado): clona tu repo de guía primero y el helper lo detecta solo:
```bash
git clone https://github.com/davestinhast/NFTABLES-Examn ~/NFTABLES-Examn
```

**Modo online**: si no tienes el repo local, descarga el contenido de GitHub al vuelo.

**Dependencias opcionales** (mejoran la experiencia visual):
- `fzf` — menú con búsqueda fuzzy (en Kali: `sudo apt install fzf`)
- `bat` / `batcat` — resaltado de sintaxis (en Kali: `sudo apt install bat`)

---

## Instalación manual

### Bash

```bash
# Para tu usuario:
cp completions/nft.bash ~/.local/share/bash-completion/completions/nft

# Global (requiere root):
sudo cp completions/nft.bash /etc/bash_completion.d/nft
```

Agrega a `~/.bashrc` si instalaste por usuario:
```bash
source ~/.local/share/bash-completion/completions/nft
```

### Zsh

```bash
mkdir -p ~/.zsh/completions
cp completions/nft.zsh ~/.zsh/completions/_nft
```

Agrega a `~/.zshrc`:
```zsh
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
```

### Fish

```bash
cp completions/nft.fish ~/.config/fish/completions/nft.fish
```

Se activa solo.

---

## Qué autocompleta

| Completa | Ejemplos |
|---|---|
| Comandos principales | `add`, `list`, `flush`, `delete`, `monitor`... |
| Tipos de objeto | `table`, `chain`, `rule`, `set`, `map`, `flowtable`... |
| Familias de protocolos | `ip`, `ip6`, `inet`, `arp`, `bridge`, `netdev` |
| Subcomandos de `list` | `tables`, `chains`, `ruleset`, `sets`... |
| Subcomandos de `flush` | `ruleset`, `table`, `chain`... |
| Flags globales | `-f`, `-j`, `-a`, `-n`, `-s`... |
| Tablas/chains existentes | Consulta tu ruleset actual en tiempo real |

---

## Ejemplos de uso

```bash
nft <Tab>
# → add  create  delete  describe  flush  insert  list  monitor  rename  replace

nft list <Tab>
# → chains  counters  flowtables  maps  quotas  ruleset  rules  sets  tables

nft add <Tab>
# → chain  counter  element  flowtable  limit  map  quota  rule  set  table

nft add table <Tab>
# → arp  bridge  inet  ip  ip6  netdev

nft flush <Tab>
# → chain  map  ruleset  set  table
```

---

## Comandos nft más usados (referencia rápida)

```bash
# Ver todo el ruleset actual
nft list ruleset

# Crear tabla
nft add table inet mi_firewall

# Crear chain de input
nft add chain inet mi_firewall input { type filter hook input priority 0 \; policy drop \; }

# Permitir loopback y conexiones establecidas
nft add rule inet mi_firewall input iif lo accept
nft add rule inet mi_firewall input ct state established,related accept

# Permitir SSH
nft add rule inet mi_firewall input tcp dport 22 accept

# Bloquear IP específica
nft add rule inet mi_firewall input ip saddr 1.2.3.4 drop

# Guardar reglas
nft list ruleset > /etc/nftables.conf

# Cargar reglas desde archivo
nft -f /etc/nftables.conf

# Limpiar TODO (cuidado)
nft flush ruleset
```
