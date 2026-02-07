# Agents

## Structure
Each subdirectory is an independent Slidev deck with its own `package.json` and `slides.md`.
`example/` is the template deck — copy it via `just new <name>` to start a new one.

## Commands
- `just dev <name>` — start dev server for a deck (hot-reload at localhost:3030)
- `just build <name>` — build deck as static SPA
- `just export <name>` — export to PDF (requires `bunx playwright install`)
- `just new <name>` — create new deck from example template
- `just install <name>` — install deps for a single deck
- `just install-all` — install deps for all decks
- Inside a deck dir: `bun run dev`, `bun run build`, `bun run export`

## Conventions
- Slides are Markdown (Slidev syntax): `---` separates slides, YAML frontmatter for config.
- Use `bun` as the package manager.
- Load the `slidev` skill (in `.agents/skills/slidev/`) for full Slidev syntax reference.
- Images go in `<deck>/images/`; reference as `/images/filename` in slides.
- Theme is set via `theme:` in the first slide's frontmatter (default: `seriph`).
- Fonts configured via `fonts:` frontmatter (`sans`, `mono`, `serif` keys).
- Always use `colorSchema: dark` for dark themed slides.
- Default font: `Work Sans` for sans, `Space Mono` for mono.
- Default primary color: `'#d4d4d8'` (cool zinc gray) via `themeConfig.primary`.

## Slide Content Guidelines
- Avoid long sentences.
- Avoid abbreviations and acronyms.
- Limit punctuation marks.
- No more than 6-8 words per line.
- For bullet points, use the 6 x 6 Rule: one thought per line with no more than 6 words per line and no more than 6 lines per slide.
