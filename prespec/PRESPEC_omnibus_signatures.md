# Pre-specification: omnibus separation and published-signature replication

**Written 28 September 2026, before either analysis was run.** Both address
questions a reader will ask that the manuscript currently cannot answer. Both are
fixed here first because the study's multiplicity position is already settled and
unfavourable — nothing among 565 sets survives correction, family-wise 0.86 — and
an unspecified analysis added now would be indistinguishable from searching for a
better answer.

Neither analysis enlarges the 565-set family. B15 is a single omnibus statistic
per layer. B16 tests an externally defined list that this study had no part in
choosing.

---

## B15 — Does the overall profile separate responders from non-responders?

### Why it is missing and why it matters

Every differential result in this manuscript is univariate: one protein, one gene
family, one set at a time. Nothing asks whether the profiles differ *as a whole*.
That is the first test in most microbiome papers, including the cross-cohort
analysis this manuscript cites, and its absence is conspicuous.

### What is tested

Two layers, separately, never pooled:

1. **Metaproteome**, Pittsburgh, 55 samples. Protein intensities as
   per-sample compositions, centred log-ratio transformed, Euclidean distance
   (Aitchison). CLR because both layers are compositional and the manuscript
   already uses it for exactly this reason.
2. **Metagenome**, species level, both cohorts separately. Same transform.

### The statistic

PERMANOVA pseudo-F for response, implemented directly rather than through a
package, so the permutation scheme matches the one used everywhere else in this
study.

**Permutation is WITHIN PLEX for the proteome.** Labelling batch explains a large
share of variance in these data; an unrestricted permutation would test response
confounded with plex and would be expected to separate whether or not response
does anything. Restricting the shuffle to within-plex conditions on plex by
construction. For the metagenome there is no plex, and permutation is
unrestricted.

This was checked by simulation before the analysis was run, on data with no
response effect at all, feature-specific batch structure, and response imbalanced
across plexes as it is in this cohort. The unrestricted test returned P < 0.05 in
six of six replicates; the within-plex test returned none. The restriction is
load-bearing, not a refinement. (A batch effect that scales every feature equally
is removed by the CLR transform itself and needs no restriction; it is the
feature-specific part that confounds.)

10,000 permutations. Seed fixed in the script.

### Two design rules for the second cohort, added 28 September

Both were found by diagnosing a positive result, and both are applied before any
p-value is read.

**One library per patient.** Seven patients in that cohort gave more than one
tube. Deduplicating on the library key keeps them all, and repeated samples from
one patient resemble each other more than anything else, which inflates
between-group separation. Simulated with no response effect at all, 28 patients
of whom 7 contribute a repeat tube, keeping the repeats gave P < 0.05 in six of
eight replicates against one of eight when deduplicated by patient.

**Permutation within sequencing series.** That cohort was sequenced in two series
at different read lengths. Series is a batch variable, and if response is
imbalanced across it an unrestricted permutation tests response confounded with
series. The shuffle is restricted within series, for the same reason it is
restricted within plex on the proteome side.

An arm that returned P = 0.0059 before these rules were applied is recorded here
as the reason they exist, and is not reported.

### Dispersion, which is reported whatever it shows

A PERMANOVA p-value can reflect a difference in *spread* rather than a difference
in *location*: if non-responder samples are simply more variable, the test can
separate them with no shift in centre. This is the standard failure mode and it
is tested explicitly, by comparing each group's mean distance to its own centroid
under the same permutation scheme.

**Reading rule, fixed now:**
- Location significant, dispersion not → the profiles differ in position.
- Both significant → the result is reported as unresolved between location and
  spread, not as separation.
- Location not significant → the layer does not separate as a whole. Reported.

### Multiplicity across the three arms

None is applied, and the reason is worth stating because this study corrects
aggressively elsewhere. Correction answers **selection**: the 565-set family
needs it because those sets were chosen from a survey and the claim is that a
chosen one is extreme. These three arms were fixed before the run, each asks a
different question of different data, and every one is reported whatever it
shows, so there is nothing selected to correct for. They are also not
exchangeable under a common null, which a family must be.

The raw p-value is therefore the result for each arm. What would need correcting
is a disjunctive claim — that some layer somewhere separates — and no such claim
is made. A Benjamini-Hochberg value across the three is printed alongside for a
reader who prefers to treat them as one family.

### What the result does NOT license

