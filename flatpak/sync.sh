#!/bin/sh
set -eu
LIST="$(dirname "$0")/flatpaks.txt"

echo "--- installing from flatpaks.txt ---"
while IFS= read -r app; do
  case "$app" in ""|"#"*) continue ;; esac
  if flatpak list --app | grep -q "$app"; then
    echo "ok $app"
  else
    echo "install $app"
    flatpak install -y flathub "$app"
  fi
done < "$LIST"

echo "--- checking for removals ---"
# Apps installed but no longer in list
flatpak list --app --columns=application | tail -n +1 | while read -r installed; do
  if ! grep -qx "$installed" "$LIST"; then
    echo "extra: $installed (not in flatpaks.txt - remove manually with: flatpak uninstall $installed)"
  fi
done

echo "--- applying fixes ---"
"$(dirname "$0")/fixes/apply.sh"
