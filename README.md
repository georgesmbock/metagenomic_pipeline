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
│
├── docker-compose.yml         # Orchestration des conteneurs
├── Dockerfile                 # Image de base (par ex. Kraken2, FastQC)
├── requirements.txt           # Dépendances Python (si besoin)
├── notebooks/                 # Notebooks Jupyter pour analyses interactives
│   ├── report_krona.ipynb
│   ├── 02_Viral_Diversity_Taxonomic_Comparison_and_Ecological_Indices
│   └── final_report.ipynb
├── data/
│   ├── raw/                   # Données brutes (fastq.gz)
│   └── processed/             # Résultats intermédiaires
├── results/                   # Graphiques, tableaux finaux
├── scripts/                   # Scripts Python/R auxiliaires
├── kraken_db/                 # Base Kraken2 optimisée
├── README.md                  # Documentation complète
└── .gitignore                 # Exclusion des fichiers lourds
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

### *Clone the repository**
git clone https://github.com/georgesmbock/metagenomic_pipeline.git

Limitations and Next Steps
Limitations:

Analyses are currently descriptive (taxonomic and diversity profiling).

Limited statistical testing due to small sample size.

Future Directions:

Functional annotation of assembled contigs to link taxonomy and ecological function.

Differential abundance analysis (e.g., DESeq2).

Multivariate ordination (NMDS) and clustering.

## Citation and Acknowledgments
If you use this repository or adapt the workflow, please cite:

[Georges Mbock Mbock]. Reproducible Pipeline for Viral Community Analysis: Cuatro Ciénegas Basin Case Study. [Year].

Contact: georgesmbo89@gmail.com

Special thanks to the reviewers of the Stellenbosch University MSc Bioinformatics Program for considering this work.


