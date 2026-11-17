# web-relay

WebSocket relay endpoint (sing-box, VLESS over WS).

## Required environment variables

- `UUID` — the VLESS user UUID (set in the hosting dashboard, never commit it here)
- `WS_PATH` — WebSocket path, defaults to `/media-stream`
- `PORT` — provided by the platform at runtime

Start command: `bash start.sh`
