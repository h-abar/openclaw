#!/bin/sh
set -e

# Railway mounts persistent volumes as root. Fix ownership so the
# non-root node user (uid 1000) can write config, sessions, etc.
if [ -d /data ]; then
  chown -R node:node /data
fi

# Drop privileges and run the gateway as `node`.
exec gosu node node openclaw.mjs gateway --allow-unconfigured "$@"
