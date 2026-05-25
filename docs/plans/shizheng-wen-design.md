# Shizheng Wen — Academic Homepage · Design Doc

Source: `page-story.md` (authoritative content). Aesthetic reference: `index2.html`.

## Design Context

### Reference
Signals extracted from the reference template `index2.html`:
- **Color temperature:** warm paper base (`#f8f4ec` cream bg, `#3d3630` warm-brown text, `#5a544a` muted brown) with a single **cool cerulean accent** (`#0087BD`). Warm body, cool highlight.
- **Typography:** `DM Sans` (sans-serif) loaded via Google Fonts; weights 400 / 500 / 600. Moderate weight contrast — headings 600, body 400, labels 500.
- **Spatial density:** compact-but-airy reading. `max-width: 780px`, `line-height: 1.65`, body `font-size: 0.95rem`, section padding `2rem 1.5rem`.
- **Animation:** restrained — `transition: color 150ms ease-out` on links/nav; `transform: scale(0.9)` active state on social links; `scroll-behavior: smooth`; no `@keyframes`. Honors `prefers-reduced-motion`.
- **Hover character:** links shift to accent + reveal underline; social icons gain a faint accent-tinted circular background.
- **Surface treatment:** flat — **no box-shadow**, hairline `1px solid var(--border)` (`#e5ded3`) separating sections, small `4px` radius. Surfaces are barely-there.
- **Layout character:** **single centered column** (780px), sticky top nav with `IntersectionObserver` active-section tracking, centered profile header with circular avatar, sections stacked and divided by top borders.
- **Components present:** vertical timeline with colored dot badges (news/talks), publication list with venue + pill badges, social icon links via Simple Icons CDN, skip-link, footer.

### Users
- **Academic peers & collaborators** in scientific computing + ML for PDEs — scanning for research directions, papers, and code (TensorMesh, torch-sla, GAOT, RIGNO).
- **Hiring / award committees & senior faculty** — assessing credibility quickly: supervisor, institution, venues (ICML, ICLR, NeurIPS), awards (ETH Medal).
- **Recruiters / prospective students** following links to GitHub, Scholar, resume.
- Context of use: desktop and mobile, often a quick scan ("who is this, what do they work on, where are the papers"). Job to be done: establish credibility and surface the work + contact paths with zero friction.

### Brand Personality
- Three words: **precise · scholarly · understated**.
- Voice: technically credible and direct; lets the work speak. No marketing tone, no hype.
- Emotional goal: quiet confidence and trust. The reader should feel they are looking at rigorous, serious research presented with care.

### Aesthetic Direction
- **Warm-editorial-minimal**, derived faithfully from `index2.html`. Warm cream paper, cool cerulean accent, flat hairline-divided single column, DM Sans.
- This bridges the user's "cool & minimal" instinct (cool accent, flat surfaces, restraint, generous whitespace) with the reference's warm paper base.
- **Anti-references:** no gradients, no glassmorphism, no drop shadows, no card elevation, no decorative illustration, no motion-for-motion's-sake, no dark-academia heaviness. Nothing that competes with the text.
- **Theme:** dual light + dark mode, all colors as CSS custom properties, sun/moon toggle top-right, preference persisted in `localStorage`, `prefers-color-scheme` as initial default. The dark theme must preserve the warm-paper-with-cool-accent character (warm-dark surface, not pure black; cerulean accent retained/brightened for contrast).

### Design Principles
1. **Content is the artifact.** The page-story is authoritative — render every element faithfully, in its original section and order. Design surfaces structure; it never adds, promotes, or reinterprets content.
2. **Structure over prose.** Each element is rendered as what it *is*: news/talks/awards as sequences, venues as labels, the subject's own name among co-authors as a relationship (bolded). Default to plain prose only for genuine narrative (the About paragraph).
3. **Flat & quiet.** No shadows, no elevation. Hairline borders and whitespace do all the separating. One accent color, used sparingly for links and active states only.
4. **One calm column.** A single 780px reading column, clear 3-level type hierarchy (heading 600 / body 400 / meta 500–muted), consistent vertical rhythm. Nothing bounded should sit predominantly empty.
5. **Accessible by construction.** WCAG AA contrast in both themes, visible `:focus-visible` rings, full keyboard nav, skip-link, `prefers-reduced-motion` respected, semantic landmarks and headings.

