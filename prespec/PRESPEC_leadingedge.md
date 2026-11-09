# Pre-specification: leading-edge overlap, and an interval for the second cohort

**Written 28 September 2026, before either analysis was run.** Both are post hoc
with respect to the protein state, which was found first, and both are declared
as such wherever reported.

---

## B24 — do the same proteins drive the enrichment in both cohorts?

### Why this is a different question from the one already asked

The pre-specified second-cohort test asks whether a set reaches significance
twice. It cannot, at eight non-responders. The profile-correlation attempt (B23)
failed for a structural reason: removing the reported sets to avoid circularity
also removed the discovery cohort's signal.

This asks something neither addresses. Enrichment is driven by a subset of a
set's members — the leading edge. **Do the proteins leading COG O in one cohort
overlap those leading it in the other, more than the shared measurable space
would give by chance?**

That is replication evidence at protein resolution, and it does not depend on
either cohort's p-value. It also avoids B23's circularity: each cohort's leading
edge is determined by its own ranking, not by a set either cohort selected.

### What is computed

For COG O and for the chaperone set, in each cohort separately, the leading-edge
protein list that `fgsea` returns.

**Overlap is measured in KEGG orthology space, not on protein identifiers.** The
first version of this analysis compared protein IDs and found zero proteins in
common between the cohorts. That is correct and not a defect: each cohort's
search database is built from its own metagenome assembly, so protein
identifiers are assembly artefacts and cannot match across cohorts by
construction. The shared vocabulary is the annotation.

Leading-edge proteins are therefore mapped to their primary KEGG ortholog, and
overlap is measured over the KOs present in both cohorts' universes. This is also
the better question: "the same orthologs drive the signal" is a claim about
biology, where "the same protein identifiers" would have been a claim about two
assemblies.

Statistic: the overlap count, and the proportion of the smaller leading edge it
represents.

### The null

Hypergeometric is wrong here: leading-edge membership is not a random draw from
the shared space, because both lists are biased toward abundant, well-measured
proteins. The null is instead built by sampling, from the shared measurable
proteins, sets matched to each leading edge **on abundance decile**, 2,000 times,
and recording the overlap. This asks whether the two leading edges agree more
than two abundance-matched lists would.

**The null must be drawn from the SET, not from the shared universe.** The first
run of this analysis returned P = 0.0005 for both sets, and that was an artefact
of drawing from the universe. A leading edge can only contain members of its own
set, so a null drawn from all 498 shared KOs compares the observed overlap
against a space the edges could never have occupied. For the chaperone set, whose
membership is the *same KO list* in both cohorts, the error is severe: with edges
of 9 and 7 KOs, a null drawn from 498 expects an overlap of 0.1, while one drawn
from the set's own shared members expects between 3.3 and 7.0 depending on how
many it has. The observed 6 is inside that range.

The null therefore samples from the set's own shared KOs, matched on abundance
decile. **And where a set has barely more shared KOs than its edges contain, the
overlap is near-forced and no null rescues it**: that case is detected and
reported as untestable rather than scored.

**The abundance matching is also not cosmetic, and was quantified before the
run.** Simulated
at this scale, two *independent* abundance-biased leading edges of 120 and 90
proteins overlap by about 6. A uniform null expects 2.7 and would therefore
declare independent lists to be replicating at P < 0.05 in 57% of runs. The
abundance-matched null expects 6.1, which is the right reference. Reporting this
test against a hypergeometric or uniform null would have manufactured a
replication.

### What a null would and would not mean, fixed here

A positive result is informative. A null is weak, for a reason that must be
stated rather than discovered afterwards: if the set is not extreme in the second
cohort — and it is not, at P = 0.155 — then that cohort's leading edge is partly
arbitrary, being the top of a ranking that is not strongly ordered. **A null
therefore bounds nothing.** It will be reported, and reported as uninformative.

### Reading rules

- **Overlap above the abundance-matched null** — the same proteins drive the
  signal in both cohorts. This is replication at protein resolution, independent
  of either cohort's set-level p, and is the strongest statement the second
  cohort can make.
- **At or below the null** — reported as uninformative for the reason above, not
  as evidence against replication.

---

## B25 — an interval for the second cohort, not only a p

### Why

The second cohort is reported as NES −1.48, P = 0.155: a null. But the coupling
analysis in this study already established the better idiom — report the estimate
with its interval and ask what it is compatible with. B14 turned a failed
replication into a magnitude comparison that way.

The question is whether the second cohort's NES interval contains the first
cohort's estimate, contains zero, or both.

### What is computed, and why the quantity changed

**Not the enrichment score.** Bootstrapping that would need the per-feature model
refitted on every draw, the same cost that defeated the permutation nulls
attempted elsewhere in this work.

The quantity is instead the **per-sample chaperone share**, the difference in
median share between arms in percentage points. It needs no refitting, and it is
the quantity the manuscript already reports for the discovery cohort as 10.9%
against 9.7% — so the two cohorts are compared on the same scale, which the
enrichment-score comparison never was.

Resampling is stratified within plex and within arm, 4,000 draws, so each draw
preserves the design rather than reshuffling it. Coverage was checked before the
run: the interval holds its nominal 95% at both cohort sizes, and is about 1.9
standard deviations wide at the second cohort's size against 1.4 at the first.
That width is part of the result.

### Reading rules, fixed here

- **Interval contains both zero and the first cohort's estimate** — the expected
  result, and the honest statement of what an underpowered cohort shows: its
  estimate is compatible with the discovery value and with no effect, and cannot
  distinguish them. This replaces "not detected" with something a reader can use.
- **Contains zero, excludes the first cohort's estimate** — stronger than a null:
  the second cohort rules out an effect of the size reported. This would weaken
  the paper and must be reported.
- **Excludes zero** — the second cohort detects the effect after all, and the
  pre-specified test was the less powerful summary. Reported, with the
  pre-specified p given alongside, since the registered analysis stands.

### What this does not do

It does not change the pre-specified test, which stays as the registered result.
The pre-specification required NES < 0 **and** used a two-sided p, which
penalises direction twice; that is noted in the paper as a property of the test,
and the p is **not** recomputed one-sided. Changing a registered analysis after
seeing its result is not defensible whatever the justification.
