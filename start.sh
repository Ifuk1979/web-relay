#!/bin/bash
set -e
cd "$(dirname "$0")"

VER="1.14.4"
if [ ! -f sing-box ]; then
  echo "downloading sing-box v${VER} ..."
  curl -fsSL -o sb.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v${VER}/sing-box-${VER}-linux-amd64.tar.gz"
  tar -xzf sb.tar.gz
  mv "sing-box-${VER}-linux-amd64/sing-box" ./sing-box
  chmod +x sing-box
  rm -rf sb.tar.gz "sing-box-${VER}-linux-amd64"
fi

: "${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/media-stream}"
PORT="${PORT:-8080}"

cat > config.json <<EOF
{
  "log": { "level": "warn" },
  "inbounds": [
    {
      "type": "vless",
      "tag": "vless-in",
      "listen": "0.0.0.0",
      "listen_port": ${PORT},
      "users": [ { "uuid": "${UUID}" } ],
      "transport": { "type": "ws", "path": "${WS_PATH}" }
    }
  ],
  "outbounds": [ { "type": "direct", "tag": "direct" } ]
}
EOF

echo "starting tunnel on port ${PORT} path ${WS_PATH}"
exec ./sing-box run -c config.json
