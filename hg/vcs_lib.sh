#!/bin/bash

# A library of vcs functions used in creating the zoneinfo repositories.

dvcs_init() {
  hg init
}

dvcs_rm() {
  hg rm "$@"
}

dvcs_commit() {
  name="$1"
  email="$2"
  date="$3"
  commit_text="$4"
  shift; shift; shift; shift;

  hg add "$@"
  # TODO: There's a problem here - hg does not allow empty commits.
  #       Must detect them and create dummy files to allow them.
  hg commit -u "$name <$email>" -l "$commit_text" -d "$(date --date "$date" -R)"
}

dvcs_tag() {
  name="$1"
  email="$2"
  tag_date="$3"
  tag="$4"
  tag_text="$5"

  hg tag -d "$(date --date "$tag_date" -R)" -u "$name <$email>" \
         -m "$tag_text" "$tag"
}
