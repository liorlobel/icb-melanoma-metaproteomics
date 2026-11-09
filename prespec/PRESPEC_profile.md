# Pre-specification: does the set-level profile replicate across cohorts?

**Written 28 September 2026, before the analysis was run.**

## Why ask this instead of the question already asked

The second cohort's pre-specified test asks one question of eight non-responders
and is underpowered by construction: at that size it recovers the discovery
effect about one run in three. A null from it bounds the effect and settles
nothing, which is what the manuscript already says.

But the same analysis produces a **score for every set in the family, in both
cohorts**. Asking whether those two vectors correspond uses thirty paired values
instead of one, and it asks a different question: not whether a particular set
reaches significance twice, but whether the *shape* of the response-associated
profile is the same in both cohorts.

That is a more honest use of a 35-patient cohort than asking it to reproduce a
single set-level p-value, and it is one test rather than thirty.

## What is computed

For every set scored in both cohorts, the observed enrichment score in each.
Sets missing from either cohort are dropped and the number is reported. The
statistic is the Spearman correlation between the two score vectors.

## The null

The sets are nested, overlap in membership, and partly partition the proteome, so
the scores within a cohort are not independent. A correlation p-value computed on
the assumption that they are would be wrong, probably badly.

**The null first specified here was not feasible and has been replaced.** It
shuffled response within plex in the second cohort and recomputed that cohort's
scores, 2,000 times. That cohort's score vector comes from a model fitted feature
by feature over thousands of features; 2,000 refits is hours to days, not
minutes. Running fifty draws and calling the result a permutation null would have
been worse than not running it.

What is done instead addresses the objection directly rather than by brute force.
Sets with identical membership are collapsed to one, so the most severe form of
dependence is removed, and the correlation is computed on the distinct sets. The
null then permutes which second-cohort score pairs with which first-cohort score,
breaking the correspondence while preserving both vectors' distributions.

**What that still assumes, stated plainly.** Collapsing identical sets does not
make the remainder independent: sets can overlap heavily without being identical,
and a label permutation treats them as exchangeable. The resulting p is
approximate, is reported as approximate, and must not be described as a
within-plex permutation. It is a weaker null than the one originally specified,
and the change is recorded here rather than presented as the original plan.

## What this cannot show, stated before the result

**The same set name does not mean the same proteins.** Each cohort's analysis
universe is defined by what its own search detected, and two chaperones account
for 84.3% of the second cohort's chaperone measurements against 51.5% of the
first cohort's. The correlation compares the same functional categories measured
on partly different proteins. That is a limitation of any cross-cohort set-level
comparison here, not a flaw in this one, but it means a positive result says the
functional profile corresponds, not that the same proteins behave the same way.

**It is not independent of the per-set test.** The chaperone and ribosomal sets
are in the vector, and they are the sets the discovery cohort selected. A
positive correlation driven entirely by those two would be close to circular. The
analysis is therefore repeated with the reported sets removed, and both values
are given. The value with them removed is the one that bears on replication.

## Power, computed before the run

Thirty sets, twenty-four after the reported ones are removed, is not many paired
values. Simulated at that size, the test detects a profile whose shape is 70%
shared between cohorts about seven times in ten, and one 50% shared about three
times in ten. It is therefore a test for a strongly corresponding profile, and a
null does not exclude a moderate correspondence. That is stated here so the null,
if it comes, is read correctly rather than as evidence of no replication.

## Reading rules, fixed here

- **Correlation positive and surviving removal of the reported sets** — the
  response-associated profile has the same shape in both cohorts, across sets
  that were not selected on either. This is the strongest replication statement
  the second cohort can support, and it is reported as a statement about profile
  shape, not about any individual set.
- **Positive only with the reported sets included** — circular, and reported as
  uninformative rather than as support.
- **Null** — the profile does not correspond. The second cohort fails to
  reproduce the first at the only resolution where it has the numbers to try.
  Reported plainly; it would weaken the paper's framing and must not be omitted
  for that reason.
- **Negative** — reported, and the cross-cohort framing is reconsidered.

## Outcome, recorded 28 September

Run against the pre-specified primary once it was located: 29 sets scored in both
cohorts, ρ = −0.018 across the 27 with distinct membership, and ρ = −0.374 across
the 22 remaining once the reported sets are removed. Approximate P = 0.94 against
the positive direction, roughly 0.12 two-sided. No correspondence, and if
anything a lean the other way.

**The test was uninformative by construction and the fault is in its design, not
in the cohorts.** Removing the reported sets was meant to prevent circularity. But
in the discovery cohort those are the sets carrying the signal; what remains is 22
sets that showed nothing there, correlated against 22 sets in the second cohort.
Correlating noise against noise has nothing to detect, and |ρ| of 0.374 arises
from pure noise at n = 22 about nine times in a hundred — the observed value is
close to the 90th percentile of chance.

The guard against circularity removed exactly what the test needed. There is no
version of this analysis that escapes that, because in the discovery cohort the
sets with signal and the sets that were reported are the same sets. The result is
therefore recorded as an attempted analysis that cannot bear weight either way,
and the manuscript's claims about the second cohort are unchanged by it.

## Multiplicity

One statistic, with one sensitivity (reported sets removed). This does not enter
the 502-set family: it is a single correlation over sets, not a search across
them.
