# Gut microbial gene abundance poorly predicts patient-specific protein output during checkpoint immunotherapy

Analysis code for a two-centre study of gut metagenomes and metaproteomes from
melanoma patients treated with anti-PD-1 and anti-CTLA-4 checkpoint blockade
(Pittsburgh and Sheba Medical Center cohorts).

**The manuscript is the authoritative statement of results.** The documents
here are the working analysis record: the code that produced the reported
numbers and figures, with the reasoning written alongside it as the work
proceeded.

## Contents

| path | what it is |
|---|---|
| `analysis/analysis_v17.Rmd` | the main analysis; produces the numbers reported in the paper |
| `analysis/01_metagenomics_Sheba_Pitt.Rmd` | metagenome processing: metadata, microtable construction, filtering, QC |
| `analysis/02_metaproteomics_Sheba_Pitt.Rmd` | metaproteome processing: FragPipe ingest, summarization, per- and cross-cohort DA, Unipept taxonomy |
| `analysis/supplementary_analyses.Rmd` | 60 standalone briefs — robustness checks, controls, replications, reviewer questions |
| `figures/figures_v2.Rmd` | figure generation |
| `prespec/` | the six pre-specification records, each fixing an analysis and its reading before that analysis was run |
| `tools/record_environment.R` | writes `package_versions.csv` and `sessionInfo.txt` for the 58 packages the documents use, and `renv.lock` for those plus their full dependency tree |
| `data/README.md` | where the data lives, and which input file is the right one |

## Running it

Two environment variables carry most of it:

```bash
export ICB_DATA_ROOT=/path/to/data      # raw and derived data
export ICB_OUT_DIR=/path/to/final_run   # analysis outputs (default: final_run)
```

**They are not the whole configuration.** Thirty-nine `Sys.getenv` variables
are read across the five documents. Most have a working default and never need
setting; these are the ones that will stop a run on a machine other than the
one the analysis was done on, because their defaults are conventions rather
than locations:

| variable | what it points at |
|---|---|
| `ICB_META_DIR` | the clinical metadata workbooks, which sit outside the project tree. Default: `Patient_metadata/` under the project root |
| `ICB_META_PITT` | the Pittsburgh clinical CSV, if it is not beside the Sheba workbooks. Default: `ICB_META_DIR` |
| `ICB_REANNOT_DIR` | `*_psm__annotation_final.tsv`. Default: the project root |
| `ICB_MP_STATE` | `metaproteomics_post14.rds` from `02`. Default: a path under `Results_for_combined_Sheba_Pitt/` |
| `ICB_BUNDLE_DIR`, `ICB_CACHE_DIR` | the input bundle and the frozen Unipept/KEGG caches |

Each of these fails with a message naming the variable and the directory it
looked in, so an unset one is a readable error rather than a silent wrong
answer. Note that **knitting spawns a new R process**, which does not inherit
`Sys.setenv()` from the console — put them in `.Renviron` at the project root
and restart R, which is what `analysis_v17.Rmd` §0b says in more detail.

The briefs in `supplementary_analyses.Rmd` take twenty-five more of their own
(`ELINAV_DIR`, `TANCA_DIR`, `B30_*`, `B33_*`, `B13B_*`, `B13C_*`, `PITT_*`,
and others) for the external-cohort work and for per-brief tuning; each is
documented where it is read, and each defaults to a relative path under
`external_coupling/` or to a value that makes the brief skip rather than fail.

One of them is worth setting deliberately. `ICB_SCORED_10K` selects the scored
table `B1d` corrects, and the 1,000- and 10,000-draw tables give different
p-values for the same set — `O_chap` at 0.0030 against 0.0078. The manuscript
reports the 10,000-draw run. `B1d` stops with a message rather than scoring the
smaller table, but only if it can tell them apart, so point the variable at
`full_space_scored_10k.csv`.

### Syntax and structure, checked

Every chunk in all five documents was parsed with R before this deposit was
made: **297 chunks, 0 parse failures**, plus the 86 inline `` `r ...` ``
expressions — 85 of them in `analysis_v17.Rmd`, the 86th a `Sys.Date()` in the
header of `02` — and no duplicate chunk labels, which knitr rejects.
`analysis_v17.Rmd` ships with `RUN <- FALSE`, its documented default, so
knitting it renders the code rather than starting a full run.

