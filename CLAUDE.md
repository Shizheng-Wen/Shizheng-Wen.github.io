# CLAUDE.md

Guidance for Claude Code when maintaining this repository.

## What this repo is

The personal academic homepage of **Shizheng Wen**, served by **GitHub Pages** at
<https://shizheng-wen.github.io> from the **`main`** branch, **`/ (root)`** folder.

It is a **single-file static site** generated with [pageclaw](https://github.com/XY-Showing/pageclaw).
There is **no build step** for the website — GitHub Pages serves the files as-is
(a `.nojekyll` file disables Jekyll processing).

The previous al-folio Jekyll site is preserved on the **`al-folio-backup`** branch.

## Key files

| File | Role |
|------|------|
| `index.html` | **The live web page.** Self-contained (inline CSS/JS). This is what visitors see. |
| `page-story.md` | The **source/brief** the page was generated from. Not served as the page; keep it in sync with `index.html` as the human-readable record. |
| `avatar.jpeg` | Profile photo, referenced by `index.html` as `avatar.jpeg` (must stay at root). |
| `shizheng-wen-cv.tex` | LaTeX source of the CV. |
| `shizheng-wen-cv.pdf` | Compiled CV — this is the file the website's "CV/Resume" link points to (must stay at root). |
| `Makefile` | `make` compiles the `.tex` → `.pdf`; `make clean` removes LaTeX aux files. |
| `docs/plans/` | pageclaw design + implementation notes (reference only). |

> `index.html` is the source of truth for what is live. Editing `page-story.md`
> alone does **not** change the website. For small edits, edit `index.html` directly
> (and mirror the change into `page-story.md`). Do **not** re-run `/page-claw` for a
> small content change — it regenerates `index.html` from scratch and can alter the design.

## Standard workflow

When the user describes a change in natural language:

1. **Edit the relevant file(s):**
   - Website content (About, News, Publications, Awards, Talks, Teaching) → edit
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

Sections are `<section id="...">` with an `<h2 class="section-heading">`:
`about`, `news`, `publications`, `awards`, `talks`, `teaching`.

**News** — a `<ul>` of `<li class="timeline-item">`, reverse-chronological. Each item:
```html
<li class="timeline-item">
  <span class="tl-badge tl-green" role="img" aria-label="Publication"></span>
  <div class="tl-content">
    <span class="tl-date">May 2026</span>
    One paper "<a class="clink" href="..." ...>name</a>" accepted at <strong>Venue Year</strong>.
  </div>
</li>
```
Badge color by item type: `tl-green` = Publication, `tl-amber` = Milestone,
`tl-blue` = Release / Talk. Venue names are bolded with `<strong>…</strong>`
(no link), e.g. `<strong>NeurIPS 2025</strong>`.

**Publications** — `<ol class="pub-list">` of `<li class="pub-item">` with
`pub-title`, `pub-authors` (own name wrapped in `<span class="me">`, equal-contribution
marked with `<sup>*</sup>`), and a `pub-meta` row holding an optional
`<span class="pub-venue">…</span>`, then `<a class="pub-link">` links separated by
`<span class="pub-sep">·</span>`.

## Conventions

- Equal contribution: `<sup>*</sup>` in HTML, `\eq` macro in LaTeX.
- Own name highlighted: `<span class="me">` in HTML, `\me{…}` in LaTeX.
- Prefer arXiv `…/abs/…` URLs (not `…/pdf/…`).
- Skip `.DS_Store`; it is git-ignored.
