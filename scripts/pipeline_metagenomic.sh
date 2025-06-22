#!/bin/bash
# ===============================
# Script: pipeline_metagenomic.sh
# Author: Georges MBOCK M.
# Description: full Pipeline
# ===============================

echo "Start metagenomic pipeline"

# ===============================
# Creating folder
# ===============================
mkdir -p data fastqc_results kraken_results krona_results notebooks scripts

# ===============================
# Copy the script file on scripts/
# ===============================
SCRIPT_NAME=$(basename "$0")
cp "$SCRIPT_NAME" scripts/
