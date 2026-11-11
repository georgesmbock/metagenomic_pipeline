#!/usr/bin/env python3
"""Build species-level abundance and QC tables from Kraken2 reports."""
import argparse, csv
from pathlib import Path

def read_report(path):
    rows = []
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            f = line.rstrip("\n").split("\t")
            if len(f) >= 6:
                # Rank/taxid/name are the final fields in both standard reports
                # and reports extended with Kraken2 minimizer information.
                rows.append({"clade_reads": int(f[1].strip()), "rank": f[-3].strip(),
                             "taxid": f[-2].strip(), "name": f[-1].strip()})
    return rows

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--samples", required=True, type=Path); p.add_argument("--reports-dir", required=True, type=Path)
    p.add_argument("--output", required=True, type=Path); p.add_argument("--qc-output", required=True, type=Path)
    p.add_argument("--excluded-taxids", default=""); args = p.parse_args()
    excluded = {x for x in args.excluded_taxids.split(",") if x}
    with args.samples.open(newline="", encoding="utf-8") as h: samples = list(csv.DictReader(h, delimiter="\t"))
    abundance, qc = [], []
    for meta in samples:
        report = read_report(args.reports_dir / f"{meta['sample']}.report.tsv")
        unclassified = next((r["clade_reads"] for r in report if r["rank"] == "U"), 0)
        root = next((r["clade_reads"] for r in report if r["rank"] == "R"), 0); total = root + unclassified
        excluded_reads = sum(r["clade_reads"] for r in report if r["taxid"] in excluded)
        denominator = max(root - excluded_reads, 0)
        qc.append({**meta, "total_reads": total, "classified_reads": root, "unclassified_reads": unclassified,
                   "excluded_control_reads": excluded_reads, "classified_percent": round(100*root/total, 6) if total else 0})
        for row in report:
            if row["rank"] == "S" and row["taxid"] not in excluded:
                abundance.append({**meta, "taxid": row["taxid"], "name": row["name"], "clade_reads": row["clade_reads"],
                                  "relative_abundance_percent": round(100*row["clade_reads"]/denominator, 8) if denominator else 0})
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fields = ["sample","condition","replicate","taxid","name","clade_reads","relative_abundance_percent"]
    with args.output.open("w", newline="", encoding="utf-8") as h:
        w=csv.DictWriter(h, fieldnames=fields, delimiter="\t"); w.writeheader(); w.writerows(abundance)
    fields = ["sample","condition","replicate","total_reads","classified_reads","unclassified_reads","excluded_control_reads","classified_percent"]
    with args.qc_output.open("w", newline="", encoding="utf-8") as h:
        w=csv.DictWriter(h, fieldnames=fields, delimiter="\t"); w.writeheader(); w.writerows(qc)

if __name__ == "__main__": main()
