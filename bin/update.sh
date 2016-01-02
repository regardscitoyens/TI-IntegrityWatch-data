#!/bin/bash

cd $(dirname $0)/..

mkdir -p data

git pull > /dev/null

function updateCsv {
  sourcefile=$1
  outfile=$2
  curl -sfL "http://www.integritywatch.fr/${sourcefile}.csv" > "data/${outfile}.tmp"
  if test -s "data/${outfile}.tmp"; then
    mv -f "data/${outfile}."{tmp,csv}
  fi
}

updateCsv parlementaires parlementaires
updateCsv collaborators collaborateurs
updateCsv p_details interets

if git status | grep "data" > /dev/null; then
  git commit data -m "autoupdate"
  git push
fi
