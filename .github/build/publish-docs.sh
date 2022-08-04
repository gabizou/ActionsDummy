#!/bin/bash

set -eo pipefail

function debug() {
    echo "::debug file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function warning() {
    echo "::warning file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function error() {
    echo "::error file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function add_mask() {
    echo "::add-mask::$1"
}

WORKSPACE=$(pwd)

add_mask "${GH_PAT}"


if [ -z "$GH_REPO" ]; then
  error "GH_REPO ENV is missing. Cannot proceed"
  exit 1
fi

if [ -z "$MD_FOLDER" ]; then
  debug "MD_FOLDER ENV is missing, using the default one"
  MD_FOLDER='.'
fi

declare SKIP_MD
declare DOC_TO_SKIP

if [ -n "$SKIP_MD" ]; then
   IFS= ',' read -a DOC_TO_SKIP <<< "$SKIP_MD"
fi

if [ -z "$WIKI_PUSH_MESSAGE" ]; then
  debug "WIKI_PUSH_MESSAGE ENV is missing, using the default one"
  WIKI_PUSH_MESSAGE='Auto Publish new pages'
fi

if [ -z "$TRANSLATE_UNDERSCORE_TO_SPACE" ]; then
  debug "Don't translate '_' to space in Markdown's names"
  TRANSLATE=0
else
  debug "Enable translation of '_' to spaces in Markdown's names"
  TRANSLATE=1
fi

TEMP_CLONE_FOLDER=$(mktemp -d -t wiki-XXXXXXXXXXX)

git config --global user.name "$(git log -n 1 --pretty=format:%an)"
git config --global user.email "$(git log -n 1 --pretty=format:%ae)"

cd "$TEMP_CLONE_FOLDER" || (error "failed to move to temp clone folder" && exit 1)
git clone https://"${GH_PAT}"@github.com/"$GH_REPO".wiki.git .
cd "$WORKSPACE" || (error "failed to move back to workspace" && exit 1)

FILES=$(find $MD_FOLDER -maxdepth 1 -type f -name '*.md' -execdir basename '{}' ';')
for i in $FILES; do
    realFileName=${i}
    if [[ $TRANSLATE -ne 0 ]]; then
        realFileName=${i//_/ }
        debug "$i -> $realFileName"
    else
        debug "$realFileName"
    fi
    shouldSkip=false
    for toSkip in "${DOC_TO_SKIP[@]}"
    do
    if [[ ! $toSkip =~ ${i} ]]; then
        shouldSkip=true
    fi
    done
    case $shouldSkip in
    (true) debug "Skip $i as it matches the $SKIP_MD rule";;
    (false) cp "$MD_FOLDER/$i" "$TEMP_CLONE_FOLDER/$realFileName";;
    esac
done

echo "Pushing new pages"
cd "$TEMP_CLONE_FOLDER" || return
git add .
git commit -m "$WIKI_PUSH_MESSAGE"
git log -n 2
git push --set-upstream https://"${GH_PAT}"@github.com/"$GH_REPO".wiki.git master