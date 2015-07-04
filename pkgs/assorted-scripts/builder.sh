#!/usr/bin/env bash
#
# We just need to copy the scripts and the templates to the right place here. We
# still call the generic builder so that we get the standard fixes run,
# specifically the rewrite of the shebangs.

source "$stdenv/setup"

installPhase() {

    local bin="$out/bin"
    local share="$out/share/assorted-scripts"

    mkdir -p "$bin"
    mkdir -p "$share"

    for i in $(find "$src" -maxdepth 1 -executable -type f); do
        if [[ "$(basename "$i")" != "install.sh" ]]; then
            cp "$i" "$bin"
        fi
    done

    cp -r "$src/git-hooks" "$share"
    cp -r "$src/templates" "$share"
}

genericBuild
