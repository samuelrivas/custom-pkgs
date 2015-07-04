#!/usr/bin/env bash
#
# The scripts that use templates expect the templates to be in the templates
# directory at the same directory the scripts live. This is not very elegant for
# packetising, so we install the templates in the share directory. This step
# rewrites the references to those scripts so that they remain valid.
#
# Ideally we should have a less brittle way of configuring assorted scripts, now
# that we can install them

source "$stdenv/setup"

fix_templates_dir () {
    local file="$1"

    substituteInPlace                                       \
        "$file"                                             \
        --replace '$SCRIPT_HOME/assorted-scripts/templates' \
        "$out/share/assorted-scripts/templates"
}

main() {
    local templated_script;
    local templated_scripts;

    templated_scripts=( $(grep -lr templates) )

    for templated_script in "${templated_scripts[@]}"; do
        echo  "$templated_script"
        fix_templates_dir "$out/bin/$templated_script"
    done
}

main
