---
theme: seriph
title: "Strong Baselines for Simple QA over Knowledge Graphs"
info: |
  NAACL-HLT 2018 — Mohammed, Shi, Lin
class: text-center
colorSchema: dark
themeConfig:
  primary: '#d4d4d8'
drawings:
  persist: false
transition: slide-left
mdc: true
fonts:
  sans: Work Sans
  mono: Space Mono
---

# Strong Baselines for Simple QA over Knowledge Graphs

### With and Without Neural Networks

<div class="mt-4 text-lg opacity-80">
Salman Mohammed, Peng Shi, Jimmy Lin
</div>

<div class="mt-2 text-sm opacity-60">
David R. Cheriton School of Computer Science, University of Waterloo
</div>

<div class="mt-6 text-sm opacity-50">
NAACL-HLT 2018
</div>

<!--
Welcome everyone. Today I'll present our work on establishing strong baselines for simple question answering over knowledge graphs. The key message: you don't always need complex neural architectures to get competitive results.
~2 min
-->

---

# Motivation

<v-clicks>

- Answer questions using a single fact
- SimpleQuestions is the standard benchmark
- Complex architectures, diminishing gains
- No rigorous ablation studies exist
- Goal: find the simplest model that works

</v-clicks>

<!--
Simple QA is about answering questions that map to a single fact in a knowledge graph. For example, "Where was Sasha Vujacic born?" maps to entity Sasha Vujacic and relation place_of_birth. The SimpleQuestions dataset from Bordes et al. 2015 has become the de facto benchmark.

Recent work keeps proposing more complex architectures — attention mechanisms, hierarchical encoders, residual BiLSTMs — but gains are shrinking. There's a lack of rigorous ablation studies, so it's hard to know what actually helps. We wanted to understand: how much of this complexity is actually necessary? Our goal was to peel away complexity until we arrive at the simplest model that works well.
~3 min
-->

---

# Problem Decomposition

<div class="mt-4">

```mermaid
graph LR
    Q["Question:<br/>Where was Sasha<br/>Vujacic born?"] --> ED[Entity Detection]
    ED --> EL[Entity Linking]
    EL --> RP[Relation Prediction]
    RP --> EI[Evidence Integration]
    EI --> A["Answer:<br/>Ljubljana"]

    style Q fill:#1a1a2e,stroke:#a1a1aa,color:#e4e4e7
    style ED fill:#1a1a2e,stroke:#71717a,color:#e4e4e7
    style EL fill:#1a1a2e,stroke:#71717a,color:#e4e4e7
    style RP fill:#1a1a2e,stroke:#71717a,color:#e4e4e7
    style EI fill:#1a1a2e,stroke:#71717a,color:#e4e4e7
    style A fill:#1a1a2e,stroke:#d4d4d8,color:#e4e4e7
```

</div>

<!--
We follow a straightforward four-stage decomposition that's standard in the literature.

Entity Detection identifies the entity mention span in the question. Entity Linking maps that mention to a knowledge base entity using Freebase lookups. Relation Prediction determines which relation is being asked about. Evidence Integration combines candidates from both stages to produce the final answer.

The key insight is that each of these stages can be tackled with simple models — no need for complex end-to-end architectures.
~2 min
-->

---

# Models Explored

<div class="grid grid-cols-2 gap-8 mt-4">
<div>

### Neural Models

<v-clicks>

- BiLSTM-CRF for entity detection
- BiGRU / CNN for relation prediction
- GloVe 300d word embeddings

</v-clicks>

</div>
<div>

### Non-Neural Models

<v-clicks>

- CRF for entity detection
- Logistic Regression for relations
- No deep learning required

</v-clicks>

</div>
</div>

<!--
On the neural side, we use basic architectures — nothing exotic. A BiLSTM-CRF sequence tagger for entity detection, and BiGRU or CNN classifiers for relation prediction, all with GloVe 300d embeddings. Entity linking uses Freebase lookup with Levenshtein distance ranking. Hidden size is 300, trained with Adam optimizer.

