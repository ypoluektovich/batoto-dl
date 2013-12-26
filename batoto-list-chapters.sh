#!/bin/bash

if [[ "$#" == "0" ]]; then
  cat <<EOF
Batoto chapter list getter
Usage:
    $0 <sample chapter URL>
e.g.:
    $0 http://www.batoto.net/read/_/159939/sakamoto-desu-ga_v1_ch1_by_cursive-scans/16
EOF
  exit 0
fi

source "$( dirname "$0" )/batoto-util.sh"

tehTmp=$( mktemp )
tehTmp2=$( mktemp )

tehUrl="$1"
while [[ -n "$tehUrl" ]]; do
  wget -nv "$tehUrl" -O "$tehTmp"
  maybeUnzip "$tehTmp" "$tehTmp2"
  tehSize=$( grep 'page 1' "$tehTmp" | head -n 1 | sed -r 's/^.*page ([0-9]+)<\/option>$/\1/' )
  if [[ ! "${tehUrl##*/}" =~ ^[0-9]*$ ]]; then
    tehUrl="$tehUrl/1"
  fi
  echo "$tehUrl $tehSize"
  tehUrl=$( grep 'nnext.png' "$tehTmp" | head -n 1 | sed -r 's/^.*href="([^"]+)".*$/\1/' )
done

rm "$tehTmp" "$tehTmp2"
