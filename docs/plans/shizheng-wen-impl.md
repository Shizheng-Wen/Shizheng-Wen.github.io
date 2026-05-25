# Implementation Plan — Shizheng Wen Academic Homepage

**Spec:** `docs/plans/shizheng-wen-design.md` · **Content (authoritative):** `page-story.md`
**Deliverable:** single self-contained `index.html` at project root. Inline `<style>`, minimal vanilla JS. Local asset `avatar.jpeg` (sibling).

**Content fidelity rule:** render every page-story element in original section + order. Do not add a job-market callout or any text not in the story. Subject = "Shizheng Wen".

---

## Task 1 — Document skeleton & `<head>`
- `<!DOCTYPE html>`, `<html lang="en">`, charset, `viewport` (`width=device-width, initial-scale=1` — never disable zoom).
- `<title>Shizheng Wen — PhD Student, ETH Zurich</title>`, `<meta name="description">` from the About summary.
- Preconnect to Google Fonts; load **DM Sans** weights 400/500/600 with `display=swap`.
- Inline `<style>` block (Task 2–3). No external CSS/JS files.
- **Anti-FOUC theme init:** a tiny inline `<script>` in `<head>` that reads `localStorage.theme` (fallback `prefers-color-scheme`) and sets `data-theme` on `<html>` *before* paint.

## Task 2 — CSS tokens & theming
- `:root` light tokens from design doc (`--bg`, `--surface`, `--text`, `--text-muted`, `--border`, `--accent`, `--accent-hover`, `--nav-bg`); plus `--radius:4px`, `--max-w:780px`, `--font`, dot-badge colors (`--badge-green/blue/amber`).
- `:root[data-theme="dark"]` overrides with the warm-dark palette (verify AA: `--text` `#ece6da` on `#1c1a17`, accent `#4db8e0`).
- Base reset (`box-sizing`, margin/padding 0), `body` font `400 0.95rem/1.65 var(--font)`, smooth scroll + `scroll-padding-top:56px`, `prefers-reduced-motion` block disabling transitions/animations/scroll-behavior.
- `color`/`background` transitions on `body` (150ms) so theme toggle is smooth (but disabled under reduced-motion).

## Task 3 — Layout primitives
- `.page-section`: `max-width:var(--max-w); margin:0 auto; padding:2rem 1.5rem; border-top:1px solid var(--border)`.
- `.section-heading` (h2): 1.2rem / 600 / `letter-spacing:-0.01em`.
- Inline link style `.page-section a`: accent color, transparent underline → reveals on hover/`:focus-visible`; visible focus ring (`outline:2px solid var(--accent); outline-offset:2px`).
- Responsive `@media (max-width:600px)`: section padding → `1.5rem 1rem`; profile name → 1.45rem; nav adjustments (Task 4).

## Task 4 — Sticky nav + theme toggle
- `<nav id="site-nav">` sticky, `border-bottom` hairline, `--nav-bg` background, z-index 100.
- `.nav-inner` (max-width 780px, flex, height ~48px): left = name "Shizheng Wen"; center/right = anchor links **About · News · Publications · Awards · Talks**; far right = theme-toggle button.
- Nav links: 500 weight, muted → accent on hover/`.active`; `:focus-visible` ring.
- **Theme toggle:** `<button>` 44×44 hit area, `aria-label="Toggle dark mode"`, contains both sun & moon inline SVG; CSS shows the correct icon per `data-theme`. Hover background tint, active scale(0.9).
- ≤600px: hide nav name, tighten link gap/size, keep toggle visible. Ensure no horizontal scroll at 375px.

## Task 5 — Profile header
- `<header class="profile-header">` centered: `avatar.jpeg` (circular, 120px, `width`/`height` set, 3px border, `alt="Photo of Shizheng Wen"`).
- `<h1>` "Shizheng Wen (闻仕政)"; `<p>` title/affiliation lines: "PhD Student · Seminar for Applied Mathematics (SAM), ETH Zurich" and "Affiliated PhD · ETH AI Center". (Derive from About para — these are stated facts, not new content.)
- Social-icon row (Task 6) directly below.

