#!/usr/bin/env bash

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
