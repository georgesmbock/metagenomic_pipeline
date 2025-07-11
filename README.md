*Lightweight and reproducible virome analysis pipeline for ecological studies.*
# Reproducible Pipeline for Viral Community Analysis: Cuatro Ciénegas Basin Case Study.
This repository contains a reproducible, containerized bioinformatics workflow for analyzing viral communities in aquatic ecosystems under nutrient enrichment. The pipeline automates key steps such as taxonomic classification and ecological diversity assessment, and it provides an interactive environment via Jupyter Notebooks for manual exploration, visualization, and further analyses. This approach is demonstrated here using publicly available sequencing data from the oligotrophic Cuatro Ciénegas Basin.

---

## Objectives
- Develop an **end-to-end viral metagenomics workflow** with minimal computational resources (≤8 GB RAM).
- Provide **reproducible analyses** through Docker containers and well-documented Jupyter notebooks.
- Explore **taxonomic composition and ecological diversity** of viral communities under different nutrient conditions.
- Lay the groundwork for **future functional annotation and risk assessment**.

---

## Workflow Overview
```
           ┌────────────┐
           │  Raw FASTQ │
           └────┬───────┘
                │
         ┌──────▼──────┐
         │   FastQC    │ (Quality Control)
         └──────┬──────┘
                │
         ┌──────▼──────┐
         │  Kraken2    │ (Taxonomic Classification)
         └──────┬──────┘
                │
         ┌──────▼──────┐
         │   Krona     │ (Interactive Visualization)
         └──────┬──────┘
                │
     ┌──────────▼──────────┐
     │ Ecological Indices  │  (Manual - v1)(Shannon, Simpson, Bray-Curtis)
     └──────────┬──────────┘
                │
          ┌─────▼─────┐
          │  Results  │ (HTML reports + Tables)
          └───────────┘

```

---

## Manual and Interactive Analyses via Jupyter Notebooks

While the main pipeline ensures fast and memory-efficient preprocessing and taxonomic profiling,
the in-depth ecological and statistical analyses were conducted manually using Jupyter notebooks.

These notebooks allow for:

Detailed taxonomic comparisons

Calculation of ecological diversity indices (Shannon, Simpson, Bray-Curtis)

Custom visualizations (heatmaps, diversity curves, bar plots)

#### **Included notebooks:**

*02_Viral_Diversity_Taxonomic_Comparison_and_Ecological_Indices.ipynb*
→ Calculates diversity indices and compares sample compositions

*report_krona.ipynb*
→ Integrates and interprets Krona visualizations interactively

*Final_report.ipynb*
→ Consolidates all figures and results for final reporting

**Note: Statistical and graphical analyses are deliberately performed manually to ensure a fine-grained, user-controlled, and adaptable interpretation of the results.**

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
│   └── KRANKEN2_DB_DOWNLOAD.md    # Optimized Kraken2 database

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

├── scripts/                       # Auxiliary Python scripts
│   └── download_kraken_db.sh      # Script to download Kraken2 database

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

# Open your notebook by browser to make an anlysis
type: localhost:8889/tree
```
---
## Study Title
**Preliminary Quantitative Assessment of Viral Diversity Using Ecological Indices and Taxonomic Comparison of Viromes in Oligotrophic and Enriched Aquatic Environments of a Desert Oasis**

## Summary
Analyses are currently descriptive (taxonomic and diversity profiling) This project investigates the impact of nutrient enrichment on viral community diversity and taxonomic composition in aquatic ecosystems of the Cuatro Ciénegas Basin, a unique oligotrophic desert oasis in northern Mexico. 

Using a dockerized viral metagenomics pipeline, raw sequencing data were quality-controlled with FastQC and classified with Kraken2 against an optimized viral database tailored for low-memory environments (≤8GB RAM). Comparative taxonomic analyses revealed distinct viral assemblages: the nutrient-enriched sample (JP4D) was dominated by Sinsheimervirus phiX174 (>50% relative abundance), while the control sample (JC1A) featured BeAn 58058 virus as the most abundant taxon (~40%). Ecological diversity metrics showed higher Shannon diversity in the enriched environment, indicating greater taxonomic richness, although dominance patterns were reflected by the Simpson index. Bray-Curtis dissimilarity (0.8231) further confirmed substantial divergence in community composition between treatments. 

These findings demonstrate that nutrient inputs reshape viral community structure by enhancing diversity and promoting the proliferation of specific taxa. 

This study contributes valuable ecological and epidemiological insights for understanding microbial responses to environmental perturbations in fragile ecosystems. 

Future work will integrate functional annotation and multivariate statistical analyses to deepen these findings.

---
## Limitations and Next Steps
**Limitations:**

- Computational resources:

The pipeline was designed to run on hardware with limited memory (≤8 GB RAM), which restricted the use of more computationally intensive methods such as PERMANOVA and NMDS ordination.

- Database scope: 

The Kraken2 viral database used was optimized for memory efficiency but smaller than comprehensive databases, potentially limiting the taxonomic resolution and completeness.

**Future Directions:**
- Functional annotation of assembled contigs to link taxonomy and ecological function.

- Differential abundance analysis (e.g., DESeq2).

- Multivariate ordination (NMDS) and clustering.

---

## Keywords
`virome` · `viral metagenomics` · `Kraken2` · `Krona` · `ecological indices` · `bioinformatics` · `Docker` · `Jupyter` · `Cuatro Ciénegas` · `Shannon` · `Simpson` · `Bray-Curtis` · `manual analysis`

---

**Author:** Georges Christian MBOCK MBOCK,<georgesmbo89@gmail.com>
