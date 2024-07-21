#!/bin/bash

set -e

# Adiciona o repositório remoto com autenticação
echo https://${INPUT_TARGET_USERNAME}:${INPUT_TARGET_TOKEN}@${INPUT_TARGET_URL#https://}
git remote add target https://${INPUT_TARGET_USERNAME}:${INPUT_TARGET_TOKEN}@${INPUT_TARGET_URL#https://}

# Sincroniza o repositório com base no tipo de evento do GitHub
case "${GITHUB_EVENT_NAME}" in
    push)
        echo "Pushing all branches and tags to the target repository..."
        git push -f --all target
        git push -f --tags target
        ;;
    delete)
        echo "Deleting the reference ${GITHUB_EVENT_REF} in the target repository..."
        git push -d target ${GITHUB_EVENT_REF}
        ;;
    *)
        echo "Event type ${GITHUB_EVENT_NAME} not supported. Exiting."
        exit 0
        ;;
esac
