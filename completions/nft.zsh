#compdef nft
# nftables zsh completion
# Instala en: /usr/local/share/zsh/site-functions/_nft
# o en cualquier dir de tu $fpath

_nft() {
    local context state state_descr line
    typeset -A opt_args

    local -a commands
    commands=(
        'add:Agregar tabla/chain/regla/set/map/elemento'
        'insert:Insertar regla en posición específica'
        'replace:Reemplazar regla existente'
        'delete:Eliminar tabla/chain/regla/set'
        'list:Listar tablas/chains/reglas/sets'
        'flush:Vaciar tabla/chain/set/ruleset completo'
        'rename:Renombrar chain'
        'create:Crear objeto (falla si ya existe)'
        'monitor:Monitorear eventos en tiempo real'
        'describe:Describir tipo de expresión'
    )

    local -a global_opts
    global_opts=(
        '(-f --file)'{-f,--file}'[Leer input de archivo]:archivo:_files'
        '(-i --interactive)'{-i,--interactive}'[Modo interactivo]'
        '(-n --numeric)'{-n,--numeric}'[Mostrar IPs y puertos en numérico]'
        '(-s --stateless)'{-s,--stateless}'[No mostrar info de estado]'
        '(-N --reversedns)'{-N,--reversedns}'[Resolver IPs a nombres]'
        '(-a --handle)'{-a,--handle}'[Mostrar handles de objetos]'
        '(-e --echo)'{-e,--echo}'[Echo de comandos añadidos]'
        '(-j --json)'{-j,--json}'[Salida en formato JSON]'
        '(-d --debug)'{-d,--debug}'[Debug output]'
        '(-v --version)'{-v,--version}'[Mostrar versión]'
        '(-h --help)'{-h,--help}'[Mostrar ayuda]'
    )

    local -a families
    families=(
        'ip:IPv4 (default)'
        'ip6:IPv6'
        'inet:IPv4 + IPv6 combinado'
        'arp:ARP'
        'bridge:Tráfico de bridge/switch'
        'netdev:Dispositivo de red específico'
    )

    local -a object_types
    object_types=(
        'table:Tabla (agrupa chains)'
        'chain:Chain (contiene reglas)'
        'rule:Regla individual'
        'set:Conjunto de IPs/puertos'
        'map:Mapa clave→valor'
        'element:Elemento de set/map'
        'flowtable:Tabla de flujos (fastpath)'
        'counter:Contador de paquetes/bytes'
        'quota:Cuota de tráfico'
        'limit:Rate limiting'
        'ct:Connection tracking helper'
    )

    _arguments -C \
        $global_opts \
        '1:comando:->command' \
        '*::args:->args'

    case $state in
        command)
            _describe 'comando nft' commands
            ;;
        args)
            case $words[1] in
                add|insert|replace|create)
                    _describe 'tipo de objeto' object_types
                    ;;
                list)
                    local -a list_targets
                    list_targets=(
                        'tables:Listar todas las tablas'
                        'chains:Listar todos los chains'
                        'rules:Listar todas las reglas'
                        'sets:Listar todos los sets'
                        'maps:Listar todos los mapas'
                        'flowtables:Listar flowtables'
                        'counters:Listar contadores'
                        'quotas:Listar cuotas'
                        'ruleset:Listar todo el ruleset completo'
                        'table:Listar tabla específica'
                        'chain:Listar chain específica'
                        'set:Listar set específico'
                        'map:Listar mapa específico'
                    )
                    _describe 'qué listar' list_targets
                    ;;
                flush)
                    local -a flush_targets
                    flush_targets=(
                        'ruleset:Borrar TODO (cuidado)'
                        'table:Vaciar tabla específica'
                        'chain:Vaciar chain específica'
                        'set:Vaciar set específico'
                        'map:Vaciar mapa específico'
                    )
                    _describe 'qué vaciar' flush_targets
                    ;;
                delete)
                    _describe 'tipo de objeto' object_types
                    ;;
                monitor)
                    local -a monitor_opts
                    monitor_opts=(
                        'new:Solo eventos de creación'
                        'destroy:Solo eventos de eliminación'
                        'tables:Monitorear tablas'
                        'chains:Monitorear chains'
                        'rules:Monitorear reglas'
                        'sets:Monitorear sets'
                        'trace:Tracing de paquetes'
                    )
                    _describe 'qué monitorear' monitor_opts
                    ;;
            esac
            ;;
    esac
}

_nft "$@"
