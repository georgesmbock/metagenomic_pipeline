# Reproducible Pipeline for Viral Community Analysis: Cuatro Ciénegas Basin Case Study
This repository contains a reproducible, containerized bioinformatics workflow for analyzing viral communities in aquatic ecosystems under nutrient enrichment. The pipeline integrates taxonomic classification, ecological diversity assessment, and visualization, applied here to publicly available sequencing data from the oligotrophic Cuatro Ciénegas Basin.

---

## Objectives
- Develop an **end-to-end viral metagenomics workflow** with minimal computational resources (≤8 GB RAM).
- Provide **reproducible analyses** through Docker containers and well-documented Jupyter notebooks.
- Explore **taxonomic composition and ecological diversity** of viral communities under different nutrient conditions.
- Lay the groundwork for **future functional annotation and risk assessment**.

---

## repository Structure
```
/metagenomic_pipeline
├── requirements.txt               # Python dependencies (if needed)

├── notebooks/                     # Jupyter Notebooks for interactive analyses
│   ├── report_krona.ipynb
│   ├── 02_Viral_Diversity_Taxonomic_Comparison_and_Ecological_Indices.ipynb
│   └── final_report.ipynb

├── data/
│   └── downloads/                 # Download instructions for raw data

├── db/
│   └── kraken_db/                 # Optimized Kraken2 database

├── results/                       # All output results
│   ├── fastqc/                    # FASTQC reports
│   │   ├── JC1A_R1_fastqc.html
│   │   ├── JC1A_R2_fastqc.html
│   │   ├── JP4D_R1_fastqc.html
│   │   └── JP4D_R2_fastqc.html
│   ├── kraken/                    # Kraken2 classification outputs
│   │   ├── JC1A_output.txt
│   │   ├── JC1A_report.txt
│   │   ├── JP4D_output.txt
│   │   └── JP4D_report.txt
│   └── krona/                     # Krona interactive visualizations
│       ├── JC1A_krona.html
│       └── JP4D_krona.html

├── scripts/                       # Auxiliary Python/R scripts
│   ├── download_kraken_db.sh      # Script to download Kraken2 database
│   ├── preprocess_reads.py        # Preprocess raw sequencing reads
│   └── generate_reports.py        # Generate summary reports

├── main.sh                        # Main pipeline execution script

├── Dockerfile                     # Docker container definition
├── docker-compose.yml             # Container orchestration

├── README.md                      # Complete documentation

└── .gitignore                     # Exclude large files

```
---

## Requirements

All analyses were conducted inside a **Docker container** to ensure reproducibility and avoid dependency conflicts.

**Key components:**
- Python ≥3.8
- Jupyter Notebook
- BioPython
- Pandas, NumPy
- Matplotlib, Seaborn
- Krona Tools (for interactive HTML visualization)
- Kraken2

**Hardware:**
- Tested on a workstation with 8GB RAM

---
## Quick Start
```
# Clone the repository**
git clone https://github.com/georgesmbock/metagenomic_pipeline.git

# Enter in metagenomic_pipeline
cd metagenomic_pipeline

# Run
./main.sh
```
#### Limitations and Next Steps
**Limitations:**

Analyses are currently descriptive (taxonomic and diversity profiling).

#### Future Directions:

- Functional annotation of assembled contigs to link taxonomy and ecological function.

- Differential abundance analysis (e.g., DESeq2).

- Multivariate ordination (NMDS) and clustering.
