#!/bin/bash

if [[ "$#" == "0" ]]; then
  cat <<EOF
Batoto chapter downloader
Usage:
    $0 <sample page URL> <chapter size>
e.g.:
    $0 http://www.batoto.net/read/_/159939/sakamoto-desu-ga_v1_ch1_by_cursive-scans/16
EOF
  exit 0
fi

source "$( dirname "$0" )/batoto-util.sh"

chapterId=$( sed -r 's/.*_\/([0-9]+)\/.*/\1/' <<< "$1" )
echo "Chapter $chapterId of size $2"
mkdir -p "$chapterId"
cd "$chapterId"

tehTmpDir=$( mktemp -d )

seq -f "${1%/*}/%g" $2 | ( cd "$tehTmpDir" ; wget -nv -i - )
for f in $( find "$tehTmpDir" -mindepth 1 \! -name 'tmp' ); do
  maybeUnzip "$f" "$tehTmpDir/tmp"
  cat "$f"
done |\
  grep '<img src="http://img.bato.to/comics/[0-9]' |\
  cut -d '"' -f 2 |\
  wget -nv -i -

rm "$tehTmpDir" -rf
