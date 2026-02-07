
# Multi-File Slides

Split long decks into separate files using `src:` imports

```md
---
src: ./pages/intro.md
---

---
src: ./pages/details.md
---

---
src: ./pages/conclusion.md#2,5-7
---
```

<v-clicks>

- Each file is a standalone `.md` with its own slides
- Import all slides or pick specific ones with `#2,5-7`
- Main entry frontmatter overrides imported frontmatter
- Reuse the same file in multiple places

</v-clicks>

<!--
This slide itself is imported from pages/multi-file.md to demonstrate the feature.
You can split large presentations into logical sections, each in its own file.
-->
