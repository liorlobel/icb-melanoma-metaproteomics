# Data

No data files are in this repository. Everything here is code. This file says
where the data lives and which file is which, because one of the inputs has a
near-twin that silently yields different numbers.

## Deposited raw data

| layer | repository | accession |
|---|---|---|
| Metagenomes (host-depleted paired FASTQ) | NCBI SRA | **PRJNA1558570** |
| Metaproteomes (RAW, search results, SDRF) | PRIDE / ProteomeXchange | **PXD086916** |

The SRA deposit holds 132 libraries — 82 Pittsburgh, 50 Sheba — which is
broader than the analysed sets. It includes on-treatment and repeat libraries,
libraries below the sequencing-depth threshold, and four Sheba libraries whose
preparation failed; those four carry a per-library note in the deposit's own
metadata. See the paper's Data availability statement.

## Derived inputs the code expects

Set `ICB_DATA_ROOT` to the root holding the raw and derived data, and
`ICB_OUT_DIR` to the analysis output directory (default `final_run`). Those two
carry most of it, but they are not the whole configuration — the documents read
39 `Sys.getenv` variables in all, five of which will stop a run on a machine
other than the one the analysis was done on. The repository README lists them.

### The one file to get right

Pittsburgh quantities come from:

```
final_run/figure_inputs.rds
  modified : 2026-10-14
  size     : 288 MiB (302 MB)
  md5      : 80100a3af4169c51933743915a133ee4
  patients : 48
  carries  : the MG_DB field
```

An **earlier file of the same name** exists in some working trees:

```
Results_v8/figure_inputs.rds
  modified : 2026-09-23
  size     : 53.8 MB (51 MiB)
  md5      : 16349481c28c85d041f58f784d23eb34
  patients : 47
```

Both checksums were verified against the files on the analysis machine on
9 November 2026, and those are the only two files of this name on it. A
checksum that matches neither is a third file, and nothing here should be run
against it.

The two differ by one patient and produce different numbers — the clade gap is
+0.3100 on the September file against **+0.3291** on the October one, which is
what the paper and deposited Supplementary Table 6 report. The September file
is not the input for anything here. Check the md5 before re-running; a run that
completes without error on the wrong file is the failure mode this note exists
to prevent.

## Annotation inputs

The protein annotation tables (`metaannot_export/*.tsv`) come from an in-house
annotation pipeline that is being prepared for separate publication. The
analysis reads its exported tables and follows its rule for combining eggNOG
and KOfam KO assignments. The exported tables are derived data, not part of
this code deposit.
