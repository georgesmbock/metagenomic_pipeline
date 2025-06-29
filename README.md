#
```
/mon-projet-virome
│
├── docker-compose.yml         # Orchestration des conteneurs
├── Dockerfile                 # Image de base (par ex. Kraken2, FastQC)
├── requirements.txt           # Dépendances Python (si besoin)
├── notebooks/                 # Notebooks Jupyter pour analyses interactives
│   ├── report_krona.ipynb
│   ├── 02_analysis.ipynb
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
