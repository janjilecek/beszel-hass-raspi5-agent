#!/usr/bin/with-contenv bashio

declare __BASHIO_LOG_TIMESTAMP="%Y-%m-%d %T"

# --- Validate required config ---
if ! bashio::config.has_value 'public_key'; then
    bashio::log.error "public_key is required but not set. Exiting."
    exit 1
fi

PUBLIC_KEY="$(bashio::config 'public_key')"

# --- Validate key looks sane (non-empty, no shell metacharacters) ---
if [[ -z "$PUBLIC_KEY" || "$PUBLIC_KEY" =~ [[:space:]\;\|\&\$\`] ]]; then
    bashio::log.error "public_key value looks invalid. Exiting."
    exit 1
fi

# --- Optional: HUB_URL ---
if bashio::config.has_value 'hub_url'; then
    HUB_URL="$(bashio::config 'hub_url')"
    # Rudimentary check — must start with http:// or https://
    if [[ ! "$HUB_URL" =~ ^https?:// ]]; then
        bashio::log.error "hub_url must start with http:// or https://. Exiting."
        exit 1
    fi
    export HUB_URL
fi

# --- Optional: TOKEN ---
if bashio::config.has_value 'token'; then
    export TOKEN="$(bashio::config 'token')"
fi

# --- Port: validated as numeric in schema, default 45876 ---
if bashio::config.has_value 'port'; then
    PORT="$(bashio::config 'port')"
else
    PORT="45876"
fi

BESZEL_VERSION=$(cat /app/BESZEL_VERSION 2>/dev/null || echo "unknown")
bashio::log.info "Starting Beszel-Agent ${BESZEL_VERSION} on port ${PORT}"

exec env PORT="${PORT}" KEY="${PUBLIC_KEY}" /app/beszel-agent