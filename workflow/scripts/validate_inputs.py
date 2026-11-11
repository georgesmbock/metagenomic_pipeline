#!/usr/bin/env python3
"""Validate sample metadata, paired FASTQ inputs, and the Kraken2 database."""
import argparse, csv, gzip
from pathlib import Path

def is_fastq(path):
    opener = gzip.open if path.suffix == ".gz" else open
    with opener(path, "rt", encoding="utf-8", errors="replace") as handle:
        lines = [handle.readline() for _ in range(4)]
    return all(lines) and lines[0].startswith("@") and lines[2].startswith("+")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--samples", required=True, type=Path)
    parser.add_argument("--database", required=True, type=Path)
    args = parser.parse_args(); errors = []
    required = {"sample", "condition", "replicate", "r1", "r2"}
    with args.samples.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        if not reader.fieldnames or not required.issubset(reader.fieldnames):
            raise SystemExit(f"Missing columns: {sorted(required - set(reader.fieldnames or []))}")
        rows = list(reader)
    names = [row["sample"] for row in rows]
    if not rows: errors.append("The sample sheet is empty")
    if len(names) != len(set(names)): errors.append("Sample identifiers are not unique")
    for row in rows:
        for mate in ("r1", "r2"):
            path = Path(row[mate])
            if not path.is_file(): errors.append(f"{row['sample']}: missing {mate}: {path}")
            elif path.stat().st_size == 0 or not is_fastq(path): errors.append(f"{row['sample']}: invalid FASTQ: {path}")
    for name in ("hash.k2d", "opts.k2d", "taxo.k2d"):
        if not (args.database / name).is_file(): errors.append(f"Kraken2 database is missing {args.database / name}")
    if errors: raise SystemExit("Input validation failed:\n- " + "\n- ".join(errors))
    print(f"Validated {len(rows)} samples and Kraken2 database at {args.database}")

if __name__ == "__main__": main()