Two of the five render on a machine with neither the packages nor the data,
and both were rendered that way to check it. `analysis_v17.Rmd` does because
`RUN <- FALSE` sets `eval` for every chunk and each inline value falls back to
the figure recorded beside it, so the narrative renders with the numbers it was
written against. `supplementary_analyses.Rmd` does because all 60 chunks are
`eval=FALSE`.

The other three evaluate on render by design and need the packages and the
inputs. Without them each stops in its own setup chunk, at the first package it
cannot load: `01` at `[setup]`, `02` at `[libs]`, `figures_v2.Rmd` at
`[fig-setup]`. That is `rmarkdown::render()` behaviour, which halts on an
error. Note that a bare `knitr::knit()` does not — knitr's own default is
`error = TRUE`, so it records each failure in the output and carries on to the
end, which makes a broken run look like a completed one.

The analysis itself ran under **R 4.6.1 on aarch64-apple-darwin23**; the parse
check above used R 4.3.3, which is not the analysis environment and was used
only to check syntax.

### The environment record, and the packages it needs

The environment record is the one thing this deposit does not carry. Produce it
with

```bash
Rscript tools/record_environment.R env .
```

in any session that has the analysis packages installed — it needs no analysis
objects and reads no data, so it does not require a completed run the way the
`export-bundle` listing in `analysis_v17.Rmd` §0b does. It derives the package
list by parsing the documents rather than from a typed list, writes a row per
package with `NA` where one is not installed, and names the missing ones.

**The documents use 58 packages.** `PKGS` in §0b listed 25 until this deposit
was prepared, so an environment record made from it carried no version for
ALDEx2, ANCOMBC, maaslin3, microeco, vegan, ComplexHeatmap, phyloseq,
clusterProfiler, goseq, MSstatsTMT, survival, coxphf, pwr, ragg, systemfonts or
msigdbr — most of what `01`, `02` and the briefs run on.

`PKGS` now lists 59, one more than the script derives: lme4 reaches the
analysis through msqrob2 rather than through a call of ours, so parsing the
documents cannot find it. The note above `PKGS` says so.

**The record cannot be the analysis environment, and says so where it differs.**
It was made under R 4.6.2; the analysis ran under R 4.6.1, replaced by a patch
release on 29 October 2026. Two of the 58, ANCOMBC and maaslin3, are no longer
installed and appear in `package_versions.csv` as `NA`. Their versions are not
recoverable: the MaAsLin3 pathway tables that `01` §9.3 writes, and that
Extended Data Fig. 2 reads, were produced on 6 May 2026, and the log MaAsLin3
leaves beside its output records its arguments but not its version. Installing
both now would fill those two cells with today's versions rather than the ones
used, which is why they are left empty — an absent version is honest, a wrong
one is not.

This matters most for ANCOMBC. `01` resolves its output column names
defensively because ANCOMBC2 releases name them differently, so the code
tolerates the drift it cannot pin down; the comment at that guard names the
conventions it accepts. For maaslin3 the published Supplementary Tables are the
record of what it produced. The md5s in `data/README.md` cover
`figure_inputs.rds`, not the HUMAnN pathway abundances these two runs were
computed from, which are not fingerprinted anywhere in this deposit.

### Reproducibility, where it is exact and where it is not

The permutation p-values are exact to re-run: every null draw is seeded from
its own draw number, and the scoring reads archived draws. Enrichment scores
are not uniformly seeded — `fgseaMultilevel` estimates its null by adaptive
multilevel splitting, and `analysis_v17.Rmd` seeds some call sites and not
others, so a chunk run on its own can move an NES in the second decimal. A
top-to-bottom knit is deterministic. The note at `sets-reported` says which
calls are affected and why they were left as they are.

**Before re-running anything, read `data/README.md`.** There are two files named
`figure_inputs.rds` and only one of them is correct; the wrong one completes
without error and gives different numbers.

### One manual step between the metagenomics document and the figures

`01` writes the pathway differential-abundance tables as

```
<ICB_OUT_DIR>/humann_da/maaslin3_{pitt,sheba}_pathway/all_results.tsv
```

