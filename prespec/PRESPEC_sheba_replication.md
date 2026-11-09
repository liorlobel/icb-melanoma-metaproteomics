# Sheba replication — criteria fixed before the permutation nulls return

**Written 20 September 2026, while the 1,000-draw within-plex permutation nulls
are running on the server and before any Sheba permutation p-value has been
seen.**

> **Note on this deposited copy.** Six collection dates and one patient's
> treatment history have been replaced by the relative timing the document
> already states elsewhere ("one day before the first dose", "7 days after
> start"), because absolute dates and an individual clinical course for a named
> study identifier do not belong in a public deposit and are not what any
> decision here turned on. Every section, amendment, withdrawal and decision
> rule is as written. Nothing else is changed.

**What is and is not blind.** Sheba's NES values are already known (COG O
−1.73, chaperones −1.72). Only their permutation p-values are unknown. This
document protects against choosing the test, threshold or testable set after
seeing those p-values. It does not make Sheba a held-out cohort — it has been
analysed alongside Pittsburgh throughout — and it is not a registered protocol.

---

## 1. Frame

**Pittsburgh is the discovery cohort. Sheba is a replication cohort**, analysed
in parallel rather than held out, and **tested only at the resolution its search
database permits.**

**Testability is decided by KO-level composition of the two search databases,
not by set size.** Pittsburgh searched a gut metagenome catalogue; Sheba an
assembly built from its own samples, with a narrower gene repertoire by
construction (§12w).

## 2. Testability — declared now, for every row

| Pittsburgh claim | Sheba | reason |
|---|---|---|
| **COG O enrichment, NR** | **TESTABLE — primary** | 202 proteins in universe (Pitt 405) |
| chaperone set, NR | testable at set level only | Sheba DB is 73.2% GroEL/DnaK among chaperone genes (Pitt 36.5%) |
| chaperone-wide, minus GroEL/DnaK | **NOT TESTABLE** | 25 proteins remain; K04080, K04081, K03775, K03771 absent from DB |
| **ribosome enrichment, NR** | **NOT TESTABLE** | 39 of 54 ribosomal KOs; 51.7% of ribosomal genes in two KOs |
| COG O remainder (non-chaperone) | NOT TESTABLE | 43 proteins |
| *Blautia* ribosome beyond capacity | tested 20 Sep | **failed** on matched KOs (§12z) |
| GDH | tested | null — agrees with refutation |

**⚠ The NOT TESTABLE rows are declared before their nulls return, so that
neither outcome can be used.** If Sheba's ribosomal set clears its null in
either direction, it is still reported as untestable, with the KO coverage as
the reason. Sheba's ribosomal NES is +1.27 — opposite to Pittsburgh — and that
is reported, not omitted.

## 3. Primary replication test — one test

> **Sheba COG O. Replication = NES < 0 AND within-plex permutation two-sided
> p < 0.05, 1,000 draws.**

- **Direction required** (NR-up, matching Pittsburgh). A significant R-up
  result is a contradiction, not a replication.
- **Two-sided p** — the one-sided/two-sided choice was never pre-specified for
  Pittsburgh, so the conservative form is used for Sheba.
- **One primary test**, so no multiplicity correction applies to it.
- `p_two = (1 + #{|null| ≥ |observed|}) / 1001`, the project's standard form.

**Secondary, reported but not counted as replication:** Sheba chaperone set and
`O_chap`, same criterion, BH-adjusted across the two.

## 4. Combined analysis — secondary, heterogeneity reported alongside

**Only on the TESTABLE rows.** Per cohort, effect = NES − null median, SE = null
SD. Inverse-variance fixed-effect estimate, **Cochran's Q and I² reported with
every combined estimate.** A combined estimate is never reported without its
heterogeneity statistic.

**Reason, from the data:** on the *Blautia* test a fixed-effect pooled estimate
gives p ≈ 0.007 for a claim that failed replication (Q = 8.0, p ≈ 0.005,
I² ≈ 88%). Pooling without heterogeneity would have reported a finding.

**If Q is significant (p < 0.10), the combined estimate is not interpreted** and
the cohorts are reported separately.

## 5. What each outcome means

