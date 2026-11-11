# Professional viral metagenomics pipeline

*A sample-driven, dependency-aware and reproducible workflow for ecological virome profiling.*

> Version 2 uses Snakemake to enforce the execution graph. The notebooks are
> interpretation layers and are no longer required to run the analysis.

This repository contains a reproducible, containerized bioinformatics workflow for analyzing viral communities in aquatic ecosystems under nutrient enrichment. The pipeline automates key steps such as taxonomic classification and ecological diversity assessment, and it provides an interactive environment via Jupyter Notebooks for manual exploration, visualization, and further analyses. This approach is demonstrated here using publicly available sequencing data from the oligotrophic Cuatro Ciénegas Basin.

## Production workflow

`FASTQ → validation → FastQC(raw) → fastp → FastQC(clean) → Kraken2 → Krona → species table → MultiQC`

Every rule has explicit inputs, outputs, logs, threads and memory limits. Failed
or interrupted jobs can be resumed safely. Illumina phiX (taxid 10847) remains
visible in the QC table but is excluded from ecological abundance calculations
by default because it is commonly a sequencing control.

### Configuration

1. Register samples in `config/samples.tsv`. One row represents one biological sample.
2. Adjust paths, resources and Kraken2 thresholds in `config/config.yaml`.
3. Put the three Kraken2 database files in `db/kraken2/`.
4. Do not claim condition effects without biological replicates. The bundled
   two-sample dataset supports descriptive comparison only.

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

## Repository structure
```
/metagenomic_pipeline
├── config/                        # Parameters and sample metadata
├── workflow/Snakefile             # Dependency graph
├── workflow/scripts/              # Validated helper programs
├── data/                           # Input FASTQ files (not versioned)
├── db/kraken2/                    # Kraken2 database (not versioned)
├── notebooks/                     # Optional interpretation layer
├── results/                       # Generated deliverables (not versioned)
├── logs/                          # Per-rule execution logs
├── environment.yml               # Pinned software environment
├── dockerfile                     # Reproducible container image
├── docker-compose.yml             # Pipeline and optional Jupyter services
└── main.sh                        # Safe entry point
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
# Clone the repository
git clone https://github.com/georgesmbock/metagenomic_pipeline.git
cd metagenomic_pipeline

# Download the documented FASTQ files and Kraken2 database, then run
bash scripts/download_data.sh
bash scripts/download_kraken_db.sh
docker compose build
bash main.sh

# Preview the execution graph without running jobs
bash main.sh --dry-run

# Optional interactive notebooks
docker compose --profile interactive up jupyter
# Open http://localhost:8889
```

Principal outputs are written to `results/`: `multiqc/multiqc_report.html`,
per-sample Krona reports, Kraken2 reports, cleaned reads, and the tables
`taxonomy/abundance.tsv` and `taxonomy/qc_summary.tsv`. Detailed logs are under
`logs/`.
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