## Task 6 — Links → social icons (Rendering Convention)
Render `## Links` as icon links (Simple Icons CDN `https://cdn.jsdelivr.net/npm/simple-icons@latest/icons/<slug>.svg`), 44×44 targets, each with `aria-label`, external links `target="_blank" rel="noopener noreferrer"`, `mailto:` for email:
- Email → inline envelope SVG (not Simple Icons) → `mailto:shizheng.wen@sam.math.ethz.ch`
- Google Scholar → `googlescholar` → scholar URL
- GitHub → `github` → github.com/Shizheng-Wen
- LinkedIn → `linkedin` → linkedin URL
- Twitter / X → `x` → x.com/WenShizheng
- Resume → generic inline **document** SVG (not Simple Icons; it's a Google Drive file) → drive URL
- Icons recolor via CSS filter to muted, → accent on hover; `:focus-visible` ring. `img` Simple Icons get `alt="" aria-hidden="true"` (label is on the `<a>`).

## Task 7 — About section
- `<section id="about">` h2 "About". Render the three About paragraphs verbatim as prose, preserving all inline links (Siddhartha Mishra, SAM, ETH Zurich, ETH AI Center, TensorMesh, torch-sla, GAOT, RIGNO, Earl Dowell, Wanlin Guo, Xianglei Liu) with correct hrefs from page-story.
- Keep the bulleted three-directions list (Differentiable solvers / Scalable neural solver backbones / PDE foundation models) as a `<ul>` with bolded lead-ins — do **not** promote into hero. `max-width:72ch` on paragraphs.

## Task 8 — News timeline
- `<section id="news">` h2 "News". `<ul class="timeline">` with the 2px vertical rail (`::before`).
- One `.timeline-item` per news entry (May 2026 ×2, Apr 2026, Feb 2026, Jan 2026, Sep 2025, May 2025, Apr 2024, Nov 2023, Jul 2022) in page-story order.
- Each: colored dot badge (`role="img"` + `aria-label`), `.tl-date` (the month/year, 500 muted), then the entry text with inline links and `<strong>` venue emphasis exactly as written (ICML 2026, ICLR 2026, NeurIPS 2025, IJMS, TAML, APL).
- Badge color convention: publication/acceptance = green, release/open-source = blue, milestone (PhD start, ETH Medal) = amber. Meaning carried by text too.

## Task 9 — Selected Publications
- `<section id="publications">` h2 "Selected Publications". `<ol class="pub-list">`, hairline dividers between items.
- Per paper (10 total, in story order): `.pub-title`; `.pub-authors` with **Shizheng Wen bolded**; `.pub-meta` with venue (`.pub-venue`, e.g. "ICML 2026", "Applied Physics Letters, 2022") + inline links (arXiv / code / project / doi) as small accent links separated by "·".
- **Equal contribution:** authors with `^*` (e.g. Shizheng Wen\*, Mingyuan Chi\* in TensorGalerkin; Mingyuan Chi\*, Shizheng Wen\* in torch-sla) render the name with a superscript `*`. Add one footnote line after the list: "* Equal contribution." 
- Preserve every link href exactly (arXiv, GitHub, project sites, doi, HuggingFace).

## Task 10 — Selected Awards
- `<section id="awards">` h2 "Selected Awards". Simple `<ul>` (clean list, page rhythm): ICML Gold Reviewer 2026 · ETH Medal (top 2.5%) 2026 · National Scholarship (top 1%) 2019 · NUAA Presidential Fellowship (top 0.1%) 2019. Render verbatim.

## Task 11 — Invited Talks timeline
- `<section id="talks">` h2 "Invited Talks". Same `.timeline` component, blue dot badges (talk).
- Three entries (Mar 2026 ×2, Dec 2025) in order: date + talk title + host/institution exactly as written (Simon Fraser / Tsinghua / Stanford, with hosts).

## Task 12 — Footer
- `<footer class="site-footer">` hairline top border, centered muted: "© 2026 Shizheng Wen".

## Task 13 — JavaScript (minimal, vanilla)
- **Active-nav tracking:** `IntersectionObserver` over `section[id]`, toggling `.active` on matching nav link (`rootMargin: '-40% 0px -55% 0px'`). Used only for nav highlight — no entrance animation.
- **Theme toggle:** click handler flips `data-theme` on `<html>`, writes `localStorage.theme`, updates `aria-pressed`/icon. (Initial value already set by head script in Task 1.)
- Guard: if `prefers-reduced-motion`, observer still runs (no motion involved); no scroll animation added regardless.

## Task 14 — Build-time quality checklist (verify before Step 5)
- [ ] All interactive elements have `:hover` + `:focus-visible` states.
- [ ] ≥3 type levels (profile 1.75 / heading 1.2 / body 0.95 + meta 0.8).
- [ ] Consistent 4px-based spacing rhythm.
- [ ] No horizontal scroll at 375px and 1200px.
- [ ] `avatar.jpeg` referenced relative to index.html (root), not page-story path.
- [ ] No bounded region predominantly empty.
- [ ] `## Links` rendered as icon links; unknown→generic SVG (Resume = document icon).
- [ ] Warm-editorial-minimal CSS reflected (not generic clean defaults): cream bg, cerulean accent, hairline borders, flat (no shadow).
- [ ] Dual light/dark via CSS vars + toggle + localStorage + `prefers-color-scheme` default; both themes pass AA contrast.
- [ ] Equal-contribution footnote present; subject name bolded in author lists.
- [ ] All page-story links preserved with exact hrefs.

## Task 15 — Quality pass (Step 5)
Run `polish` then `audit` (both always). Run `quieter` only if visually aggressive; `critique` only if concerns remain.