| Sheba COG O | reading |
|---|---|
| NES < 0, p < 0.05 | **replicates** — at set level; the chaperone-wide character is not tested |
| NES < 0, p ≥ 0.05 | **does not replicate at this threshold**; direction agrees. Not reported as "trend" or "consistent with" |
| NES > 0, p < 0.05 | **contradicts** |
| NES > 0, p ≥ 0.05 | does not replicate |

**Row two is the one to guard against.** At n = 42 with 202 proteins, a
direction-consistent non-significant result is plausible, and it must be
reported as a failure to replicate at the stated threshold.

---

## AMENDMENT 1 — 21 September 2026, after the PITTSBURGH nulls, BEFORE the Sheba nulls

**Two properties of the null, visible only once Pittsburgh's 1,000 draws were
scored, force changes to how Sheba is scored. Both are fixed here before any
Sheba permutation result exists. The primary test (§3) is unchanged.**

### A1. NA draws — the handling rule is fixed now

**Observed in Pittsburgh:** 45 of 30,000 set-draws returned NA NES, **only in
sets of ≥324 proteins** and never in sets ≤320, frequency rising with size — an
fgsea large-set normalisation failure. Nested-set proxies (r = 0.90–0.97)
showed the NA draws were **not extreme in 17 of 17 assessable cases.**

**Rule for Sheba, fixed now:**

- **Primary scoring drops NA draws**; `p_two = (1 + #{|x| ≥ |obs|}) / (1 + n_valid)`,
  with `n_valid` reported.
- **A worst-case bound is reported alongside**, counting every NA as an
  exceedance.
- **The replication decision uses primary scoring.** If the two disagree on
  the primary test, that is reported as the result, not resolved in either
  direction.

*Sheba's primary set, COG O, holds 202 proteins — below the 324 threshold at
which NAs appeared in Pittsburgh — so it is expected to be NA-free. The rule is
fixed regardless.*

### A2. The secondary combined analysis in §4 is INVALID as written — replaced

**Observed in Pittsburgh:** the NES null is **bimodal near ±1** — 40–53% of
draws negative per set, null medians landing between −0.85 and +0.80 depending
on slight asymmetry between the modes. **"NES − null median" is therefore not
an effect size:** the median is not a centre, and subtracting it would move each
cohort's estimate by up to ~0.8 depending on which mode happened to hold more
draws.

**§4's method is withdrawn. Replacement, fixed now:**

- Per cohort, a **signed permutation z**: `z = sign(NES) × Φ⁻¹(1 − p_two / 2)`,
  from the primary-scored p. This depends only on the permutation p and the
  observed direction, so it is valid for any null shape.
- **Combined:** Stouffer, `z_comb = (z_P + z_S) / √2`, equal weights.
- **Heterogeneity:** `(z_P − z_S) / √2`, compared to N(0,1); **|value| > 1.645
  (two-sided p < 0.10) means the combined estimate is not interpreted** and the
  cohorts are reported separately — the same threshold §4 set for Cochran's Q.
- p-values at the permutation floor (1/1001) are floored, not extrapolated.

**Only on the TESTABLE rows of §2, as before.**

### A3. What Pittsburgh's nulls did to the testable-row list

§2 declared **ribosome enrichment NOT TESTABLE in Sheba** on database grounds.
Pittsburgh's ribosomal result is now **p = 0.093 (q = 0.28) — not significant in
the discovery cohort either.** It is therefore no longer a Pittsburgh claim
awaiting replication. **The row stays NOT TESTABLE for Sheba** and is reported
as not significant in Pittsburgh; neither fact is used to reinterpret the other.

§2's "chaperone-wide, minus GroEL/DnaK" row was already NOT TESTABLE in Sheba.
Pittsburgh's value is now **p = 0.026, q = 0.156** — nominal, not surviving
BH. Recorded here so the Sheba result cannot be read against a stronger
Pittsburgh claim than the nulls support.

**Nothing in §3 changes.** Sheba COG O, NES < 0 and two-sided p < 0.05, remains
the single primary test.

### A4. COG G — declared exploratory in Sheba, before its result exists

**G was not a Pittsburgh claim when this document was written; it emerged from
the Pittsburgh null scan.** On the primary route it clears BH (NES +1.409,
p = 0.006, q = 0.045), but it is **specification-dependent**: on a matched
1,857-protein universe it runs +1.10 conditioned and **−1.18 unconditioned**
(§12x). Its significance also rests on a tight null (SD 1.04) rather than a
large effect, and its 8 NA draws could not be checked by proxy.

