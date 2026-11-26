# CLAUDE.md

Guidance for Claude Code when maintaining this repository.

## What this repo is

The personal academic homepage of **Shizheng Wen**, served by **GitHub Pages** at
<https://shizheng-wen.github.io> from the **`main`** branch, **`/ (root)`** folder.

It is a **single-page static site**: one hand-maintained `index.html` (inline CSS/JS) plus the
self-hosted font files in `fonts/` and the project thumbnails in `media/`. There is **no build step** for the website — GitHub Pages
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
| `fonts/` | Hanken Grotesk (variable, latin + latin-ext) and DM Mono 400 (`.woff2`, SIL OFL), loaded by `@font-face` in `index.html`. Self-hosted on purpose: the page makes no third-party requests. |
| `media/` | 800×500 (16:10) thumbnails for the "Selected work" cards: `gaot.jpg` (DrivAerML flow visualization), `tensormesh.jpg` and `torch-sla.jpg` (project logos on white), `pino.svg` (a drawn multigrid V-cycle: an oscillatory field on a fine mesh, restricted to coarser meshes and prolonged back smooth). |
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

The page is a compact, pitch-style single page. Top to bottom:

- **Hero** (`<header class="hero" id="top">`), two columns. Left: `.id` (avatar, name as the
  `<h1>`, status label), the `.tagline` (the accent-coloured half is `<span class="tone">`),
  the `.lede` paragraph (key terms in `<b>`), `.cta` (email button + `.social` links), and the
  `.facts` list (`<dt class="label">` / `<dd>` pairs: Based at, Open source, Recognition).
  Right: `#field-panel`, the live simulation with its caption `#field-note`.
- **Selected work** (`#work`): `.work-grid` of four `.work-card`s covering the stack:
  GAOT, TensorMesh, torch-sla, Preconditioned PINO (in that order).
- **News** (`#news`) and **Invited talks** (`#talks`), side by side. Both lists carry the
  `scroll-list` class: the same fixed height, scrolling inside it to reach older items.
- **Publications** (`#publications`), a two-column list with filter buttons in the heading row.
- **Awards** (`#awards`), **Teaching** (`#teaching`), **Service** (`#service`), three columns.

**Work card**
```html
<li class="work-card">
  <a class="work-media" href="..." target="_blank" rel="noopener noreferrer" tabindex="-1" aria-hidden="true"><img src="media/name.jpg" alt="" width="800" height="500" loading="lazy"></a>
  <span class="label">Layer, Venue Year</span>
  <h3 class="work-title">Name</h3>
  <p class="work-desc">One or two short sentences.</p>
  <p class="work-links"><a href="...">Project</a><a href="...">Paper</a><a href="...">Code</a></p>
</li>
```
There is no foundation-model card for now (it was swapped for torch-sla until the model is
released). When it is released, add it as the first card with a thumbnail and links, and update
the tagline/lede if needed. A not-yet-released card can use
`<div class="work-media is-upcoming"><span class="label">January 2027</span></div>` instead of an image.

**News** — `<ul class="timeline" id="news-list">` of `<li class="timeline-item">`,
reverse-chronological. The list scrolls inside a fixed height, so just prepend new items.
Each item:
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

**Invited talks** — same `timeline-item` rows, without a badge, newest first:
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
`solver`, `application`) used by the filter buttons; the page shows **Featured** by default.
Give every new paper at least one category tag (and `featured` if it should appear by
default), and record the tags in `page-story.md`.

**Awards** — `<li>Award name <span class="award-year">2026</span></li>` in `.award-list`.

## Design

Keep these when editing, so the page stays one system:

- **Dense and short.** The whole page is about three screens. Small type (14–16px body), tight
  rows, a 70rem container. Prefer trimming copy to adding sections.
- **Palette** lives in the `:root` (dark, the default) and `:root[data-theme="light"]` custom
  properties: `--paper`, `--panel`, `--ink`, `--muted`, `--faint`, `--rule`, and one accent,
  `--cool`. `--warm` is only for the field and the status / milestone markers.
- **Type**: Hanken Grotesk for text and headings (400 / 600); DM Mono, small, uppercase and
  letter-spaced (class `label`), for metadata: dates, venues, link rows, nav.
- **Rules, not boxes**: rows are separated by 1px `--rule` lines. The only framed elements are
  the field panel and the work thumbnails.
- **Hero field** — the `<canvas id="field">` is a live simulation, not decoration: a damped
  wave equation on a structured triangular mesh (P1 finite elements, lumped mass, explicit
  time stepping), coloured with a cool-to-warm map. The nodes under the initials "SW"
  (`INITIALS` in the script) are clamped and drawn in the accent colour, so the waves scatter
  off them. The script is the last block in
  `index.html`; it pauses off-screen, and shows a single still frame under
  `prefers-reduced-motion`. The caption `#field-note` says what it is; keep the two in sync.
- Dark is the default theme; the toggle stores the visitor's choice in `localStorage`.

## Conventions

- Equal contribution: `<sup>*</sup>` in HTML, `\eq` macro in LaTeX.
- Own name highlighted: `<span class="me">` in HTML, `\me{…}` in LaTeX.
- Prefer arXiv `…/abs/…` URLs (not `…/pdf/…`).
- Skip `.DS_Store`; it is git-ignored.