## Design System

Generated via `ui-ux-pro-max --design-system`, then reconciled against the authoritative reference (`index2.html`). The skill's raw output assumed a visual *portfolio* product; this is a *scholarly academic homepage*, so several recommendations are overridden below with reasons. Overrides are deliberate, not omissions.

### Skill Output & Overrides

| Dimension | Skill recommendation | Decision | Reason |
|-----------|---------------------|----------|--------|
| Pattern | Portfolio Grid (masonry, project cards) | **Override → single 780px reading column** | Content is text/papers, not visual work. A grid would fragment a linear scholarly read. |
| Style | Motion-Driven (parallax, scroll/entrance anim) | **Override → Flat warm-editorial-minimal** | Reference is deliberately restrained; heavy motion undercuts scholarly credibility and accessibility. |
| Colors | Monochrome `#18181B` + blue `#2563EB` on `#FAFAFA` | **Override → warm cream + cerulean** (below) | Reference establishes a warm paper base; cool-blue accent retained but as cerulean `#0087BD`. |
| Typography | Archivo + Space Grotesk | **Override → DM Sans (single family)** | Reference uses one humanist sans for both heading & body; two display faces would read as "designer portfolio," not academic. |
| Effects | Parallax (3–5 layers), 300–400ms hover | **Override → 150ms color transitions only** | Single accent-color transitions; `IntersectionObserver` used *only* for active-nav tracking, not entrance animation. |
| **Kept as-is** | Avoid corporate/generic templates; semantic color tokens; 4.5:1 contrast; visible focus; `prefers-reduced-motion`; SVG icons (no emoji); responsive 375/768/1024 | **Adopt** | Aligns with Principle 5 and the reference. |

### Color Tokens (semantic, both themes)

**Light**
| Role | Token | Hex |
|------|-------|-----|
| Background | `--bg` | `#f8f4ec` |
| Surface | `--surface` | `#faf8f3` |
| Text | `--text` | `#3d3630` |
| Muted text | `--text-muted` | `#5a544a` |
| Border (hairline) | `--border` | `#e5ded3` |
| Accent | `--accent` | `#0076a3` |
| Accent hover | `--accent-hover` | `#00597a` |
| Nav background | `--nav-bg` | `#ffffff` |

> Note: reference's `#0087BD` only reaches ~3.7:1 on the cream bg (fails AA for body-size link text). Deepened to `#0076a3` (~4.65:1) to satisfy Principle 5 while preserving the cerulean identity.

**Dark** (warm-dark, not pure black; cerulean brightened for AA on dark)
| Role | Token | Hex |
|------|-------|-----|
| Background | `--bg` | `#1c1a17` |
| Surface | `--surface` | `#23201c` |
| Text | `--text` | `#ece6da` |
| Muted text | `--text-muted` | `#a89f90` |
| Border (hairline) | `--border` | `#352f28` |
| Accent | `--accent` | `#4db8e0` |
| Accent hover | `--accent-hover` | `#7cccea` |
| Nav background | `--nav-bg` | `#23201c` |

Dot-badge palette (timeline): green `#56ae5d`, blue `#1988b8`, amber `#d99a2b` — used as small categorical markers (publication / talk / award); meaning is always reinforced by `aria-label` + text, never color alone.

### Typography
- **Family:** `DM Sans`, `system-ui`, `-apple-system`, sans-serif (Google Fonts, `display=swap`).
- **Weights:** 600 (headings, profile name, nav name, pub title emphasis), 500 (nav links, meta/labels, venue), 400 (body).
- **Scale (rem):** 1.75 profile name · 1.2 section heading · 0.95 body · 0.9 nav / pub title · 0.82 authors · 0.8 meta/date/venue · 0.75 badge.
- **Line-height:** 1.65 body, 1.5–1.6 dense list content.
- **Letter-spacing:** `-0.01em` on section headings only; default elsewhere (no tight tracking on body).