**Status in Sheba, fixed now: EXPLORATORY, not a replication test.**

- Reported with its NES and permutation p, **whatever they are**.
- **Not counted as replication if significant**, and not counted as a failure
  if not — a specification-dependent discovery result has nothing stable for
  Sheba to replicate.
- **Not included in the §3 primary test, the §3 secondary BH family, or the
  A2 combined analysis.**

**The same rule applies to any other set that clears its null in Pittsburgh
but was not declared in §2:** exploratory in Sheba, reported, not scored as
replication. The testable-row list in §2 is closed.

---

## AMENDMENT 2 — 21 September 2026, BEFORE the Sheba nulls are opened

**The database premise of §1 and §2 was wrong, and this amendment removes it.
Every change below is decided on database files and Pittsburgh results only;
the Sheba null archive has not been opened.**

### A5. What was wrong

§1 said testability is decided by **KO-level composition of the two search
databases**, and §2's NOT TESTABLE rows cited database figures. **Those figures
were never database figures.** They were computed on proteins *observed* in each
cohort's PSMs and mislabelled as database composition.

**The actual search databases, from their full eggNOG annotations** (prefixes
verified: OIDECCNN 1,085,009; KMMIBAFL 1,825,872; PPAAKGPG 2,363,580):

| | Pittsburgh DB | Sheba DB (union) | Sheba *detected* (the mislabelled figure) |
|---|---|---|---|
| chaperone KOs present | 19 / 19 | **19 / 19** | — |
| GroEL/DnaK share of chaperone genes | 15.3% | **18.0%** | 73.2% |
| K04080, K04081, K03775, K03771 | present | **present** | "absent" |
| ribosomal KOs present | 54 / 54 | **54 / 54** | 39 / 54 |
| top-2 ribosomal KO share | 9.2% | **9.4%** | 51.7% |

**The two databases are equivalent in repertoire and proportion. Sheba's is
~4× larger in every measure.** The cohort difference arises entirely at
detection.

**§1's testability rule is withdrawn**, and with it the basis of every
database-grounded NOT TESTABLE declaration in §2 and A3.

### A6. Reclassification — on Pittsburgh significance, not on the database

The rows whose testability rested on the mislabelled figures are reclassified
on the only ground that remains: **whether Pittsburgh holds a BH-significant
discovery to replicate.**

| row | Pittsburgh (1,000-draw null) | **status in Sheba** |
|---|---|---|
| **COG O** | p = 0.006, q = 0.045 | **PRIMARY — unchanged** |
| chaperone set | p = 0.004, q = 0.045 | secondary — unchanged |
| O_chap | p = 0.003, q = 0.045 | secondary — unchanged |
| ribosome | **p = 0.093** — not significant | **EXPLORATORY** (was NOT TESTABLE) |
| chaperone-wide minus GroEL/DnaK | p = 0.026, **q = 0.156** | **EXPLORATORY** (was NOT TESTABLE) |
| O_remainder | p = 0.891 | **EXPLORATORY** (was NOT TESTABLE) |
| G | p = 0.006, q = 0.045, specification-dependent | EXPLORATORY — unchanged (A4) |

**EXPLORATORY carries A4's rule:** reported with NES and permutation p whatever
they are, counted neither as replication nor as failure, excluded from the
primary test, the secondary BH family and the combined analysis.

**No row is now NOT TESTABLE.** A3's statement that the ribosomal row "stays
NOT TESTABLE" is superseded.

### A7. A reporting requirement fixed now, whatever the primary test shows

**Sheba detects a far narrower, abundance-skewed slice of the same repertoire:**
GroEL/DnaK are 18.0% of its database chaperones but 84.3% of those in its
analysis universe. **So a Sheba COG O result — replication or not — will be
substantially a GroEL/DnaK result.**

**Required regardless of outcome:** the leading-edge composition of Sheba's COG
O (GroEL + DnaK share, count of other chaperone KOs) is reported beside the
primary result. It is not optional and not conditional on significance.

**The detection gap itself is reported as a finding**, with its candidate
causes stated as untested: search-space size (~4× larger target–decoy space
raising the FDR bar hardest on low-abundance peptides), MS2 ratio compression,
and the analysed arm's n = 29.

