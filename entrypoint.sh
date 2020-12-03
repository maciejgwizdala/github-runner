#!/usr/bin/env bash

function checkvar() {
    eval VAR='$'$1
    [ -z "$VAR" ] && echo $1 env var is required && exit 1
}

function gettoken() {
    TOKEN=$(curl -s -XPOST \
    -H "authorization: token ${PAT}" \
    https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token |\
    jq -r .token)
}

function cleanup() {
    gettoken
    ./config.sh remove --token $TOKEN
}

function configure() {
    gettoken
    ./config.sh --unattended --url https://github.com/${OWNER}/${REPO} --token ${TOKEN} --name ${NAME}
}

[ -z "$NAME" ] && NAME=$(hostname)
checkvar OWNER
checkvar REPO
checkvar PAT
configure

if [ -z ${REGISTER_ONLY} ]; then
    ./run.sh --once
    cleanup
fi