#!/bin/sh
set -eu
FIXDIR="$(dirname "$0")"
for envfile in "$FIXDIR"/*.env; do
  [ -e "$envfile" ] || continue
  app=$(basename "$envfile" .env)
  if ! flatpak list --app | grep -q "$app"; then
    echo "skip $app (not installed)"
    continue
  fi
  echo "applying $app"
  flatpak override --user --reset "$app" 2>/dev/null || true
  while IFS= read -r line; do
    case "$line" in ""|"#"*) continue ;; *=*) flatpak override --user --env="$line" "$app" ;; esac
  done < "$envfile"
done
echo "done"