### A8. The analysed arm — stated here because §3 left it implicit

The analysed Sheba arm is **MS2, mixtures 3–5, n = 29** (22 R / 7 NR), searched
against the union of both Sheba assemblies. **The SPS-MS3 arm (mixtures 1–2,
n = 13, 12 of 13 without response labels) is not tested.** The Sheba cohort is
42; the replication test is on 29.

*(To be confirmed against `table(OS$d$Mixture)` before the result is read; if
the analysed object is not the MS2 arm, that is reported and this line
corrected, not the result reinterpreted.)*

---

## AMENDMENT 3 — 21 September 2026, BEFORE any Sheba null is opened and BEFORE any MS3 run

**Written with the Sheba MS2 null archive unopened and no MS3 fit or null run.
The primary test is unchanged.**

### A9. Correction to A8 — the MS3 arm's labels ARE documented

A8 excluded the SPS-MS3 arm (mixtures 1–2, n = 13) because "12 of 13 [are]
without response labels". **That was wrong.** The v11–v13 search that reached
it did not strip the `(old)` suffix the source files use, and did not search
two of the three source files.

**Verified 21 September against three source workbooks**
(`ella_stool_bank_ipi_nivo_final.xlsx`, `samples-sheba_bar_ilan.xlsx`,
`all_patients_with_stool_before_tx_deidentified.xlsx`):

| | agree with RECIST best overall response | conflict |
|---|---|---|
| MS2 arm (mixtures 3–5, n = 29) | 28 | 1 — sample `83` |
| **MS3 arm (mixtures 1–2, n = 13)** | **13** | 0 |
| **all Sheba (n = 42)** | **41** | 1 |

- **One response definition holds across both arms: RECIST best overall
  response** — CR/PR = responder, PD = non-responder. **No stable-disease
  patient is among the 42**, so the one mapping that could differ between
  criteria never arises. The 2024 annotation's column headed "Progression-free
  survival" coincides with best response for every patient it covers.
- **Sample `83`** carries Complete response in one source file and Disease
  progression in another — two treatment episodes recorded under one probe
  name. The pipeline labels it **Responder**, matching the episode that the
  sample-level record places it in. Retained as labelled; see A12.
- **Both arms are baseline samples** — 0–2 days from treatment start, with four
  outliers across the two arms (`11`, `86`, `57`, `116`) recorded here and not
  excluded.
- **MS3 arm: 8 R / 5 NR** — mixture 1 is 5 R / 3 NR, mixture 2 is 3 R / 2 NR.

### A10. MS3 added as a pre-specified SECOND ARM — not pooled, not primary

| | |
|---|---|
| **primary** | **Sheba MS2 COG O — unchanged** (§3). It alone decides whether Sheba replicates |
| **MS3 arm** | Sheba MS3 COG O, **same criterion: NES < 0 AND two-sided p < 0.05** |
| **fit** | **its own fit on its own universe** — different acquisition (SPS-MS3, ~2.2× less ratio compression) and a separate FragPipe search, so it is never pooled into one model with MS2 |
| **sets** | rebuilt from the corrected annotation on the MS3 universe, recomputed in the same script as its null (as for Pittsburgh) |
| **null** | **exact enumeration of every within-plex label configuration**: C(8,3) × C(5,2) = **560**. `p_two = #{configs with \|NES\| ≥ \|NES_obs\|} / 560`, the observed configuration included; **floor 1/560 ≈ 0.0018** |
| **NA configurations** | A1's rule: dropped for the decision, worst-case bound reported |
| **secondary sets in MS3** | chaperone set, O_chap — as for MS2 |
| **exploratory in MS3** | every row A6 and A4 made exploratory, on the same terms |
| **leading-edge composition** | required, as A7 requires for MS2 |

**Decision rule, fixed now:** replication is decided by the primary MS2 test
alone. **The MS3 arm and the combined Sheba estimate are reported whatever they
show and cannot promote a failed primary into a replication.** If the primary
fails and the combined estimate clears its threshold, the result is reported as
*"does not replicate on the pre-specified primary test"*, with the combined
estimate as secondary.

### A11. Correction to A2 — the combination formulas assumed equal-sized arms