A significant omnibus test is not evidence for the chaperone finding, and does
not alter its correction. A null omnibus test does not retract the chaperone
finding, since an omnibus test over thousands of features has low power against a
difference concentrated in a few hundred. Either way, the omnibus result is
reported as its own sentence and no existing claim is restated in its light.

---

## B16 — Do the published response signatures appear in these cohorts?

### Why it is missing and why it matters

The manuscript tests the metagenome at phylum level only. It therefore cannot say
whether these cohorts reproduce the species associations the field already
reports. A reader cannot tell whether the weak coupling described here comes from
an atypical cohort or from the method, and that changes how everything else
generalises.

### Timepoint is the crux of this analysis

Published signatures are almost entirely **pre-treatment**. Pittsburgh is
sampled **during treatment**; Sheba is sampled **before** it.

**Sheba is therefore the timepoint-matched test and is designated primary here,
even though it is the smaller cohort.** Pittsburgh is secondary and reported as
such. A failure in Pittsburgh alone is uninformative about cohort typicality,
because timepoint and cohort are confounded there. This is stated now so that it
cannot be chosen after seeing which cohort agrees.

### The list, fixed here

Taxa named as response-associated in the landmark trials, with the published
direction. Tested one-sided in that direction; a taxon moving the other way is
recorded as not replicating, not as a discovery.

| Taxon | Level | Published direction | Source |
|---|---|---|---|
| *Faecalibacterium* | genus | higher in responders | Gopalakrishnan 2018 |
| Oscillospiraceae | family | higher in responders | Gopalakrishnan 2018, as Ruminococcaceae |
| *Akkermansia muciniphila* | species | higher in responders | Routy 2018 |
| *Bifidobacterium longum* | species | higher in responders | Matson 2018 |
| *Collinsella aerofaciens* | species | higher in responders | Matson 2018 |
| *Enterococcus faecium* | species | higher in responders | Matson 2018 |
| *Faecalibacterium prausnitzii* | species | higher in responders | Frankel 2017 |
| *Bacteroides caccae* | species | higher in responders | Frankel 2017 |
| *Dorea formicigenerans* | species | higher in responders | Frankel 2017 |
| *Holdemania filiformis* | species | higher in responders | Frankel 2017 |
| Bacteroidales | order | higher in non-responders | Gopalakrishnan 2018 |

Eleven taxa. Any taxon absent from a cohort's profile, or below the detection
floor, is reported as untestable in that cohort and excluded from the
correction's denominator for that cohort.

**Nomenclature, resolved 28 September.** The first run returned Ruminococcaceae
as not detected. That database has no family of that name: the clade is placed
under Oscillospiraceae, and inspection confirmed no Ruminococcaceae entry at any
rank. The name is therefore mapped, with direction, source and denominator
unchanged, because this is the same pre-specified hypothesis under the name the
reference uses rather than a new one. The mapping is approximate — GTDB split
the older Ruminococcaceae across several families and Oscillospiraceae carries
its core but not all of it — and that is a limitation of the test, stated here.

**These two entries are not independent.** This database nests *Faecalibacterium*
inside Oscillospiraceae, so Gopalakrishnan's genus and family claims are one
signal measured at two ranks. They are reported separately and must not be
counted as two replications.

### Test and correction

Two-sample Wilcoxon on CLR-transformed relative abundance, one-sided in the
published direction. Benjamini–Hochberg across the eleven within each cohort.
Both the per-taxon p and the corrected q are reported for every taxon, including
those that fail.

### Reading rule, fixed now

- **Several replicate in Sheba** → the cohorts are typical of the literature, and
  the coupling result is about the method rather than the sample.
- **None replicate in Sheba** → either these cohorts are atypical or the published
  signatures are weaker than reported. The manuscript states this as a limitation
  on generalisation and does not adjudicate between the two, since with 27
  responders and 8 non-responders it cannot.
- **Pittsburgh disagrees with Sheba** → reported without interpretation.
  Timepoint, handling and response definition all differ, and this design cannot
  separate them.

The power position is stated in advance: at Sheba's size, effects of the
magnitude reported in the landmark trials would be detected some but not most of
the time, so a null result bounds rather than refutes them.

---

## What is not being done

No classifier, no strain-level analysis, no post-translational modification
search. The first is precluded by sample size, the others are new analysis
families that would need their own correction and are outside this manuscript.
