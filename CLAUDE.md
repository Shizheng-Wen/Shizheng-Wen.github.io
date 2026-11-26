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

- **Nav** (`#site-nav`, sticky): `.nav-brand` (name, fades in once the hero identity row has
  scrolled away), `.nav-links`, the theme toggle, and `#read-progress`, a thin reading-progress
  line along the bottom edge.

- **Hero** (`<header class="hero" id="top">`), two columns. Left: `.id` (avatar, name as the
  `<h1>`, status label), the `.tagline` (the accent-coloured half is `<span class="tone">`),
  the `.lede` paragraph (key terms in `<b>`), `.cta` (`.cta-actions` with the email button and
  the `#copy-email` button, then `.social` links), and the `.facts` list
  (`<dt class="label">` / `<dd>` pairs: Based at, Open source, Recognition).
  Right: `#field-panel`, which has two views switched by `#view-switch` (Research / Simulation):
  - **Research** (`#research-view`, the default): the research map, an SVG built by the
    "Research map" script block, with a detail area below it and the caption `.cap-research`.
  - **Simulation** (`data-view="field"` in the code): inside `#field-frame` sit the canvas, a
    mesh readout (`#field-readout`, filled by the script) and the control bar `.field-hud-bar`
    (Drops / Plane modes, Pulse, pause, reset); caption `.cap-field` with `#field-note`.
- **Selected work** (`#work`): `.work-grid` of four `.work-card`s covering the stack:
  GAOT, TensorMesh, torch-sla, Preconditioned PINO (in that order).
- **News** (`#news`) and **Invited talks** (`#talks`), side by side. Both lists carry the
  `scroll-list` class: the same fixed height, scrolling inside it to reach older items. Each
  heading sits in a `.col-head` with a `.list-toggle` button ("All (N)" / "Collapse", labelled
  by the script) that expands the list to full height.
- **Publications** (`#publications`), a two-column list with filter buttons in the heading row.
  The script adds, for every paper: the count on each filter button, a highlight on main-track
  NeurIPS / ICML / ICLR venues (`.pub-venue.is-top`), and a "BibTeX" link that opens a
  copyable entry.
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

The BibTeX entry is **generated from this markup** by `buildBibTeX()` in the script, so the
markup has to stay regular:
- authors separated by commas (a final "and" is fine), `<sup>*</sup>` for equal contribution;
- venue written as `Conf YYYY` (e.g. `NeurIPS 2025`), `Conf YYYY Workshop (Name)`,
  `arXiv preprint, YYYY`, or `Journal Name, YYYY`;
- an `arxiv.org/abs/…` and/or `doi.org/…` link among the `pub-link`s.
The generated entry has no pages or volume, and the title is double-braced to keep its
capitalisation. After adding a paper, open its BibTeX on the page and check it reads right.

**Awards** — `<li>Award name <span class="award-year">2026</span></li>` in `.award-list`.

## Design

Keep these when editing, so the page stays one system:

- **Dense and short.** The whole page is about three screens. Small type (14–16px body), tight
  rows, a 70rem container. Prefer trimming copy to adding sections.
- **Palette** lives in the `:root` (dark) and `:root[data-theme="light"]` (light, the default) custom
  properties: `--paper`, `--panel`, `--ink`, `--muted`, `--faint`, `--rule`, and one accent,
  `--cool`. `--warm` is only for the field and the status / milestone markers.
- **Type**: Hanken Grotesk for text and headings (400 / 600); DM Mono, small, uppercase and
  letter-spaced (class `label`), for metadata: dates, venues, link rows, nav.
- **Rules, not boxes**: rows are separated by 1px `--rule` lines. The only framed elements are
  the field panel, the work thumbnails and an open BibTeX drawer. List rows (news, talks,
  publications, awards, teaching) get a faint `--panel-hover` background on hover; they use a
  small negative side margin for that, so their rules run slightly wider than the headings.
- **Motion**: the hero text and field panel rise in once on load; each `.block` carrying the
  `reveal` class fades in the first time it scrolls into view (give new blocks that class);
  publication rows animate when the filter changes. All of it is switched off under
  `prefers-reduced-motion`, and nothing is hidden when JavaScript is unavailable.
- **Hero field** — the `<canvas id="field">` is a live simulation, not decoration: a damped
  wave equation on a structured triangular mesh (P1 finite elements, lumped mass, explicit
  time stepping), coloured with a cool-to-warm map. The nodes under the initials "SW"
  (`INITIALS` in the script) are clamped and drawn in the accent colour, so the waves scatter
  off them. Two modes: **Drops** (point disturbances; the default) and **Plane** (a harmonic
  source along the left edge, with a damping layer on the right, so a plane wave diffracts
  around the letters). Clicking or moving over the panel adds disturbances; the control bar
  can pulse, pause and reset. The script is the last block in `index.html`; it pauses
  off-screen, and under `prefers-reduced-motion` shows a single still frame and hides the
  controls. The caption `#field-note` is rewritten by `updateNote()` per mode; keep its
  wording true to what the simulation does.
- **Research map** — research drawn as one linear finite element. The three nodes are the
  layers (infrastructure, architecture, training); each project is a point inside, placed by
  barycentric weights `w: [infrastructure, architecture, training]` in the `ITEMS` array of the
  script; the foundation model sits at the centroid. The element is shaded by blending one
  colour per node (`--rm-a`, `--rm-b`, `--rm-c`, set per theme) across its cells, and the view
  has a soft wash in the same three colours behind it. Hover or focus previews an item, click or
  tap pins it; a layer dims projects that barely draw on it, a project draws ties to the three
  nodes weighted by `w`. To add a project, add an entry to `ITEMS` (name, weights summing to 1,
  one sentence, link, label offset) and check its label does not collide with a neighbour. The
  weights are a qualitative placement chosen with Shizheng, not measurements; change them only
  on his say. This is the view the page opens on; the simulation stays paused until the
  visitor switches to it.
- Light is the default theme; the toggle stores the visitor's choice in `localStorage`. In light
  mode the page background is a soft cool-to-warm gradient wash behind the top of the page
  (`:root[data-theme="light"] body`), fading into flat `--paper`; dark mode stays flat.

## Conventions

- This repo is also edited outside these sessions (e.g. from an IDE agent). Start by pulling
  `main`, and when a change alters the page's structure or behaviour, update this file in the
  same commit so the next session reads an accurate description.
- Equal contribution: `<sup>*</sup>` in HTML, `\eq` macro in LaTeX.
- Own name highlighted: `<span class="me">` in HTML, `\me{…}` in LaTeX.
- Prefer arXiv `…/abs/…` URLs (not `…/pdf/…`).
- Skip `.DS_Store`; it is git-ignored.