A2 combined arms with equal-weight Stouffer, `(z_1 + z_2)/√2`, and tested
heterogeneity as `(z_1 − z_2)/√2`. **Both assume equal n.** Under a homogeneous
true effect, z scales with √n, so with arms of 55, 29 and 13 the heterogeneity
statistic is non-zero from sample size alone and equal weights under-use the
larger arm. **Replaced, before any Sheba result is known:**

- per arm: `z_i = sign(NES_i) × Φ⁻¹(1 − p_i/2)`; effect scale `d_i = z_i / √n_i`
- **combined:** √n-weighted Stouffer, `z = Σ √n_i · z_i / √(Σ n_i)`
- **heterogeneity:** `Q = Σ n_i (d_i − d̄)²`, `d̄ = Σ n_i d_i / Σ n_i`, compared
  to χ² on k − 1 df; **p < 0.10 → the combined estimate is not interpreted**

Applied to two combinations, both secondary: **Sheba** (MS2 + MS3; n = 29, 13)
and **cross-cohort** (Pittsburgh + MS2 + MS3; n = 55, 29, 13). Testable rows
only, as before.

### A12. Sample `83`

Primary and MS2 analyses use `83` as labelled (Responder). **A sensitivity
analysis excluding `83` is run and reported whatever the primary shows** — it
needs its own MS2 null. Which physical sample `83` is (the two files record
different collection dates) is to be settled from the laboratory sample log
and reported as found; it does not change which analysis is primary.

### A13. A cross-cohort limitation, stated before results

**Sheba's labels are RECIST best overall response. Pittsburgh's, per the
v11–v13 audit, encode "ever progressed"** — a different criterion (not
re-verified here). Pittsburgh-discovery / Sheba-replication therefore compares
**different response definitions.** This is reported as a limitation whatever
the nulls show, and cannot be invoked selectively to explain a failure or
discounted to strengthen a success.

---

## AMENDMENT 4 — 21 September 2026, BEFORE any Sheba null is opened; no MS3 run was started

### A14. A10 WITHDRAWN — mixtures 1–2 are a different TIMEPOINT, not a second arm

A10 treated mixtures 1–2 as an **acquisition** arm (SPS-MS3). **The design
defines Sheba's arms by timepoint**, and in Sheba acquisition and timepoint are
aliased. Per sample, from `colData(qf$sheba)` and `SAMP_PRIMARY`:

| mixture | samples | resp | arm | note |
|---|---|---|---|---|
| 1 | 122A, 87A, 141, 182, 177 | R | `sheba_base` | |
| 1 | 82, 566, 96 | NR | `sheba_base` | |
| 2 | 165A, 166A, 174A | R | `sheba_base` | |
| 2 | **86A** | NR | **`sheba_ontx`** | 7 days after start; dropped from the analysed arm because mixture 2 has no other on-treatment sample (fails NR ≥ 2 / R ≥ 2) |
| 2 | **11** | NR | — | **excluded**; not in `SAMP_PRIMARY`; sampled 304 days before start |

- **`sheba_base`** — the study's only pre-treatment baseline arm, 0–1 days
  before start — is mixture 1 plus mixture 2's three responders, n = 11.
- **The primary test (`sheba_ontx`) and Pittsburgh's discovery (`pitt_ontx`)
  are both on-treatment.** Mixtures 1–2 are therefore not a replication arm for
  the same test: A10 would have folded a baseline question into an on-treatment
  replication.
- **`sheba_base` cannot support a within-plex test regardless** — its mixture 2
  holds no non-responder (C11).

**Withdrawn:** A10 in full; its 560-configuration exact null; the within-Sheba
(MS2 + MS3) combination in A11. `run_ms3_exact.R` is not run.

### A15. Correction to A9's timepoint statement

A9 said *"Both arms are baseline samples — 0–2 days from treatment start."*
**That flattened the direction the design turns on.** `sheba_base` samples sit
0–1 days **before** start; `sheba_ontx` samples 0–2 days **after**, with
outliers at 38 and 73 days (`57`, `116`). A9's four outliers resolve as: `11`
excluded, `86A` on-treatment, `57` and `116` on-treatment.

### A16. A11 reduced to one combination

**Cross-cohort only: Pittsburgh + Sheba MS2** (n = 55, 29), √n-weighted
Stouffer, heterogeneity Q on 1 df, **p_Q < 0.10 → not interpreted.** Testable
rows only. A11's formulas otherwise stand.

