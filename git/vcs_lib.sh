#!/bin/bash

dvcs_init() {
  git init
}

dvcs_rm() {
  git rm "$@"
}

dvcs_commit() {
  name="$1"
  email="$2"
  date="$3"
  commit_text="$4"
  shift; shift; shift; shift;

  git config user.name "$name"
  git config user.email "$email"
  git add $(find . -type f)
  git commit --allow-empty -F $commit_file --date "$date"
}

dvcs_tag() {
  tag="$1"
  tag_text="$2"
  git tag -a -m "$tag_text" "$tag"
}
