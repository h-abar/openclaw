#!/bin/sh
set -e

# Railway mounts persistent volumes as root. Fix ownership so the
# non-root node user (uid 1000) can write config, sessions, etc.
if [ -d /data ]; then
  chown -R node:node /data
fi

# Railway injects PORT; default to 18789 if not set.
export PORT="${PORT:-18789}"

# Drop privileges and run the gateway as `node`.
# Bind to 0.0.0.0 (lan) so Railway healthchecks and ingress can reach the gateway.
exec gosu node node openclaw.mjs gateway --allow-unconfigured --bind lan --port "$PORT" "$@"
