#!/bin/bash

if [[ "$#" == "0" ]]; then
  cat <<EOF
Batoto manga downloader
Usage:
    $0 <first chapter URL>
e.g.:
    $0 http://www.batoto.net/read/_/159939/sakamoto-desu-ga_v1_ch1_by_cursive-scans
EOF
  exit 0
fi

tehDir=$( dirname "$0" )
"$tehDir/batoto-list-chapters.sh" "$1" |\
  while read tehUrl tehSize; do
    "$tehDir/batoto-dl-chapter.sh" "$tehUrl" "$tehSize"
  done
