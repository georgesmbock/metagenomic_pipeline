#!/bin/bash

# Create the necessary directories
mkdir -p data scripts db results/fastqc results/kraken results/krona notebooks

# If the Kraken database download script is not already in the scripts folder,
# move it there
if [ ! -f scripts/download_kraken_db.sh ]; then
       	mv download_kraken_db.sh scripts
else
	echo "The download_kraken_db.sh script is already in the scripts directory"
fi

# Chheck for the presence of FASTQ data files
echo "Checking FASTQ data..."
if [ -f data/JC1A_R1.fastqsanger.gz ] &&
   [ -f data/JC1A_R2.fastqsanger.gz ] &&
   [ -f data/JP4D_R1.fastqsanger.gz ] &&
   [ -f data/JP4D_R2.fastqsanger.gz ]; then
    echo "FASTQ data already present."
else
    # If the files are not present, download them from Zenodo
    echo "Downloading FASTQ files..."
    wget -c https://zenodo.org/record/7871630/files/JC1A_R1.fastqsanger.gz -P data/
    wget -c https://zenodo.org/record/7871630/files/JC1A_R2.fastqsanger.gz -P data/
    wget -c https://zenodo.org/record/7871630/files/JP4D_R1.fastqsanger.gz -P data/
    wget -c https://zenodo.org/record/7871630/files/JP4D_R2.fastqsanger.gz -P data/
    echo "Data download completed."
fi

# Check for the presence of the Kraken2 database (key files)
echo "Checking Kraken2 database..."
if [ -f db/kraken2/hash.k2d ] && [ -f db/kraken2/taxo.k2d ] && [ -f db/kraken2/opts.k2d ]; then
    echo "Kraken2 dattabase already completed."
else
    # If the database is missing, download and extract it
    echo "Downloading and extracting database..."
    bash scripts/download_kraken_db.sh
fi

# Confirm the Kraken2 database was properly installed after extraction
if [ -f db/kraken2/hash.k2d ] && [ -f db/kraken2/taxo.k2d ] && [ -f db/kraken2/opts.k2d ]; then
    echo "Kraken2 database successfully installed."
else
    echo "Error: Kraken2 database incomplete after extraction. Pipeline stopped."
    exit 1
fi

# Launch the Docker pipeline
echo "Starting Docker pipeline..."
docker-compose up --build

# Check that Kraken2 produced an output file
if [ -f results/kraken/kraken_output.txt ]; then
    echo "Kraken2 successfully produced an output file."
else
    echo "Error: Kraken2 did not produce an output file. Krona will not be executed."
    exit 1
fi

# Check that Krona generated a visualization
if [ -f results/krona/krona_output.html ]; then
    echo "Krona successfully generated a visualization."
else
    echo "Krona did not generated an output file. Please check the logs."
fi

# End of the pipeline
echo "Pipeline completed!"
