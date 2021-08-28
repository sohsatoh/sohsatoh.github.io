#!/bin/bash

LF=$'\n'

mkdir test
cd test

curl -O "https://repo.theodyssey.dev/otas/taurine-base-v2.json"
NAME=$(cat taurine-base-v2.json | jq -r '.name')
URL=$(cat taurine-base-v2.json | jq -r '.download')

curl -O "https://api.github.com/repos/Odyssey-Team/Taurine/releases/latest"
IPA=$(cat latest | jq -r '.["assets"][0]["browser_download_url"]')
DESCRIPTION=$(cat latest | jq '.["body"]' | perl -pe 's/\\r//g')

echo ${NAME}
echo ${URL}
echo ${IPA}
echo ${DESCRIPTION}

if [ "${URL}" == "null" -o "${DESCRIPTION}" == "null" ]; then
  cat latest
  rm -rf ../test
  exit 0
fi

mkdir files
curl ${URL} | tar zx -C files

cd files

CONTENTS=""

while read -d $'\0' file; do
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
  },
  "ipaURL": %s,
  "description": %s
}' "\"${NAME}\"" "${CONTENTS}" "\"${IPA}\"" "${DESCRIPTION}" >./jbupdatechecker/taurine.json

exit 0
