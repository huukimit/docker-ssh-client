#!/bin/sh

set -e

# Workaround for Gitlab runner https://gitlab.com/gitlab-org/gitlab-runner/issues/1380
if [ ! -f /run/entrypoint.lock ]; then
    eval $(ssh-agent -s)

    test "$SSH_PRIVATE_KEY" && echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
    test "$SSH_KNOWN_HOSTS" && echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts

    # Sun*CI SSH compatible
    test "$PLUGIN_PRIVATEKEY" && echo "$PLUGIN_PRIVATEKEY" | tr -d '\r' | ssh-add - > /dev/null

    > /run/entrypoint.lock
fi

exec "$@"
