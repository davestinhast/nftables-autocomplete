#!/usr/bin/env bash
# nftables bash completion
# Instala en: /etc/bash_completion.d/nft
# o agrega al final de tu ~/.bashrc:
#   source /ruta/a/nft.bash

_nft_completion() {
    local cur prev words cword
    _init_completion 2>/dev/null || {
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
    }

    local commands="add insert replace delete list flush rename create monitor describe"
    local object_types="table chain rule set map element flowtable counter quota ct secmark synproxy limit"
    local families="ip ip6 inet arp bridge netdev"
    local global_flags="-f --file -i --interactive -n --numeric -s --stateless -N --reversedns
                        -u --guid -a --handle -e --echo -j --json -d --debug -v --version -h --help"
    local verbs_add="table chain rule set map element flowtable counter quota ct secmark synproxy limit"
    local verbs_list="tables chains rules sets maps elements flowtables counters quotas ruleset"
    local verbs_flush="table chain set map ruleset"
    local verbs_delete="table chain rule set map element flowtable counter quota"

    case "$prev" in
        nft)
            COMPREPLY=( $(compgen -W "$commands $global_flags" -- "$cur") )
            return 0
            ;;
        add|insert|replace|create)
            COMPREPLY=( $(compgen -W "$verbs_add" -- "$cur") )
            return 0
            ;;
        list)
            COMPREPLY=( $(compgen -W "$verbs_list" -- "$cur") )
            return 0
            ;;
        flush)
            COMPREPLY=( $(compgen -W "$verbs_flush" -- "$cur") )
            return 0
            ;;
        delete)
            COMPREPLY=( $(compgen -W "$verbs_delete" -- "$cur") )
            return 0
            ;;
        table)
            COMPREPLY=( $(compgen -W "$families" -- "$cur") )
            return 0
            ;;
        chain|rule|set|map|element|flowtable|counter|quota|limit)
            local tables
            tables=$(nft list tables 2>/dev/null | awk '{print $3}')
            COMPREPLY=( $(compgen -W "$families $tables" -- "$cur") )
            return 0
            ;;
        ip|ip6|inet|arp|bridge|netdev)
            local tables
            tables=$(nft list tables "$prev" 2>/dev/null | awk '{print $3}')
            COMPREPLY=( $(compgen -W "$tables" -- "$cur") )
            return 0
            ;;
        -f|--file)
            COMPREPLY=( $(compgen -f -- "$cur") )
            return 0
            ;;
        ruleset)
            return 0
            ;;
    esac

    if [[ ${#COMP_WORDS[@]} -ge 4 ]]; then
        local obj="${COMP_WORDS[2]}"
        local family_or_table="${COMP_WORDS[3]}"

        if [[ "$families" == *"$family_or_table"* ]]; then
            local tables
            tables=$(nft list tables "$family_or_table" 2>/dev/null | awk '{print $3}')
            COMPREPLY=( $(compgen -W "$tables" -- "$cur") )
            return 0
        fi

        if [[ "$obj" == "rule" || "$obj" == "chain" ]]; then
            local chains
            chains=$(nft list table "$family_or_table" 2>/dev/null | grep 'chain ' | awk '{print $2}')
            COMPREPLY=( $(compgen -W "$chains" -- "$cur") )
            return 0
        fi
    fi

    COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
}

complete -F _nft_completion nft
