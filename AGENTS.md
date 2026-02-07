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
