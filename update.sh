#!/bin/bash

mkdir test
cd test

curl -O "https://repo.theodyssey.dev/otas/taurine-base.json"
VERSION=$(cat taurine-base.json | jq -r '.name' | sed -e "s/ \[.*\]//")
URL=$(cat taurine-base.json | jq -r '.download')

echo ${VERSION}
echo ${URL}

mkdir files
curl ${URL} | tar zx -C files

cd files

CONTENTS=""
LF=$'\n'

while read -d $'\0' file; do
  # CONTENTS = NULL
  file=$(echo $file | sed -e "s/\.\///")
  hash=($(shasum -a 256 ${file}))
  echo ${hash}
  CONTENTS+="\"${file}\": \"${hash}\",${LF}    "
done < <(find . -mindepth 1 -maxdepth 1 -print0)

cd ../..
rm -rf test

printf '{
  "name": %s,
  "sha256":{
    %s
  }
}' "\"${VERSION}\"" "${CONTENTS}" >./jbupdatechecker/taurine.json

exit 0