On the non-neural side, we use a standard CRF (Stanford NER tagger) for entity detection and logistic regression for relation prediction — one variant with tf-idf features and another with GloVe embeddings plus relation words. These are all "Deep Learning 101" level models at most.
~3 min
-->

---

# Component Results

<div class="grid grid-cols-2 gap-8 mt-2">
<div>

### Entity Linking (R@N)

| R@N | BiLSTM | CRF |
|-----|--------|-----|
| 1   | 67.8   | 66.6 |
| 5   | 82.6   | 81.3 |
| 20  | 88.7   | 87.4 |
| 50  | 91.0   | 89.8 |

</div>
<div>

### Relation Prediction (R@N)

| Model | R@1 | R@5 |
|-------|-----|-----|
| BiGRU | 82.3 | 95.9 |
| CNN | 82.8 | 95.8 |
| LR (tf-idf) | 72.4 | 87.6 |
| LR (GloVe+rel) | 74.7 | 92.2 |

</div>
</div>

<!--
Looking at individual components: for entity linking, the CRF is only about 1 point behind the BiLSTM across all recall levels — the difference is negligible.

For relation prediction, basic BiGRU and CNN are comparable at around 82 R@1. Even logistic regression with GloVe features gets to 74.7 — within about 8 points of the neural models. For context, Ture and Jojic 2017, a more complex model, only reached 81.6. The non-neural approaches are surprisingly competitive on each individual component.
~3 min
-->

---

# End-to-End Results

| Model | Accuracy |
|-------|----------|
| Bordes et al. 2015 | 62.7 |
| Golub and He 2016 | 70.9 |
| Lukovnikov et al. 2017 | 71.2 |
| **Ours: BiLSTM + BiGRU** | **74.9** |
| **Ours: CRF + LR (GloVe)** | **69.9** |
| Yu et al. 2017 | 75.1 |
| Dai et al. 2016 | 75.7 |

<!--
Here's the punchline. Our simple BiLSTM plus BiGRU achieves 74.9 accuracy — within about 1 point of the state of the art at 75.7 by Dai et al. Our BiLSTM + CNN variant gets 74.7, essentially the same.

Even more striking: our completely neural-network-free baseline (CRF + LR with tf-idf) at 67.3 beats the original Memory Networks result of 62.7 by Bordes et al. The CRF + LR with GloVe gets to 69.9, also beating Yin et al. 2016 at 68.3.

This shows that sophisticated architectures provide only modest gains over strong baselines. The gap between our simple neural model and state of the art is within noise of random seed variation.
~3 min
-->

---

# Key Takeaways

<v-clicks>

- Simple models nearly match state of the art
- Non-neural methods beat Memory Networks
- Many complex models add unnecessary overhead
- Simpler means easier to deploy and maintain

</v-clicks>

<!--
The takeaways are clear. First, basic neural architectures like LSTMs and GRUs nearly match the state of the art — the gap is about 1 point, within noise of random seed variation.

Second, non-neural methods are surprisingly competitive. CRF + Logistic Regression beats the original Memory Networks result from Bordes et al. 2015.

Third, some published models exhibit unnecessary complexity. Attention mechanisms, residual learning, and hierarchical encoders yield only marginal gains. Several complex models actually perform worse than our simple baselines.

And practically speaking, simpler models are easier to train, deploy, and maintain. As Sculley et al. 2014 showed, ML solutions incur heavy technical debt. Netflix famously didn't deploy the Netflix Prize winning ensemble due to its engineering complexity. The lesson: always establish strong baselines before reaching for complex architectures.
~3 min
-->

---
layout: center
class: text-center
---

# Thank You

<div class="mt-4 text-lg opacity-80">

*"Peel away complexity until you arrive at the simplest model that works well."*

</div>

<div class="mt-8 text-sm opacity-60">

Paper: [aclanthology.org/N18-2047](https://aclanthology.org/N18-2047.pdf)

Code: [github.com/castorini/BuboQA](https://github.com/castorini/BuboQA)

</div>

<!--
To wrap up: the main message is about empirical rigor. Before reaching for complex architectures, establish strong baselines first. Thank you — happy to take questions.
~1 min
-->