### A17. What stands from A9

**RECIST best overall response is the single response definition across all
42 Sheba samples** (41/42 agree; `83` as A12), and the labels of mixtures 1–2
are documented. **Recorded as documentation. It creates no test.**

### State of the pre-specification after Amendment 4

| | |
|---|---|
| **primary** | Sheba `sheba_ontx` (MS2, mixtures 3–5, n = 29, 22 R / 7 NR) COG O — NES < 0 and two-sided p < 0.05. **Unchanged since §3.** |
| secondary | chaperone set, O_chap (A6) |
| exploratory | ribosome, chaperone-wide minus GroEL/DnaK, O_remainder, G (A4, A6) |
| sensitivity | primary without `83` (A12) |
| combined | Pittsburgh + Sheba MS2 only (A16) |
| **power** | **7 non-responders. The limit A9–A10 tried to relieve stands.** |

---

## AMENDMENT 5 — 21 September 2026, BEFORE any Sheba null is opened

**Written after tracing every analysed sample to its collection record. It
reverses part of Amendment 4, which rested on the arms' names rather than
their dates.**

### A18. A15 WITHDRAWN — A9's timepoint statement was right

A15 said the `sheba_ontx` samples sit "0–2 days **after**" treatment start.
**They sit before it.** Evidence:

- **`Sample_Taken_in_Days` = start − collection in 32 of 32 rows** of
  `samples-sheba_bar_ilan.xlsx`; no sample in that file was collected after
  treatment began (18 before, 14 same day).
- **All 29 analysed samples are documented in that file, 0–73 days before
  start** (outliers `57` at 38, `682` at 71, `116` at 73, `173` at 65, `1705`
  at 15).
- **The stool bank reuses one probe name for up to three tubes per patient**
  (before / during / after). The proteomics `A` suffix marks the first tube:
  the six `A`-suffixed mixture 1–2 samples are exactly the six mixture 1–2
  series with more than one tube. Mixture 1–2 samples are therefore also
  pre-treatment, except **`86A`, collected 7 days after start**.

**`sheba_ontx` and `sheba_base` are both pre-treatment arms. "ontx" is not a
timepoint.** v15's descriptions of `sheba_ontx` as on-treatment and of
`sheba_base` as "the study's only true baseline arm" are wrong and are to be
corrected there.

### A19. A14's withdrawal STANDS — on corrected grounds

A14 withdrew mixtures 1–2 as a second arm because they were "a different
timepoint." **That reason is false (A18). The withdrawal stands for these:**

| | |
|---|---|
| **within-plex infeasibility** | mixture 2's pre-treatment tubes hold **no non-responder**. A within-plex test is either mixture 1 alone — **C(8,3) = 56 configurations, p-floor 1/56 ≈ 0.018** — or requires `86A` (7 days after start) and `11` (304 days before), breaking the arm's timing consistency |
| **regimen** | mixtures 1–2 are all ipilimumab + nivolumab; the primary arm is mixed (pembrolizumab 12, ipi + nivo 9, nivolumab 6, 2 other) |
| **acquisition** | SPS-MS3 against MS2 |
| **a shared patient** | **`96` is in mixture 1 and in the primary arm** (mixture 3) — two tubes, before ipi-nivo and before pembrolizumab. Any combination of arms would count one patient twice |

Re-admission, if chosen later, requires a further amendment before any null
is opened.

### A20. Sample `83` — retained as Responder, with a pre-specified rule

**All 29 analysed samples are their `samples-sheba_bar_ilan` tubes.** That
record's `83` tube was collected **one day before the first dose of that
episode**, response **Complete response** — the pipeline's label. The stool
bank's `83`, collected during a later episode and carrying Disease progression,
is a second tube of the same series.

**The source files are internally inconsistent about the order of that
patient's treatment lines**, which is why the tube cannot be identified from the
clinical record alone and is identified from the arm's dated sample record
instead. The inconsistency is reported.

**Rule, fixed now:**
- **If the mixture 3 run manifest or freezer record establishes, BEFORE the
  archive is opened, that the loaded tube is the during-ipi-nivo tube**, `83`
  is relabelled Non-responder and the primary null is re-run on 21 R / 8 NR.
