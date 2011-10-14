#!/bin/bash

vcs_init() {
  git init
}

vcs_rm() {
  git rm "$@"
}

vcs_commit() {
  name="$1"
  email="$2"
  date="$3"
  commit_text="$4"
  shift; shift; shift; shift;

  git config user.name "$name"
  git config user.email "$email"
  git add "$@"
  git commit --allow-empty -F "$commit_text" --date "$date"
}

vcs_tag() {
  name="$1"
  email="$2"
  tag_date="$3"
  tag="$4"
  tag_text="$5"

  git tag -a -m "$tag_text" "$tag"
}