and `figures/figures_v2.Rmd` reads them as

```
<ICB_OUT_DIR>/humann_pathway_da/maaslin3_{pitt,sheba}_pathway.tsv
```

— a different directory and a different file name. Copy and rename the two
files between the runs. The panel stops with a message naming the source if
they are absent, so a missed copy fails loudly rather than drawing an empty
figure.

### The briefs do not knit in sequence

`supplementary_analyses.Rmd` collects 60 analyses that were each written and run
as an independent script. They are not a pipeline, several are alternatives to
one another, and each needs its own inputs. Every chunk is therefore
`eval=FALSE` — verified, all 60. Chunks are named after their source scripts.

`knitr::purl(..., documentation = 0)` gives you one 15,416-line file with no
chunk markers in it, which is not what you want. Either keep the markers:

```r
knitr::purl("analysis/supplementary_analyses.Rmd", documentation = 1)
# 15,536 lines, with a `## ----B12_sheba_coupling, eval=FALSE----` line
# at the head of each of the 60 briefs
```

or split them into one runnable file per brief:

```r
src  <- readLines("analysis/supplementary_analyses.Rmd", warn = FALSE)
dir.create("briefs", showWarnings = FALSE)
open <- grep("^```\\{r", src); close <- grep("^```$", src)
for (s in open) {
  e   <- close[close > s][1]
  lab <- trimws(sub("^```\\{r[ ,]*([^,}]*).*$", "\\1", src[s]))
  if (nzchar(lab)) writeLines(src[(s + 1):(e - 1)],
                              file.path("briefs", paste0(lab, ".R")))
}
```

That writes 60 files: 57 B-numbered, `B1_full_space_prep.R` through
`B53_stability_class.R`, and three that are not — `C1d_build_OP_new.R`,
`C2_rescore_clade.R` and `S8_sheba_power.R`. Both routes were run against this
repository and every file they produce parses.

44 of the 60 are the script as it was run. Sixteen carry changes made for this
deposit and nothing else.

Eight are corrections: dead or machine-specific paths rewritten to environment
variables (`B20`, `B30_elinav_ingest`, `B30_elinav_run`, `B30_elinav_UC_run`,
`B30_tanca_run`, `B33_external_clade`, `B41_supp_tables`,
`B42_sheba_mg_inventory`), and two comments in `B33_external_clade` that
misattributed a raw-correlation quantity to Figure 2a, which is computed on
centred log-ratios.

Eight had a `cat()` call removed that printed a past result rather than
computing one (`B12_sheba_coupling`, `B13b_sheba_family`,
`B13c_sheba_family_sweep`, `B24_leading_edge`, `B26_rank_concordance`,
`B27_what_leads`, `B42_sheba_share`, `B47_sheba_species`) — see below.

No computation was changed in any of the sixteen.

## What the prose is, and is not

The comments and narrative in these documents explain **what the code does and
why it is built that way**: why a threshold is where it is, which object a chunk
depends on, what a guard is protecting against, why one parameterization was
chosen over another.

That reasoning routinely cites the measurement that prompted it — the count a
join returned, the value a diagnostic printed, the size of the effect that made
a redesign worth doing. Those numbers are **contemporaneous records, not the
paper's results**: each is the value its run produced on the day it was written,
kept so that a later reader can see what was known when a decision was taken.
They are not maintained. `analysis_v17.Rmd` and `supplementary_analyses.Rmd`
each open with a note on their vintage, including the two input changes of
13–14 October 2026 that moved the Pittsburgh paired set from 47 to 48 patients.

**Where a comment disagrees with the manuscript or the deposited Supplementary
Tables, those are correct and the comment is a historical record.** Run against
the input named in `data/README.md`, the code reproduces the published values.

Printed output is held to a stricter rule, because a knit's console is read as
current. Calls that merely restated a past result have been removed; calls that
compute and print from the data remain. Six are kept that state fixed numbers.
Three are assertion guards, which name the shape they are checking for: two in
`B1d` — `B1d STOPPED`, which contrasts the 1,000- and 10,000-draw p-values for
`O_chap`, and the `MANIFEST` note that expects 63 duplicate member lists — and
`B47 STOPPED`, which names the library split the set must have. Three are
sizing arguments for whether a run is worth doing: `B33`'s do-not-run verdict,
and the `B33 loaded` and `B36 loaded` run instructions. Those are
specifications, not findings.

For results, read the manuscript and the deposited Supplementary Tables.

## Documents referred to but not deposited

The comments cite the working documents they were written against —
`MANUSCRIPT_v18`, the SI drafts, `MANUSCRIPT_OUTLINE_v2.md`,
`RESULTS_AND_METHODS_v17` and `REPRODUCTION_PROTOCOL.md`. These are the
authors' internal record and are not part of this repository; the published
manuscript and its Supplementary Information supersede all of them.

The six pre-specification records the briefs cite are in `prespec/` — see below.

## What is deliberately not here

- **Patient-level clinical tables.** Response, sex and collection dates per
  patient are not in this repository. The published Supplementary Tables carry
  what the paper reports. Comments do cite sample and probe identifiers, because
  the joins and the duplicate checks are about specific samples and cannot be
  explained without them — which samples were collected on the day treatment
  started, which probe appears in two mixtures. Those identifiers carry no
  patient-level clinical fact and no patient is named.
- **Data files.** Raw sequence and spectra are deposited (`data/README.md`);
  derived intermediates run to tens of gigabytes and are not version-controlled.
- **The hypothesis layer carried over from an earlier project.** Three
  hypotheses came with the handoff — arginine/ornithine biosynthesis tracking
  `ARGININE-SYN4-PWY`, a pathway count against the metagenomic prior, and
  *Phocaeicola* at protein level. All three were tested; none is in the
  manuscript or its Supplementary Information, which were checked for every
  term. Their analysis and verdict sections have been removed: `01` §9.4,
  §9B–9C, §13.5b, §13.6 and §14b, and `02` §10.5, §13, §13.b and §14, together
  with the verdict blocks in `02` §20 — about 1,200 lines. The external-cohort
  validation against published serum metabolomics was never in this repository.

  Two things are kept, and both are load-bearing for results the paper does
  report. `01` §9.3 runs the pathway differential abundance whose MaAsLin3
  tables Extended Data Fig. 2 reads and whose n the Results quote. `02` §9.5
  builds the map00220 protein set, which widens the Unipept focus query in
  §10.1 and so determines which peptides were sent to Unipept — the frozen
  taxonomy caches the analysis reads were produced with it in place. Each now
  says in the document why it survives the descoping.

## Pre-specification

`prespec/` holds the six records that fixed an analysis and its reading before
that analysis was run. Where a brief or a comment says a rule, a threshold or a
verdict was fixed in advance, this is where it was fixed.

| file | what it fixes |
|---|---|
| `PRESPEC_sheba_replication.md` | the second-cohort test: the primary, the secondary and exploratory rows, the reading of each outcome, and eight dated amendments — several withdrawing an earlier decision, all written before the null archive was opened |
| `PRESPEC_omnibus_signatures.md` | whole-profile separation, and the test of the eleven published response-associated taxa |
| `PRESPEC_survival.md` | the protein state against time to progression, including the four checks fixed before any hazard ratio is quoted |
| `PRESPEC_allocation.md` | what the chaperone increase trades against, and whether the state is assembled from the same organisms in every patient |
| `PRESPEC_profile.md` | whether the set-level profile corresponds across cohorts, with the outcome recorded including why the test could not bear weight |
| `PRESPEC_leadingedge.md` | leading-edge overlap between cohorts, and an interval rather than a p for the second cohort |

Read them for what they say about analyses that did **not** work: the profile
correlation records why its own design defeated it, and the Sheba record's
amendments withdraw three earlier plans on stated grounds.

**`PRESPEC_sheba_replication.md` is generalised in one respect**, stated in a
note at its head: six collection dates and one patient's treatment history are
replaced by the relative timing the document already gives elsewhere. Absolute
dates and an individual clinical course for a named study identifier do not
belong in a public deposit, and no decision in the document turned on them.
Every section, amendment, withdrawal and decision rule is as written.

## Data

| | |
|---|---|
| Metagenomes | NCBI SRA **PRJNA1558570** |
| Metaproteomes | PRIDE **PXD086916** |

## Citation

See `CITATION.cff`.

## Licence

MIT — see `LICENSE`.