- **If that is established only AFTER opening**, the primary stands as run,
  and the no-`83` result (A12) and a relabelled result are reported beside it.
- A12's no-`83` sensitivity is reported in every case.

### A21. `94A`, `97`, `173` — recorded

`94A` has two pre-treatment tubes (0 and 14 days); by the `a`/`b` convention it
is the 2018 pre-pembrolizumab tube. Non-responder either way. `97` and `173`
have later stool-bank tubes; each is documented in the arm's record by its
pre-treatment tube.

### A22. ⚠ Pittsburgh's timepoint is now UNVERIFIED

**If "ontx" is not a timepoint in Sheba, it cannot be assumed to be one in
`pitt_ontx`.** Whether the discovery and replication cohorts were sampled at
the same point relative to treatment is unverified. **It is to be established
from Pittsburgh's clinical metadata and reported before any cross-cohort
result is interpreted** — including A16's combined estimate. A timepoint
mismatch between discovery and replication would be reported as a limitation
at least as serious as A13's difference in response definition.

---

## AMENDMENT 6 — 21 September 2026, BEFORE any Sheba null is opened

**Decisions by L.L.: unit = patient; primary = pooled pre-treatment Sheba.
The primary moves for the first time, for the reasons in A26.**

### A23. The two cohorts were sampled at different timepoints

| | Pittsburgh (discovery) | Sheba |
|---|---|---|
| collected after treatment start | **48 of 54** | **0** |
| timing | median **9.5 days after** start (IQR 4–30, max 99) | 0–73 days **before** |
| source | `Lior_UPF_data.csv`: `Timepoint_days` = days since start (sign confirmed 53/54); `Sample_category` = "Earliest" | A18 |

**Pittsburgh's findings are on-treatment associations. Sheba cannot replicate
that measurement; it tests whether the difference is present before
treatment.** A22 is resolved in the direction it warned of.

### A24. Outcome wording — fixed now; "replicates" is not used

| Sheba primary | reading |
|---|---|
| NES < 0, p < 0.05 | **present before treatment** — Pittsburgh's on-treatment difference is at least partly pre-existing |
| NES < 0, p ≥ 0.05 | **not detected before treatment at n = 35 (8 NR)** — consistent with a treatment-emergent difference *or* insufficient power; this design cannot separate them. Not a "trend" |
| NES > 0, p < 0.05 | **reversed before treatment** |
| NES > 0, p ≥ 0.05 | **not detected before treatment** |

### A25. Unit of analysis: the patient

**One sample per patient: the earliest pre-treatment episode.** The rule reads
dates only, never labels, and matches Pittsburgh's "Earliest" sample per
patient. Two patients are affected:

| patient | kept | dropped |
|---|---|---|
| A | `96`, mixture 3 — the earlier tube, before that patient's line 1 | `96`, mixture 1 — the later tube, before a subsequent line |
| B | `135`, mixture 4 — the earlier tube, before line 1 | `682`, mixture 5 — the later tube, before line 2 |

### A26. NEW PRIMARY — pooled pre-treatment Sheba, patient level

| mixture | acquisition | R | NR |
|---|---|---|---|
| 1 | SPS-MS3 | 5 | 2 |
| 3 | MS2 | 8 | 2 |
| 4 | MS2 | 8 | 2 |
| 5 | MS2 | 6 | 2 |
| **total** | | **27** | **8** |

- **Mixture 2 is excluded**: its pre-treatment tubes are three responders, so it
  holds no within-plex contrast (`86A` was collected 7 days after start; `11`
  is excluded, 304 days before).
- **Test unchanged:** COG O, NES < 0, within-plex permutation two-sided
  p < 0.05, 1,000 draws. Permutation space C(7,2) × C(10,2) × C(10,2) ×
  C(8,2) = **1,190,700**.
- **Sets rebuilt on the pooled universe** from the corrected annotation.
  Secondary (chaperone set, O_chap) and exploratory rows (A4, A6) carry over.
  A7's leading-edge requirement applies to this set.
- **Limitations stated now:** mixture 1 is an SPS-MS3 plex in an otherwise MS2
  set, and all ipilimumab + nivolumab in an otherwise mixed-regimen set.
  Within-plex permutation keeps the test valid across both; it does not make
  the estimand pure.

