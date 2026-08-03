#!/usr/bin/env bash
# Re-render the Open Graph share images from og.html.
#
# og.html links the live assets/css/v2.css, so the share images always inherit
# the current design tokens and self-hosted fonts. Run this after any palette,
# type, or headline change, then commit the PNGs.
#
#   ./tools/render-og.sh
#
# Needs a Chromium/Chrome binary. Override with CHROME=/path/to/chrome.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PORT="${PORT:-8765}"

CHROME="${CHROME:-}"
if [ -z "$CHROME" ]; then
  for c in \
    /opt/pw-browsers/chromium_headless_shell-*/chrome-linux/headless_shell \
    /opt/pw-browsers/chromium-*/chrome-linux/chrome \
    "$(command -v chromium || true)" \
    "$(command -v google-chrome || true)" \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  do
    [ -x "$c" ] && CHROME="$c" && break
  done
fi
[ -n "$CHROME" ] || { echo "No Chromium found. Set CHROME=/path/to/chrome" >&2; exit 1; }

python3 -m http.server "$PORT" --bind 127.0.0.1 --directory "$ROOT" >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER 2>/dev/null || true' EXIT
sleep 2

shoot() { # shoot <url-query> <output>
  "$CHROME" --no-sandbox --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=1 --window-size=1200,630 \
    --virtual-time-budget=6000 --no-proxy-server \
    --screenshot="$ROOT/images/$2" "http://127.0.0.1:$PORT/og.html$1" 2>/dev/null
  echo "  images/$2"
}

echo "Rendering 1200x630 share images:"
shoot ""          og-v3.png
shoot "?p=story"  og-story-v3.png

echo
echo "Reminder: social platforms cache OG images for days. If you change the"
echo "artwork, bump the filename (og-v4.png) and update og:image / twitter:image"
echo "in index.html and story.html."
