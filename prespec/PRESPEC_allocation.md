# Pre-specification: what is displaced, and who assembles it

**Written 28 September 2026, before either analysis was run. Both are post hoc**
in the sense that matters: the protein state was found first and these questions
were asked of it afterwards. They are declared as such wherever they are
reported, and neither is presented as confirming the original observation.

---

## B19 — what the chaperone increase trades against

### Why

A per-sample share is compositional. Chaperones at 10.9% against 9.7% means
something else is 1.2 percentage points lower in non-responders, and the
manuscript has never said what. It reports the sets that are higher in
non-responders and is silent on the sets that are higher in responders, which is
reading half of a measurement.

If what is displaced is coherent — one functional class, or a few related ones —
the claim changes from "non-responders carry more chaperone" to a statement about
how a fixed protein budget is allocated. That is a stronger and more mechanistic
claim from numbers already computed.

### What is tested

Nothing new is computed. The existing 30-set observed enrichment table is read in
both directions: the sets with negative scores, already reported, and the sets
with positive scores, not reported. The question is whether the positive side is
coherent or scattered.

### Reading rules, fixed here

- **Coherent** — the displaced sets fall in one or a few related functional
  classes. Reported as an allocation trade-off, with the classes named.
- **Scattered** — no pattern on the positive side. Reported as such, and the
  allocation framing is dropped rather than argued for.

Significance is not claimed for the positive side. These sets were not
pre-specified, they sit in the same 502-set family that yields nothing after
correction, and the point is the pattern, not a p-value for any member of it.

---

## B20 — is the state assembled from the same organisms in every patient?

### Why this is the question

The manuscript shows that no single genus carries the chaperone difference:
removing any one leaves it essentially unchanged. That rules out one organism
being essential. It does not ask whether patient A's chaperone excess comes from
the same organisms as patient B's.

If it does not, the claim becomes that the response-associated state is a
**functional** state rather than a taxonomic one — the same functional shift
assembled from different organisms in different patients. Three things follow.
Gene abundance is indexed by taxon, so a signal that is not taxonomically
consistent is invisible to it, which would explain the paper's central asymmetry
rather than merely restating it. The response finding becomes a consequence of
the functional redundancy established in the coupling analysis, rather than a
second and unrelated observation. And the argument for measuring protein stops
being an argument about sensitivity and becomes one about what the two layers are
indexed by.

### What is tested

For each patient and each genus, the genus's contribution to that patient's
chaperone share. That gives one vector per patient over genera.

**Two statistics, because one will not do.** The first design used only the
between-patient correlation of those vectors. Simulation at this data's shape
showed it cannot distinguish the claim from noise: "a different genus in each
patient" gives +0.011 and "no genus dominates anywhere" gives −0.016. The
discriminating quantity is within-patient concentration.

- **Top-contributor share** — how much of the set one genus supplies in a given
  patient. High when the state is concentrated, whether or not the same organism
  supplies it each time; low when nothing dominates.
- **Modal top** — how often the *same* genus is the top contributor across
  patients. High when one organism carries the set everywhere; low when
  different organisms do.

Simulated at this shape: one genus everywhere gives 0.77 and 100%; a different
genus per patient gives 0.77 and 10%; no structure gives 0.08 and 10%. Only the
pair identifies the claim, so only the pair is reported. The pairwise correlation
is reported alongside for completeness and is not the basis of any statement.

### The control is internal, and it is what makes this interpretable

The same procedure is run on the ribosomal set. The ribosomal difference is
already known to localise to a single genus and not to survive its removal, so
its contribution vectors should be **consistent** between patients. The chaperone
vectors, if the functional-state reading is right, should be **less** so.

A low correlation on its own could mean anything — sparse data, noise, few
genera. The comparison against a set measured in the same samples, by the same
procedure, with a known taxonomic structure, is what gives it meaning. The
prediction is fixed here: **the chaperone state is concentrated within each
patient but supplied by different organisms in different patients, while the
ribosomal state is supplied by the same organism throughout.** In the two
statistics: comparable top-contributor share, and a markedly lower modal-top
frequency for chaperones than for ribosomes.

### Reading rules, fixed here

- **Chaperones concentrated but on a different organism each time, ribosomes on
  the same one** — the chaperone state is assembled from different organisms in
  different patients while the ribosomal one is not. This supports the
  functional-state reading and is reported as the explanation the paper offers
  for why gene abundance misses the state.
- **Modal-top frequencies indistinguishable** — no support for the reading.
  Reported, and the explanation is not offered.
- **Chaperone top-contributor share low** — the set is not concentrated in any
  patient, so the "different organism each time" reading does not apply and the
  low modal-top frequency means only that nothing dominates. Reported as a null.
- **Chaperone modal-top above ribosomal** — the opposite of the prediction.
  Reported, and the functional-state reading is abandoned rather than reworded.

### What this cannot show

It is correlational and within one cohort. It cannot establish that taxonomic
variability is the *reason* the metagenome misses the state, only that the state
has the property which would produce that result. The distinction is kept in the
wording wherever this is reported.

Confidence intervals are bootstrap over patients. No p-value is attached to the
chaperone-minus-ribosomal difference: the two sets differ in size, in sparsity
and in how many genera carry them, so a formal test would compare quantities that
are not exchangeable. The interval is reported and the comparison is described,
not tested.
