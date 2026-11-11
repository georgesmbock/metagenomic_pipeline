#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
base="https://zenodo.org/records/7871630/files"
mkdir -p data
for file in JC1A_R1.fastqsanger.gz JC1A_R2.fastqsanger.gz JP4D_R1.fastqsanger.gz JP4D_R2.fastqsanger.gz; do
  curl --fail --location --retry 3 --continue-at - --output "data/$file" "$base/$file"
done
echo "FASTQ downloads completed. Snakemake will validate their structure before analysis."
