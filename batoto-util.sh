maybeUnzip() {
  if [[ $( head -c 15 "$1" ) != "<!DOCTYPE html>" ]]; then
    zcat "$1" >"$2"
    cp "$2" "$1"
  fi
}
