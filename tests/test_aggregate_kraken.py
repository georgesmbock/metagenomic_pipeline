import csv
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

class AggregateKrakenTest(unittest.TestCase):
    def test_species_table_excludes_phix(self):
        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp); reports = tmp / "reports"; reports.mkdir()
            samples = tmp / "samples.tsv"
            samples.write_text("sample\tcondition\treplicate\tr1\tr2\nS1\ttest\t1\ta\tb\n", encoding="utf-8")
            (reports / "S1.report.tsv").write_text(
                "10.00\t10\t10\tU\t0\tunclassified\n"
                "90.00\t90\t0\tR\t1\troot\n"
                "50.00\t50\t50\tS\t10847\tEnterobacteria phage phiX174\n"
                "40.00\t40\t40\tS\t123\tExample virus\n", encoding="utf-8")
            output, qc = tmp / "abundance.tsv", tmp / "qc.tsv"
            subprocess.run([sys.executable, str(ROOT / "workflow/scripts/aggregate_kraken.py"),
                            "--samples", str(samples), "--reports-dir", str(reports),
                            "--output", str(output), "--qc-output", str(qc),
                            "--excluded-taxids", "10847"], check=True)
            with output.open(encoding="utf-8") as handle: rows = list(csv.DictReader(handle, delimiter="\t"))
            self.assertEqual([row["taxid"] for row in rows], ["123"])
            self.assertEqual(float(rows[0]["relative_abundance_percent"]), 100.0)

if __name__ == "__main__": unittest.main()