**Why the primary moves now, and why this is not a power search:** (i) A23
redefined what Sheba can test — pre-treatment association — and both arms
answer it; (ii) the patient unit (A25) makes the existing MS2 null the wrong
unit, so it would need re-running whichever set was chosen; (iii) no Sheba
null has been opened. The gain is modest — 6 to 8 non-responders at patient
level — and is recorded as such.

### A27. The superseded primary is reported, and cannot substitute

§3's original primary — MS2 only, episode level, n = 29 (22 R / 7 NR), already
nulled — is **reported for transparency, labelled superseded**. It cannot
replace the A26 primary in either direction.

### A28. A12 redefined on the new primary

No-`83` sensitivity on the pooled patient-level set: **n = 34, 26 R / 8 NR.**
A20's rule carries over: if the run manifest establishes before opening that
the loaded `83` tube is the during-ipi-nivo tube, `83` is relabelled
Non-responder and the primary is run on **26 R / 9 NR**.

### A29. A16 withdrawn

A combined Pittsburgh + Sheba estimate would average an on-treatment and a
pre-treatment quantity and estimate neither. **No cross-cohort combination is
reported.**

### State after Amendment 6

| | |
|---|---|
| **primary** | pooled pre-treatment Sheba, patient level, mixtures 1/3/4/5, **n = 35 (27 R / 8 NR)**, COG O |
| sensitivity | same without `83` (A28); §3's MS2 episode-level result, superseded (A27) |
| secondary / exploratory | as A4, A6 |
| combined | none (A29) |
| **reading** | **A24 — pre-treatment presence, never "replication"** |

---

## AMENDMENT 7 — 22 September 2026, BEFORE any Sheba null is opened

### A30. A20 closed — sample `83` remains Responder

A20 left one question open: which of the two tubes recorded under probe `83`
was loaded in mixture 3. **The criterion, set by L.L.: the mixture's own
per-sample record — pre-treatment or on-treatment.** That record,
`samples-sheba_bar_ilan.xlsx`, which documents all 29 MS2 samples, dates 83's
tube **one day before the first dose — pre-treatment.** The other tube was
collected on treatment, during a later episode, and the NR label belongs to
that episode rather than to the one the loaded tube samples.

- **83 remains Responder.** The primary runs as specified in A26 (27 R / 8 NR).
- A28's no-`83` sensitivity is reported regardless.
- The tube's identity rests on the arm's dated record — the standard applied to
  the arm's other 28 samples — not on a freezer log.
- The arm name `sheba_ontx` played no part: it is not a timepoint (A18).

---

## AMENDMENT 8 — 22 September 2026, BEFORE any Sheba null is opened

**Raised in review, 22 September. The test and its threshold are unchanged.**

### A31. Monte Carlo precision of the primary p

With 1,000 draws, the primary permutation p carries Monte Carlo error: near
p = 0.05 its standard error is about 0.007, so a true p of 0.050 can be estimated
anywhere from about 0.037 to 0.064. The exact test's granularity is not the issue
— the within-plex space holds 1,190,700 assignments — and full enumeration is
impractical, since every assignment needs a full model refit. **Rule, fixed now:**

- The primary p is reported with its exact binomial (Clopper–Pearson) 95% interval.
- If the 1,000-draw interval excludes 0.05, the decision rests on the point estimate.
- **If it includes 0.05, the primary null is extended to 10,000 draws in total
  (draws 1001–10000, new seeds) before any reading is made**, and the decision
  rests on the 10,000-draw p, reported with its own interval.
- If that interval still includes 0.05, the result is reported as at the
  threshold; the point estimate decides the reading, and the interval is stated
  beside it.
- Secondary and sensitivity analyses are reported with their intervals and are not
  extended.

### A32. The positive reading, reworded

A24's positive reading — "Pittsburgh's on-treatment difference is at least partly
pre-existing" — draws a conclusion about Pittsburgh's patients from Sheba's. It
cannot: they are different patients and different quantities. **Reworded:** NES < 0
and p < 0.05 → **present before treatment in Sheba** — a pre-treatment
association, a different quantity from Pittsburgh's on-treatment association,
which it neither confirms nor refutes. A null likewise does not refute
Pittsburgh's result. Only the sentence printed beside the criterion changes.

