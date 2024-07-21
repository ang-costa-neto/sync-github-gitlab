#!/bin/bash

set -e

# Adiciona o repositório remoto com autenticação
git remote add target https://${TARGET_USERNAME}:${TARGET_TOKEN}@${TARGET_URL#https://}

# Sincroniza o repositório com base no tipo de evento do GitHub
case "${GITHUB_EVENT_NAME}" in
    push)
        echo "Pushing all branches and tags to the target repository..."
        git push -f --all target
        git push -f --tags target
        ;;
    *)
        echo "Event type ${GITHUB_EVENT_NAME} not supported. Exiting."
        exit 0
        ;;
esac
