# Kraken2 Database Download

This repository does not include the Kraken2 viral database to keep the size manageable.

Please download the viral Kraken2 database from the following URL:

- [kraken2_viral_20210517.tar.gz](https://genome-idx.s3.amazonaws.com/kraken/k2_viral_20210517.tar.gz)

After downloading, extract the archive into the `db/kraken2/` directory:

```bash
mkdir -p db/kraken2
tar -xvzf kraken2_viral_20210517.tar.gz -C db/kraken2/
```
