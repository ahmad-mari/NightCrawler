#!/bin/bash

nightcrawler <Domain/URL> --output links.txt && sed -i '/<*>/d' links.txt && sed  -i s/\ //g links.txt

while read LINE; do
  curl -o /dev/null --silent --head --write-out "%{http_code} $LINE\n" "$LINE"
done < links.txt  > links_with_status_code.txt
cat links_with_status_code.txt | grep '401\|301\|302\|404\|403|500\|503\|502'

rm -rf links.txt
rm -rf links_with_status_code.txt
