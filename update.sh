#!/bin/bash

BASE_URL="https://meduza.io/"
GITHUB_URL="https://meduza-io.github.io/"

xargs docker run singlefile <index.txt >index.html

while read -r url; do
  filename="${url#$BASE_URL}.html"
  mkdir -p "$(dirname "$filename")"
  docker run singlefile "https://web.archive.org/web/$url" >"$filename"
done <blocked.txt

while read -r url; do
  new="$GITHUB_URL${url#$BASE_URL}"
  sed -i "s#$url#$new#g" index.html
done <blocked.txt
