#!/bin/env bash

set -o pipefail
#set -x

OS_TYPE='centos7'
WORKDIR="puppet-tripleo"

declare -A META_TESTS

META_TESTS=(
            #["spec/acceptance"]="rspec" \
            ["spec"]="rake" \
            #["lint"]="rake" \
            #["syntax"]="rake" \
           )

init_context () {
    # It doesn't work due to the warning produced by bundle command ..
    #"$BUNDLER" 2>/dev/null || { echo >&2 "I require bundler gem to run tests but it's not present!"; exit 1; }

    bundle_exist=$(gem list | grep bundler)
    [ -z "$bundle_exist" ] && { echo "I require bundler gem to run tests but it's not present!"; exit 1; }
    export BEAKER_set=nodepool-"$OS_TYPE"
    export BEAKER_debug=yes

    [ ! -d "$WORKDIR" ] && git clone -b stable/queens https://git.openstack.org/openstack/puppet-tripleo

    cd "$WORKDIR" || exit
    bundle install
}

do_tests () {
    for kind in "${!META_TESTS[@]}"; do
        echo "[Exec Test] - bundle exec ${META_TESTS[$kind]} $kind"
        bundle exec "${META_TESTS[$kind]}" "$kind"
    done
}

main () {
    echo "[INIT CONTEXT]"
    init_context
    echo "[MAKE TESTS]"
    do_tests
}

main
