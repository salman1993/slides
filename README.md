# slides

Presentation decks built with [Slidev](https://sli.dev). Each subdirectory is an independent slide deck.

Want to use this template? Just copy the `example/` directory and you're good to go.

## Decks

### [Strong Baselines for Simple QA over Knowledge Graphs](strong-baselines-simple-qa/)

Paper: [Mohammed, Shi, Lin — NAACL-HLT 2018](https://aclanthology.org/N18-2047.pdf)

See [this Amp thread](https://ampcode.com/threads/T-019c35b7-e79c-7300-b270-41ea7e5ed723) on how this deck was made from a single prompt:

```
read this PDF — https://aclanthology.org/N18-2047.pdf

then, make me slides for a 20 min talk. make sure <10 slides
```

## Quick Start

```bash
# create a new deck from the example template
just new my-talk

# start the dev server (hot-reload at localhost:3030)
just dev my-talk

# export to PDF
just export my-talk
```

## Structure

```
slides/
├── justfile          # task runner commands
├── example/          # template deck — copy this to start a new one
│   ├── slides.md     # slide content (markdown)
│   ├── images/       # images referenced in slides
│   └── package.json
└── my-talk/          # your deck
    └── ...
```

## Writing Slides

Slides are plain markdown separated by `---`. Each slide can have YAML frontmatter for layout and styling. See `example/slides.md` for a demo of:

- Code blocks with syntax highlighting and line highlighting
- LaTeX / KaTeX math expressions
- Images and backgrounds
- UnoCSS styling (colors, fonts, spacing)
- Mermaid diagrams
- Animated fragments
- Multi-column layouts

Full syntax guide: https://sli.dev/guide/syntax

## Requirements

- [Node.js](https://nodejs.org/) >= 18
- [Bun](https://bun.sh/) (or npm/pnpm)
- [just](https://github.com/casey/just) (optional, for task runner)
