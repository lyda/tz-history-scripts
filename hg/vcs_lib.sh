#!/bin/bash

# A library of vcs functions used in creating the zoneinfo repositories.

vcs_init() {
  hg init
}

vcs_rm() {
  hg rm "$@"
}

vcs_commit() {
  name="$1"
  email="$2"
  date="$3"
  commit_text="$4"
  shift; shift; shift; shift;

  # This handles empty commits.
  echo "Originally committed to SCCS on elsie at $date" > .hg-migrate.txt
  echo "Migrated to hg on $(hostname) at $(date)" >> .hg-migrate.txt
  hg add
  hg commit -u "$name <$email>" -l "$commit_text" -d "$(date --date "$date" -R)"
}

vcs_tag() {
  name="$1"
  email="$2"
  tag_date="$3"
  tag="$4"
  tag_text="$5"

  hg tag -d "$(date --date "$tag_date" -R)" -u "$name <$email>" \
         -m "$tag_text" "$tag"
}
