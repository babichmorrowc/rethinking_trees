# Rethinking Trees: RGGS-AMNH Workshop
**Marcelo Gehara & Jose Padial**

## History

### 18th - 19th centuries

+ Linnaeus: started comprehensive classification of species
+ Lamarck: classification reflects a natural order, not just arbitrary human decisions
  + Species have primitive and derived characteristics
+ Cuvier: proposed the idea of extinction
+ Darwin: drawings of trees, showing extinct species
+ Haeckel: artist who depicted trees, teleological idea of "progressing" towards humans

### The Modern Synthesis

+ Genetics being made more rigorous
+ Trees no longer as common - no one knew how to build a tree rigorously (mathematically)
  + Focusing on the future, rather than history
+ Variation is discrete because gaps exist and hierarchical because groups are nested
+ Horizontal vs. hierarchical classifications
  + Horizontal = analogy (phenetic)
  + Vertical = homology (phylogenetic, natural)
+ Species are discrete entities

### German Naturalists

+ Tradition of working on comparative anatomy
+ Henning developed method to make trees (1950) - empirical tree thinking begins
  + Possible to refute a tree using evidence
+ Need to move from organisms -> characters -> species -> relationships/phylogeny
  + Idea of semaphorant: voucher specimen at a specific life stage
+ Tokogenetic (population) level relationships can be observed
  + Species-level relationships (phylogeny) must be inferred
+ Hennig auxiliary principle: states that are shared should be considered evidence of kinship
  + Assume homology first
+ Synapomorphy: trait shared in species that originated in most recent common ancestor
+ Symplesiomorphy: trait present in distant ancestor and retained in some decendant clades
+ Adding more and more characters to a tree helps identify homoplasy (false homology)

### The Fight for Methods: 60's-70's

**Phenetics**

+ Raw similarity requires no assumptions about homology
+ Evolutionary rates nearly constant and raw similarity reflects ancestry
+ Used mathematic measurements of distance
+ Criticism - cannot deal with homoplasy

**Cladistics**

+ Explains difference as result of change, regardless of the rate of change
+ Explains similarity as parallelism, convergence, or inheritance

### The Fight for Methods: 70's to today

+ What phylogenies are more scientific? How do we choose the best tree?
+ Karl Popper's critique of induction - turkey problem
+ The hypothesis that minimizes independent origin of traits minimize ad hoc hypotheses
+ Parsimony minimizes ad hoc hypotheses of character change

## Methodology

+ Optimality search criterion
  + Maximum parsimony
  + Maximum likelihood
  + Bayesian inference
  + Fitch-Margoliash
+ Clustering
  + UPGMA
  + Neighbor-joining
  
### Maximum Likelihood

Maximum likelihood function maximizes the probability of finding the data when the parameters - tree topology and branch length - are given.

### Bayesian Inference

Often there are many trees with very similar likelihood values. Bayesian inference allows you to sample from high likelihood trees, which allows you to calculate the posterior probability of a node.

## The Coalescent Model

Assumptions:
+ Discrete non-overlapping generations
+ Every individual has the same chance of reproducing - no selection, neutral model
+ Constant population size

P(2 individuals having the same parent) = 1/N, where N is the number of potential parents

P(2 individuals having the same gene copies) = 1/N', where N' is the number of gene copies
  
  In a diploid population, P(2 individuals having the same gene copies) = 1/N
  
Population process in time has a tree-like structure since there is always the possibility that two individuals shared a parent somewhere in the past. The coalescent model describes the probability of two individuals finding a common ancestor in the past.

P(2 individuals do NOT coalesce) = (1-1/N)^g, where g is the number of generations in the past

You can use your gene trees to estimate the population size. If there are more genes, there are more possibilities of coalescence.

P(2 individuals have the same parent) = 1/N * 1/N * N * kC2 = 1/N * 1/N * N * k!/\[2!(k-2)!\] = k(k-1)/2N, where k is the number of different alleles

A coalescent event reduces the number of alleles in the population, which in turn reduces the probability of coalescence in the previous generations. This property of the model means that coalescent trees are top-heavy. Thus, you only need a few alleles to estimate the deep nodes of the gene trees.
