#!/bin/bash

LF=$'\n'

mkdir test
cd test

curl -O "https://repo.theodyssey.dev/otas/taurine-base-v2.json"
NAME=$(cat taurine-base-v2.json | jq -r '.name')
URL=$(cat taurine-base-v2.json | jq -r '.download')

curl -O "https://taurine.app/altstore/taurinestore.json"
IPA=$(cat taurinestore.json | jq -r '.apps[].downloadURL')
DESCRIPTION=$(cat taurinestore.json | jq -r '.apps[].versionDescription' | perl -pe 's/\n/\\n/g')

echo ${NAME}
echo ${URL}
echo ${IPA}
echo ${DESCRIPTION}

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
}' "\"${NAME}\"" "${CONTENTS}" "\"${IPA}\"" "\"${DESCRIPTION}\"" >./jbupdatechecker/taurine.json

exit 0
