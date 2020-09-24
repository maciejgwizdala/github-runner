#!/usr/bin/env bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -o|--owner)
            OWNER="$2"
            shift
            shift
        ;;
        -r|--repo)
            REPO="$2"
            shift
            shift
        ;;
        -p|--pat)
            PAT="$2"
            shift
            shift
        ;;
        -n|--name)
            NAME="$2"
            shift
            shift
        ;;
        --register-only)
            REGISTER_ONLY=YES
            shift
        ;;
        *)
            POSITIONAL+=("$1")
            shift
        ;;
    esac
done
set -- "${POSITIONAL[@]}"
[ -z "$NAME" ] && NAME=$(hostname)

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

configure

if [ -z ${REGISTER_ONLY} ]; then
    ./run.sh --once
    cleanup
fi