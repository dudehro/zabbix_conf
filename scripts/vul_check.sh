#!/bin/bash

# Betroffene OpenSSH Versionen
vulnerable_versions=("8.5p1" "8.6p1" "8.7p1" "8.8p1" "8.9p1" "9.0p1" "9.1p1" "9.2p1" "9.3p1" "9.4p1" "9.5p1" "9.6p1" "9.7p1")

# Check OpenSSH Version
current_version=$(ssh -V 2>&1 | awk '{print $1}' | cut -d '_' -f 2)

# Check OS
os=$(uname -s)
os_version=$(uname -r)

# Das installierte System auf Schwachstellen überprüfen
is_vulnerable_version() {
  local version=$1

  # Versionen kleiner als 4.4p1 sind anfällig
  if [[ "$version" < "4.4p1" ]]; then
    return 0
  fi

  # Die Versionen 8.5p1 bis 9.7p1 sind anfällig
  for v in "${vulnerable_versions[@]}"; do
    if [[ "$version" == "$v" ]]; then
      return 0
    fi
  done

  return 1
}

# Anfällige Versionskontrolle
if is_vulnerable_version "$current_version"; then
  echo "Es gibt eine anfällige OpenSSH-Version: $current_version"
else
  echo "Die OpenSSH-Version ist gesund: $current_version"
fi
