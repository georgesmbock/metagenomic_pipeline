#!/bin/bash

# mkdir -p db/kraken2

if [ ! -f db/kraken2/hash.k2d ]; then
    echo "Téléchargement de MiniKraken2 v1..."
    #wget -c ftp://ftp.ccb.jhu.edu/pub/data/kraken2_dbs/old/minikraken2_v2_8GB_201904.tgz  db/kraken2/
    #wget -c ftp://ftp.ccb.jhu.edu/pub/data/kraken2_dbs/old/minikraken2_4GB_20171018.tgz  db/kraken2
    #wget -c ftp://ftp.ccb.jhu.edu/pub/data/kraken/indexes/minikraken_4GB_20171018.tgz db/kraken2/
    #wget -c https://zenodo.org/record/8339700/files/k2_Human_20230629.tar.gz -O human_kraken2_20230629.tgz db/kraken2/
    wget -c https://genome-idx.s3.amazonaws.com/kraken/k2_viral_20210517.tar.gz -O kraken2_viral_202504.tgz db/kraken2/

    echo "Extraction de MiniKraken2..."
    #tar -xvzf db/kraken2/minikraken2_v1_8GB_201904_UPDATE.tgz -C db/kraken2/
    #tar -xvzf db/kraken2/minikraken_4GB_2017018.tgz -C db/kraken2/
    #tar -xvzf db/kraken2/human_kraken2_20230629.tgz db/kraken2/
    tar -xvzf db/kraken2/kraken2_viral_202504.tgz db/kraken2/

    echo "MiniKraken2 téléchargée et extraite avec succès."
else
    echo "La base Kraken2 existe déjà."
fi
