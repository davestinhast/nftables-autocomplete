# nftables fish shell completion
# Instala en: ~/.config/fish/completions/nft.fish

complete -c nft -f

# FLAGS GLOBALES
complete -c nft -s f -l file        -d "Leer comandos desde archivo"  -r
complete -c nft -s i -l interactive -d "Modo interactivo (readline)"
complete -c nft -s n -l numeric     -d "Mostrar IPs/puertos como números"
complete -c nft -s s -l stateless   -d "Sin información de estado"
complete -c nft -s N -l reversedns  -d "Resolver IPs a nombres DNS"
complete -c nft -s a -l handle      -d "Mostrar handles de objetos"
complete -c nft -s e -l echo        -d "Echo de objetos añadidos"
complete -c nft -s j -l json        -d "Salida en JSON"
complete -c nft -s d -l debug       -d "Debug output"
complete -c nft -s v -l version     -d "Mostrar versión"
complete -c nft -s h -l help        -d "Mostrar ayuda"

# COMANDOS PRINCIPALES
complete -c nft -n "__fish_use_subcommand" -a add      -d "Agregar tabla/chain/regla/set/map"
complete -c nft -n "__fish_use_subcommand" -a insert   -d "Insertar regla en posición"
complete -c nft -n "__fish_use_subcommand" -a replace  -d "Reemplazar regla existente"
complete -c nft -n "__fish_use_subcommand" -a delete   -d "Eliminar objeto"
complete -c nft -n "__fish_use_subcommand" -a list     -d "Listar objetos del ruleset"
complete -c nft -n "__fish_use_subcommand" -a flush    -d "Vaciar tabla/chain/ruleset"
complete -c nft -n "__fish_use_subcommand" -a rename   -d "Renombrar chain"
complete -c nft -n "__fish_use_subcommand" -a create   -d "Crear objeto (error si existe)"
complete -c nft -n "__fish_use_subcommand" -a monitor  -d "Monitorear eventos en tiempo real"
complete -c nft -n "__fish_use_subcommand" -a describe -d "Describir tipo de expresión"

# TIPOS DE OBJETO
for cmd in add insert replace delete create
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a table     -d "Tabla (agrupa chains)"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a chain     -d "Chain (contiene reglas)"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a rule      -d "Regla individual"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a set       -d "Set de IPs/puertos"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a map       -d "Mapa clave→valor"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a element   -d "Elemento de set/map"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a flowtable -d "Flowtable (hardware offload)"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a counter   -d "Contador de paquetes/bytes"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a quota     -d "Cuota de tráfico"
    complete -c nft -n "__fish_seen_subcommand_from $cmd" -a limit     -d "Rate limiter"
end

# TARGETS DE LIST
complete -c nft -n "__fish_seen_subcommand_from list" -a tables      -d "Listar todas las tablas"
complete -c nft -n "__fish_seen_subcommand_from list" -a chains      -d "Listar todos los chains"
complete -c nft -n "__fish_seen_subcommand_from list" -a rules       -d "Listar todas las reglas"
complete -c nft -n "__fish_seen_subcommand_from list" -a sets        -d "Listar todos los sets"
complete -c nft -n "__fish_seen_subcommand_from list" -a maps        -d "Listar todos los mapas"
complete -c nft -n "__fish_seen_subcommand_from list" -a flowtables  -d "Listar flowtables"
complete -c nft -n "__fish_seen_subcommand_from list" -a counters    -d "Listar contadores"
complete -c nft -n "__fish_seen_subcommand_from list" -a quotas      -d "Listar cuotas"
complete -c nft -n "__fish_seen_subcommand_from list" -a ruleset     -d "Listar TODO el ruleset"
complete -c nft -n "__fish_seen_subcommand_from list" -a table       -d "Listar tabla específica"
complete -c nft -n "__fish_seen_subcommand_from list" -a chain       -d "Listar chain específica"

# TARGETS DE FLUSH
complete -c nft -n "__fish_seen_subcommand_from flush" -a ruleset -d "Borrar TODO el ruleset"
complete -c nft -n "__fish_seen_subcommand_from flush" -a table   -d "Vaciar tabla específica"
complete -c nft -n "__fish_seen_subcommand_from flush" -a chain   -d "Vaciar chain específica"
complete -c nft -n "__fish_seen_subcommand_from flush" -a set     -d "Vaciar set específico"
complete -c nft -n "__fish_seen_subcommand_from flush" -a map     -d "Vaciar mapa específico"

# FAMILIAS
for obj in table chain rule set map element flowtable counter quota limit
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a ip     -d "IPv4"
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a ip6    -d "IPv6"
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a inet   -d "IPv4 + IPv6"
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a arp    -d "ARP"
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a bridge -d "Bridge/switch"
    complete -c nft -n "__fish_seen_subcommand_from $obj" -a netdev -d "Dispositivo de red"
end

# MONITOR EVENTS
complete -c nft -n "__fish_seen_subcommand_from monitor" -a new     -d "Solo eventos de creación"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a destroy -d "Solo eventos de eliminación"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a tables  -d "Monitorear tablas"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a chains  -d "Monitorear chains"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a rules   -d "Monitorear reglas"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a sets    -d "Monitorear sets"
complete -c nft -n "__fish_seen_subcommand_from monitor" -a trace   -d "Packet tracing"
