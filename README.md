# nftables-autocomplete

Dos herramientas para trabajar con nftables en Kali Linux (o cualquier distro Debian):

- **nft-helper** — guia interactiva con 16 temas, todo embebido, sin internet
- **completions** — autocompletado con Tab para bash, zsh y fish


## Instalacion — paso a paso

### 1. Clonar el repositorio

```bash
git clone https://github.com/davestinhast/nftables-autocomplete
cd nftables-autocomplete
```

### 2. Instalar nft-helper

```bash
sudo cp nft-helper /usr/local/bin/nft-helper
sudo chmod +x /usr/local/bin/nft-helper
```

### 3. Instalar el autocompletado (zsh — default en Kali)

```bash
mkdir -p ~/.zsh/completions
cp completions/nft.zsh ~/.zsh/completions/_nft
```

Luego agregar al final de `~/.zshrc` si no esta ya:

```bash
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
```

Recargar:

```bash
source ~/.zshrc
```

### 3b. Si usas bash en lugar de zsh

```bash
sudo cp completions/nft.bash /etc/bash_completion.d/nft
source ~/.bashrc
```

### 3c. Si usas fish

```bash
cp completions/nft.fish ~/.config/fish/completions/nft.fish
```


## Uso

### nft-helper — guia interactiva

```bash
nft-helper
```

Muestra un menu numerado con 16 temas. Escribes el numero y te muestra los comandos con ejemplos.

Para ir directo a un tema sin pasar por el menu:

```bash
nft-helper 1    # Instalacion y servicio
nft-helper 2    # Ver y borrar reglas
nft-helper 3    # Tablas y cadenas
nft-helper 4    # Reglas de firewall (SSH, HTTP, IPs, ping)
nft-helper 5    # Sets y lista negra de IPs
nft-helper 6    # Guardar la configuracion
nft-helper 7    # Firewall stateful con conntrack
nft-helper 8    # Cadenas OUTPUT y FORWARD
nft-helper 9    # REJECT vs DROP y logging
nft-helper 10   # NAT — DNAT, SNAT y Masquerade
nft-helper 11   # Puertos multiples, rangos y CIDR
nft-helper 12   # IPv6
nft-helper 13   # Contadores y monitoreo
nft-helper 14   # Familias, hooks y prioridades
nft-helper 15   # Ruleset completo de ejemplo
nft-helper 16   # Referencia rapida — comandos esenciales
```

No necesita internet. Todo el contenido esta embebido dentro del script.


### Autocompletado con Tab

Una vez instalado, escribe `nft` seguido de espacio y presiona Tab:

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


## Contenido de nft-helper

Basado en [NFTABLES-Examn](https://github.com/davestinhast/NFTABLES-Examn).

| Tema | Que cubre |
|------|-----------|
| 1 | Instalacion, apt install, systemctl start/enable/status |
| 2 | list ruleset, flush, delete por handle, nano, nft -f |
| 3 | add table, add chain, policy drop vs accept |
| 4 | Loopback, SSH, HTTP, HTTPS, bloquear IP, ping, rate limit |
| 5 | Sets, lista negra, add element, @blacklist |
| 6 | Persistencia, guardar en /etc/nftables.conf, systemctl enable |
| 7 | conntrack, ct state, established, invalid, configuracion completa |
| 8 | Cadenas output y forward, iif/oif, router/gateway |
| 9 | drop vs reject, logging, prefijos, journalctl |
| 10 | NAT, tabla nat, DNAT, SNAT, masquerade, ip_forward |
| 11 | Varios puertos {}, rangos 80-90, CIDR /24, interval sets |
| 12 | IPv6, familia ip6, ICMPv6, inet para los dos juntos |
| 13 | counter, nft monitor, cuotas, ip link show |
| 14 | Familias, tipos de cadena, hooks, prioridades, tabla resumen |
| 15 | Archivo completo funcional con filter + NAT |
| 16 | Referencia rapida de los comandos mas usados |
