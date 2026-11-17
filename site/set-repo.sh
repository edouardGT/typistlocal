#!/bin/bash
# Points every GitHub link on this site (Download, Source, Issues) at another
# repository. The current one is in `current` below; this script updates that
# line too, so it can be run again later.
#
# Usage: site/set-repo.sh owner/name
set -euo pipefail

current="edouardGT/typistlocal"
new="${1:?usage: $0 owner/name}"

if [[ ! "$new" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
    echo "Not a GitHub owner/name: $new" >&2
    exit 1
fi

cd "$(dirname "$0")"
LC_ALL=C sed -i '' "s#github\.com/$current#github.com/$new#g" ./*.html
LC_ALL=C sed -i '' "s#^current=\"$current\"#current=\"$new\"#" set-repo.sh

echo "Links now point to github.com/$new:"
grep -c "github.com/$new" ./*.html
