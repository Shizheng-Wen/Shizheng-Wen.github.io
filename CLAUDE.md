# CLAUDE.md

Guidance for Claude Code when maintaining this repository.

## What this repo is

The personal academic homepage of **Shizheng Wen**, served by **GitHub Pages** at
<https://shizheng-wen.github.io> from the **`main`** branch, **`/ (root)`** folder.

It is a **single-page static site**: one hand-maintained `index.html` (inline CSS/JS) plus the
self-hosted font files in `fonts/`. There is **no build step** for the website — GitHub Pages
serves the files as-is (a `.nojekyll` file disables Jekyll processing).

The page was first generated with [pageclaw](https://github.com/XY-Showing/pageclaw) and then
redesigned by hand in Nov 2026 (see "Design" below). `docs/plans/` describes the original
pageclaw design, not the current one.

The previous al-folio Jekyll site is preserved on the **`al-folio-backup`** branch.

## Key files

| File | Role |
|------|------|
| `index.html` | **The live web page.** Self-contained (inline CSS/JS). This is what visitors see. |
| `page-story.md` | The **source/brief** the page was generated from. Not served as the page; keep it in sync with `index.html` as the human-readable record. |
| `avatar.jpeg` | Profile photo, referenced by `index.html` as `avatar.jpeg` (must stay at root). |
| `fonts/` | Hanken Grotesk variable font (latin + latin-ext `.woff2`, SIL OFL), loaded by `@font-face` in `index.html`. Self-hosted on purpose: the page makes no third-party requests. |
| `shizheng-wen-cv.tex` | LaTeX source of the CV. |
| `shizheng-wen-cv.pdf` | Compiled CV, kept in the repo (no longer linked from the website). |
| `Makefile` | `make` compiles the `.tex` → `.pdf`; `make clean` removes LaTeX aux files. |
| `docs/plans/` | Notes from the original pageclaw generation (historical; superseded by the Nov 2026 redesign). |

> `index.html` is the source of truth for what is live. Editing `page-story.md`
> alone does **not** change the website. For small edits, edit `index.html` directly
> (and mirror the change into `page-story.md`). Do **not** re-run `/page-claw` for a
> content change — it regenerates `index.html` from scratch and would discard the current design.

## Standard workflow

When the user describes a change in natural language:

1. **Edit the relevant file(s):**
   - Website content (About, News, Publications, Awards, Talks, Teaching, Service) → edit
     **`index.html`**, then mirror the same change into **`page-story.md`** so the
     two stay consistent.
   - CV / resume content → edit **`shizheng-wen-cv.tex`**.
   - If a change is both on the site and in the CV (e.g. a new paper, a venue update,
     contact info), update **all** of `index.html`, `page-story.md`, and the `.tex`.

2. **If `shizheng-wen-cv.tex` was changed, rebuild the PDF:**
   ```bash
   make          # compile shizheng-wen-cv.tex -> shizheng-wen-cv.pdf (pdfLaTeX, runs twice)
   make clean    # remove *.aux/*.log/etc. (keeps the .pdf)
   ```
   Commit the updated `shizheng-wen-cv.pdf` together with the `.tex`. (Aux files are
   git-ignored, but run `make clean` anyway to keep the tree tidy.)

3. **Commit and push:**
   ```bash
   git add -A
   git commit -m "<concise message>"
   git push origin main
   ```
   End commit messages with:
   `Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>`

   Pushing to `main` makes the change live within ~1–2 minutes (no Action runs;
   Pages serves `main` directly).

## index.html structure reference

Each section is `<section id="..." class="page-section">` wrapping a `.section-grid` with two
children: `.section-side` (the `<h2 class="section-heading">`, shown in the left gutter on wide
screens) and `.section-body` (the content). Section ids: `about`, `news`, `publications`,
`awards`, `talks`, `teaching`, `service`. The hero above them (`<header class="hero" id="top">`)
holds the name, a one-line research thesis (`.hero-lead`), the affiliation sentence
(`.hero-affil`), and the contact links. In About, the research stack is `<ul class="directions">`:
one `<li><strong>Label</strong><p>…</p></li>` per layer, with `class="directions-goal"` on the
foundation-model row.

**News** — `<ul class="timeline" id="news-list">` of `<li class="timeline-item">`,
reverse-chronological. The newest 6 are shown; a script adds a "Show N earlier items" button
for the rest, so just prepend new items. Each item:
```html
<li class="timeline-item">
  <span class="tl-date">May 2026</span>
  <span class="tl-badge tl-green">Publication</span>
  <div class="tl-content">
    One paper "<a class="clink" href="..." target="_blank" rel="noopener noreferrer">name</a>" accepted at <strong>Venue Year</strong>.
  </div>
</li>
```
Badge class and label by item type: `tl-green` + `Publication`, `tl-amber` + `Milestone`,
`tl-blue` + `Release`. Venue names are bolded with `<strong>…</strong>` (no link),
e.g. `<strong>NeurIPS 2025</strong>`.

**Invited Talks** — same `timeline-item` rows, without a badge, newest first:
```html
<li class="timeline-item">
  <span class="tl-date">Nov 2026</span>
  <div class="tl-content">
    <span class="tl-talk-title">Talk title</span>
    <span class="tl-venue">University, hosted by Host Name.</span>
  </div>
</li>
```

**Publications** — `<ol class="pub-list">` of `<li class="pub-item">` with
`pub-title`, `pub-authors` (own name wrapped in `<span class="me">`, equal-contribution
marked with `<sup>*</sup>`), and a `pub-meta` row holding an optional
`<span class="pub-venue">…</span>` followed by `<a class="pub-link">` links (no separator
elements; spacing comes from CSS).
Each `pub-item` carries `data-tags` (space-separated: `featured`, `neural-operator`,
`solver`, `application`) used by the filter buttons above the list; the page shows
**Featured** by default. Give every new paper at least one category tag (and `featured`
if it should appear by default), and record the tags in `page-story.md`.

**Awards** — `<li>Award name <span class="award-year">2026</span></li>` in `.award-list`.

## Design

Keep these when editing, so the page stays one system:

- **Palette** lives in the `:root` / `:root[data-theme="dark"]` custom properties at the top
  of the `<style>` block: `--paper`, `--ink`, `--muted`, `--rule`, plus `--cool` / `--warm`.
  The page is ink on paper; colour is reserved for the hero field and tiny status dots.
  Links are ink with a quiet underline and turn `--cool` on hover.
- **Type** is one family, Hanken Grotesk, at a few weights (400 / 500 / 600). No second typeface.
- **Layout** is a two-column grid per section (heading gutter + content) that collapses to
  one column below 900px. Rows are separated by 1px `--rule` lines, not cards or boxes.
- **Hero field** — the `<canvas id="field">` is a live simulation, not decoration: a damped
  wave equation on a structured triangular mesh (P1 finite elements, lumped mass, explicit
  time stepping), coloured with ParaView's cool-to-warm map. The script is the last block in
  `index.html`; it pauses off-screen, and shows a single still frame under
  `prefers-reduced-motion`. The caption `#field-note` says what it is; keep the two in sync.
- Light/dark theme follows the system setting, with a toggle stored in `localStorage`.

## Conventions

- Equal contribution: `<sup>*</sup>` in HTML, `\eq` macro in LaTeX.
- Own name highlighted: `<span class="me">` in HTML, `\me{…}` in LaTeX.
- Prefer arXiv `…/abs/…` URLs (not `…/pdf/…`).
- Skip `.DS_Store`; it is git-ignored.
