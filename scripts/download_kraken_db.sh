#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
url="https://genome-idx.s3.amazonaws.com/kraken/k2_viral_20210517.tar.gz"
archive="db/k2_viral_20210517.tar.gz"
mkdir -p db/kraken2
if [[ -f db/kraken2/hash.k2d && -f db/kraken2/opts.k2d && -f db/kraken2/taxo.k2d ]]; then
  echo "Kraken2 database already installed."
  exit 0
fi
command -v curl >/dev/null 2>&1 || { echo "ERROR: curl is required." >&2; exit 127; }
curl --fail --location --retry 3 --continue-at - --output "$archive" "$url"
tar --extract --gzip --file "$archive" --directory db/kraken2
for file in hash.k2d opts.k2d taxo.k2d; do
  [[ -f "db/kraken2/$file" ]] || { echo "ERROR: missing $file after extraction." >&2; exit 1; }
done
echo "Kraken2 viral database installed in db/kraken2."
