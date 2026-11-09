# Pre-specification: the protein state against time to progression

**Written 28 September 2026, before the analysis was run.**

## What this is, and what it is not

The discovery cohort's response label is **"ever progressed"**. A patient who
progressed at thirty months is therefore a non-responder alongside one who
progressed at six weeks. If the protein state tracks disease trajectory at all,
the first patient should resemble a responder, so the binary coding is diluting
whatever signal exists.

This analysis replaces that coding with time to progression.

**The gain was quantified before the analysis was run.** Simulating a cohort of
this size with a true association present, the binary "ever progressed" test
detects it 58% of the time and the time-to-event test 81%. That is the power the
current coding discards, and it is the reason for doing this at all. (The
simulation used a simplified score test, which ran slightly anticonservative
under the null at 0.083 against a nominal 0.05; `coxph` does not, and the
comparison of the two endpoints is unaffected.)

**It is not independent evidence.** Same patients, same proteomes, same
pre-specified protein sets — only the outcome coding changes. It cannot confirm
the binary result, and it will not be reported as confirmation. What it can do is
use the outcome information the binary split discards, and show whether the
association is graded rather than a two-group contrast. A graded association is
more convincing biologically than a difference of means; it is not a second
finding.

## The endpoint

**Time from sample collection to progression or death, whichever comes first.**

Not from treatment start. Samples were collected across a wide window on
treatment (median +10 days, some much later), and a patient must survive to
sampling to be in this cohort at all. Starting the clock at treatment would make
patients sampled late look as though they had survived longer because of their
proteome, which is immortal-time bias. Starting it at sampling removes that by
construction.

Patients without an event are censored at last follow-up. Death without recorded
progression counts as an event, which is standard for progression-free survival
and avoids treating an informative outcome as censoring.

**`Response_PFS_12` is not used.** That column appears twice in the Pittsburgh
clinical file and the two copies disagree; the ambiguity was recorded and never
resolved, and v12 took the first by position. The endpoint here is built from
`Rx_start`, `Prog_date`, `Death_date` and `LFU_date`, which are unambiguous. If
any of those is missing for a patient, that patient is dropped and the count is
reported.

## The predictor and the model

Two quantities, both fixed before this was written and both already defined in
the manuscript: the **chaperone share** and the **ribosomal share** of measured
microbial protein, per sample, on the logit scale.

Cox proportional hazards, **stratified by labelling batch**, matching the
within-batch principle every other analysis in this study uses. Stratification
rather than adjustment, because batch affects the baseline hazard and the
comparison of interest is within batch.

The proportional-hazards assumption is tested and reported. If it fails for the
predictor, the result is reported as a violated model rather than as a hazard
ratio.

## Direction, fixed here

Higher chaperone share is expected to associate with **shorter** time to
progression, because non-responders carried the higher share. The same for the
ribosomal share. Tests are two-sided regardless; the direction is recorded so
that a result in the opposite direction cannot later be described as a finding.

## Multiplicity

Two pre-specified quantities, one model each. This does not enter the 502-set
family: those sets were selected from a survey, and these two were named in
advance and are the subject of the paper. Both are reported whatever they show,
with no correction beyond noting that two tests were run.

## Reading rules, fixed here

- **Graded and in the pre-specified direction** — the association is stronger
  than the binary contrast suggested, and the binary coding was costing power.
  Reported as a better-powered reanalysis of the same observation, never as
  replication.
- **Null** — the binary result was not being diluted by the outcome coding, and
  Pillar 2 stands where it stood. Reported.
- **Opposite direction** — reported as such, and the binary result is
  reconsidered rather than defended.

## Checks fixed in advance of interpreting any positive result

A hazard ratio from 24 events is not reported until four things have been done,
and each is reported whatever it shows.

**Scale.** The coefficient is per logit unit, and one logit unit is more than a
doubling of the chaperone share — far outside anything observed. Any hazard ratio
quoted is quoted per standard deviation, per interquartile range, or per the
between-arm difference the paper already reports, never per logit unit.

**Who was dropped.** Patients without outcome dates are excluded by necessity. If
exclusion is associated with response the estimate is biased, and the association
is testable. It is tested.

**Influence.** At this number of events one or two patients can carry the effect.
The fit is refitted without the most influential samples and the result reported.

**A permutation p.** Every other test in this study permutes within batch. The
asymptotic p and the permutation p must agree before the number is quoted; where
they disagree the permutation p is the one reported.

## What would make this uninterpretable

Too few events. With roughly 55 samples the number of progression events may be
small, and a Cox model on a handful of events is not a test. The event count is
reported first, before any coefficient, and if it falls below 20 the analysis is
reported as underpowered and the hazard ratios are not interpreted.
