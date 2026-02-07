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

    style Q fill:#1a1a2e,stroke:#4f46e5,color:#e2e8f0
    style ED fill:#1a1a2e,stroke:#06b6d4,color:#e2e8f0
    style EL fill:#1a1a2e,stroke:#06b6d4,color:#e2e8f0
    style RP fill:#1a1a2e,stroke:#06b6d4,color:#e2e8f0
    style EI fill:#1a1a2e,stroke:#06b6d4,color:#e2e8f0
    style A fill:#1a1a2e,stroke:#10b981,color:#e2e8f0
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

### Neural Network Models

<v-clicks>

- **Entity Detection:** BiLSTM-CRF sequence tagger
- **Entity Linking:** Freebase lookup + Levenshtein Distance ranking
- **Relation Prediction:** BiGRU / CNN classifiers with GloVe embeddings
- Hidden size: 300, GloVe 300d, Adam optimizer

</v-clicks>

</div>
<div>

### Non-Neural Baselines

<v-clicks>

- **Entity Detection:** CRF (Stanford NER tagger)
- **Relation Prediction:**
  - Logistic Regression with **tf-idf** features
  - Logistic Regression with **GloVe + relation words**
- No deep learning required

</v-clicks>

</div>
</div>

<!--
On the neural side, we use basic LSTMs and GRUs — nothing exotic. For entity detection, a BiLSTM-CRF. For relation prediction, a BiGRU or CNN. On the non-neural side, we use a standard CRF for entity detection and logistic regression for relation prediction. These are all "Deep Learning 101" level models.
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

<div class="text-xs opacity-60 mt-2">CRF is only ~1 point behind the BiLSTM</div>

</div>
<div>

### Relation Prediction (R@N)

| Model | R@1 | R@5 |
|-------|-----|-----|
| BiGRU | 82.3 | 95.9 |
| CNN | 82.8 | 95.8 |
| LR (tf-idf) | 72.4 | 87.6 |
| LR (GloVe+rel) | 74.7 | 92.2 |
| Ture & Jojic '17 | 81.6 | — |

<div class="text-xs opacity-60 mt-2">LR with GloVe is within ~8 points of NN models</div>

</div>
</div>

<!--
Looking at individual components: for entity linking, the CRF is only about 1 point behind the BiLSTM across all recall levels. For relation prediction, basic BiGRU and CNN are comparable, and even logistic regression with GloVe features gets to 74.7 — not that far behind. The non-neural approaches are surprisingly competitive on each component.
~3 min
-->

---

# End-to-End Results

| Model | Accuracy |
|-------|----------|
| Bordes et al. 2015 (Memory Networks) | 62.7 |
| Golub & He 2016 | 70.9 |
| Lukovnikov et al. 2017 | 71.2 |
| **Ours: BiLSTM + BiGRU** | **74.9** |
| **Ours: BiLSTM + CNN** | **74.7** |
| **Ours: CRF + LR (GloVe+rel)** | **69.9** |
| **Ours: CRF + LR (tf-idf)** | **67.3** |
| Yin et al. 2016 | 68.3 |
| Yu et al. 2017 | 75.1 |
| Dai et al. 2016 | 75.7 |

<div class="text-sm mt-4 opacity-80">

Our simple BiLSTM+BiGRU baseline **approaches the state of the art** (74.9 vs 75.7). The fully NN-free baseline (67.3) **beats the original Memory Networks** result.

</div>

<!--
Here's the punchline. Our simple BiLSTM plus BiGRU achieves 74.9 accuracy, within about 1 point of the state of the art at 75.7. Even more striking: our completely neural-network-free baseline at 67.3 beats the original Memory Networks paper. The CRF + LR with GloVe gets to 69.9. This shows that sophisticated architectures provide only modest gains over strong baselines.
~3 min
-->

---

# Key Takeaways

<v-clicks>

- **Basic LSTMs/GRUs + heuristics ≈ state of the art** on SimpleQuestions
  - Gap is ~1 point, within noise of random seed variation

- **Non-neural methods are surprisingly competitive**
  - CRF + Logistic Regression beats Memory Networks (Bordes et al., 2015)

- Some published models exhibit **unnecessary complexity**
  - Attention, residual learning, hierarchical encoders yield marginal gains
  - Several complex models actually perform *worse* than our baselines

- **Practical implications:** simpler models are easier to train, deploy, and maintain
  - Sculley et al. (2014): ML solutions incur heavy technical debt
  - Netflix didn't deploy the Netflix Prize winner due to complexity

</v-clicks>

<!--
The takeaways are clear. First, basic neural architectures nearly match the state of the art. Second, non-neural methods are competitive — they beat the original baseline. Third, some published models are unnecessarily complex and even underperform our simple baselines. And practically speaking, simpler models mean lower maintenance costs, easier debugging, and faster iteration.
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