### Style & Effects
- Flat. **No** box-shadow, gradient, or blur anywhere.
- Borders: hairline `1px solid var(--border)`; radius `4px` (badges `99px` pill).
- Transitions: `150ms ease-out` on `color` / `background` / `text-decoration-color` only; `transform: scale(0.9)` active feedback on icon buttons.
- `scroll-behavior: smooth` + `scroll-padding-top` for sticky nav; all motion disabled under `prefers-reduced-motion`.

### Anti-Patterns (forbidden)
Shadows / elevation; gradients; glassmorphism; parallax or scroll-triggered entrance animation; multiple accent colors; emoji icons; card grids / masonry; hero promotion of body content; raw hex in markup (tokens only); dark mode by naive inversion.

### Aesthetic Implementation

**Layout structure (HTML skeleton)**
```
skip-link
nav#site-nav (sticky)         → name (left) · anchor links (right) · theme toggle (far right)
main#main-content (centered, max-width 780px)
  header.profile-header       → avatar (circular, centered) · name (h1) · title/affiliation · social-icon row
  section#about               → h2 + narrative prose (subject's research)
  section#news                → h2 + vertical timeline (dot badge + date + entry)
  section#publications        → h2 + ordered pub-list (title · authors · venue · inline links) + equal-contrib footnote
  section#awards              → h2 + simple list
  section#talks               → h2 + vertical timeline (dot badge + date + talk + venue)
footer.site-footer            → © line, centered
```
Single centered reading column; sections stacked, divided by `border-top: 1px solid var(--border)`. Nav uses `IntersectionObserver` to set `.active` on the current section's link.

**Surface treatment (exact CSS)**
```css
.page-section {
  max-width: var(--max-w);      /* 780px */
  margin: 0 auto;
  padding: 2rem 1.5rem;
  border-top: 1px solid var(--border);
}
#site-nav {
  position: sticky; top: 0; z-index: 100;
  background: var(--nav-bg);
  border-bottom: 1px solid var(--border);
}
/* No card, no shadow, no fill — whitespace + hairline rule do the separating. */
```

**Typography expression**
- Heading:body weight ratio = **600 : 400**; labels/meta = 500.
- Size contrast within a section ≈ section-heading 1.2rem vs body 0.95rem (≈1.26×); profile name 1.75rem is the single largest note.
- Letter-spacing `-0.01em` on headings; muted color (`--text-muted`) carries secondary info (dates, authors, venue) instead of size alone.

**Decorative rules**
- *Present:* hairline section rules; 10px colored dot badges on the timeline rail (2px vertical line); small pill venue/contrib badges; circular avatar with 3px border; underline-on-hover for inline links.
- *Forbidden:* shadows, gradients, glass, oversized display type, icon ornamentation, background imagery.

**Spatial rhythm**
- Compact-but-airy. Section padding `2rem` (vertical) / `1.5rem` (horizontal), tightening to `1.5rem`/`1rem` ≤600px.
- Timeline items `1.25rem` apart; pub items `1rem` vertical padding with hairline dividers.
- 4px-based increments; intentional whitespace groups related items and separates sections (no filler).

**Signature CSS (the unmistakable fingerprint)**
```css
:root {
  --bg: #f8f4ec; --text: #3d3630; --accent: #0087BD;
  --border: #e5ded3; --radius: 4px; --max-w: 780px;
  --font: 'DM Sans', system-ui, -apple-system, sans-serif;
}
body { background: var(--bg); color: var(--text); font: 400 0.95rem/1.65 var(--font); }
.page-section { max-width: var(--max-w); margin: 0 auto; border-top: 1px solid var(--border); }
.timeline { position: relative; padding-left: 1.75rem; }
.timeline::before { content:''; position:absolute; left:5px; top:10px; bottom:10px; width:2px; background:var(--border); }
a.page-link { color: var(--accent); text-decoration-color: transparent; transition: text-decoration-color 150ms ease-out; }
```
