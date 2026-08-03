# CLAUDE.md — Henry Yang Virtual Name Card

## What this repo is

A static personal landing page hosted on GitHub Pages at
`https://henryyanghy.github.io/namecard/`. No build step, no framework, no
package manager. Push to `main` → GitHub Pages deploys in ~30 s.

---

## File map

```
namecard/
├── index.html              # Entire app — HTML, inline JS, structured data
├── story.html              # Long-form origin story page
├── og.html                 # Source template for the share images (not linked)
├── now.json                # Live "Now page" feed (AI-updatable, see below)
├── NOW_PROTOCOL.md         # Rules for AI agents maintaining now.json
├── tools/
│   └── render-og.sh        # Renders og.html → images/og-*.png at 1200×630
├── assets/
│   ├── css/
│   │   └── v2.css          # All styles — "Cobalt Bone" design system
│   └── fonts/              # Self-hosted variable fonts (.ttf)
└── images/
    ├── avatar.jpg          # Profile photo (200×200, displayed on card)
    ├── henry-yang.vcf      # vCard downloaded when visitor taps avatar
    ├── og-v3.png           # Share image for index.html (1200×630, rendered)
    ├── og-story-v3.png     # Share image for story.html (1200×630, rendered)
    ├── og.png              # Legacy share image (old dark theme, unreferenced)
    ├── favicon-32.png
    ├── favicon-192.png
    └── apple-touch-icon.png
```

---

## Design system — "Cobalt Bone"

Warm-bone paper, cool ink, cobalt for action. Everything is flat and outlined:
2px ink borders and **hard offset shadows** (no blur, ever). All tokens are CSS
custom properties at the top of `assets/css/v2.css`.

**Palette**:

| Token | Value | Role |
|---|---|---|
| `--canvas` | `#f2ebdd` | Page background (bone) + `--hairline-soft` dot grid |
| `--canvas-tint` | `#e9e0cd` | Tinted bands, image placeholders |
| `--surface-card` | `#fdfaf3` | Raised cards (`.bio-card`) |
| `--surface-band` | `#15203a` | Full-bleed dark bands (`.band--ink`, story page) |
| `--primary` | `#1c40a8` | Brand / action cobalt — links, `.cb-mark`, icon hovers |
| `--primary-deep` | `#132e7d` | Link hover |
| `--primary-lift` | `#8aa8ff` | Cobalt on dark surfaces |
| `--primary-shade` | `#0b1d5c` | Shadow colour under cobalt elements |
| `--accent` | `#9c4a13` | Burnt ochre — **editorial emphasis only**, never a button |
| `--ink` | `#15203a` | Headings, all borders, all hard shadows |
| `--body` | `#3d4759` | Body copy |
| `--muted` | `#5c6577` | Meta, mono captions |
| `--on-band` / `--on-band-dim` | `#c5cbd8` / `#98a1b3` | Text on `--surface-band` |

**Typography** (self-hosted variable fonts in `assets/fonts/`, no Google Fonts):

| Token | Family | Used for |
|---|---|---|
| `--font-display` | Bricolage Grotesque (200–800) | Name, monikers, chapter titles |
| `--font-body` | Instrument Sans (400–700) | All prose |
| `--font-mono` | JetBrains Mono (100–800) | Kickers, handles, years, URLs — uppercase + wide tracking |

Display type runs tight: `--ls-display-lg` `-1.45px`, `--ls-display-md` `-0.7px`.

**Shape & motion**:
- Shadows: `--shadow-rest` `4px 4px 0`, `--shadow-lift` `6px 6px 0`,
  `--shadow-press`/`--shadow-flat` on `:active` — the element physically moves
  by `translate()` while the shadow shrinks
- Radii: `--radius-sm` 6px (links, cards), `--radius-lg` 10px (the big card),
  `--radius-pill` 20px, `--radius-full` (avatar, dots)
- All transitions `130ms cubic-bezier(.2,.8,.3,1)` (`--dur-interaction`, `--ease-physical`)

**Layout**:
- `index.html` — one `.bio-card` (max-width 968px) on the dotted canvas.
  Two-column grid at ≥860px; below that `.bio__row`/`.bio__cell` collapse to
  `display:contents` and the children are reordered with `order`
- `story.html` — full-bleed `.band` sections alternating `--ink` / `--tint` /
  `--cobalt`, inner column capped at 900px, plus a fixed scroll `.progress` rail

**Signature marks** — reuse these instead of inventing new ones:
`.cb-mark` (cobalt highlight behind a word) · `.cb-em` (ochre emphasis) ·
`.cb-pill` (mono outlined button) · `.cb-link` (icon + label + `↗` row) ·
`.kicker__num` (cobalt chip) · the `HY` rail with its cobalt dot

---

## Features

| Feature | How |
|---|---|
| Save contact | Click avatar → `#vcard-link` (hidden `<a>`) triggers `.vcf` download + toast |
| QR modal | `#qr-btn` → renders QR via `api.qrserver.com` (no library needed), lazy-loaded once |
| Now modal | `#now-btn` → fetches `now.json?_=<timestamp>` (cache-busted), renders up to 5 entries |
| Toast | `showToast(msg)` — auto-dismisses after 3.4 s |
| Scroll progress | `story.html` only — `#progress-bar` scales on scroll |

All JS is vanilla and inline in the page it belongs to (no external scripts).

---

## How to make changes

### Content updates
- **Name, bio, tagline, links** → edit `index.html` directly
- **Contact info** → edit `images/henry-yang.vcf` (vCard 3.0 format)
- **Profile photo** → replace `images/avatar.jpg` (keep square, 200×200+ px)
- **Story page copy** → edit `story.html` (bands are self-contained sections)
- **Share images** → never edit the PNGs by hand, see "Share images" below
- **Year** → update `.rail__year` in `index.html`

### Styling
- All styles live in `assets/css/v2.css` (currently `?v=3.0`)
- **After editing `v2.css`, bump the `?v=` on the `<link>` in `index.html`,
  `story.html` AND `og.html`.** GitHub Pages sends no-revalidate caching headers,
  so returning visitors otherwise render the new markup against a stale cached
  stylesheet and the layout breaks.
- Reach for an existing token before adding a new value; change the palette by
  editing the `:root` custom properties, not individual rules
- Shadows are always hard (`Npx Npx 0 <colour>`). No `blur`, no gradients on
  surfaces — the dot grid is the only background texture
- Responsive breakpoints: 860px (index switches to two columns / collapses to a
  reordered single column), 640px (story page card grids), 500px (contact links
  go two-up)
- Respect `prefers-reduced-motion` — the reset at the bottom of `v2.css` handles it

### Share images (Open Graph)

Never hand-paint the share images — they drift from the site the moment the
palette changes. `og.html` is the source of truth: it links the live
`assets/css/v2.css`, so it inherits the real design tokens and self-hosted
fonts. Default view = index card; `?p=story` = the ink-band story variant.

1. Edit `og.html` (or just change the palette in `v2.css`)
2. Run `./tools/render-og.sh` → rewrites `images/og-v3.png` and
   `images/og-story-v3.png` at exactly 1200×630
3. Open the PNGs and check them before committing

**Bump the filename when the artwork changes.** Slack, LinkedIn and X cache OG
images for days regardless of HTTP headers, so reusing a filename means people
keep seeing the old picture. Go to `og-v4.png`, then update `og:image` +
`twitter:image` in `index.html` **and** `story.html`.

### Now page (AI-updatable)
See `NOW_PROTOCOL.md` for the full protocol. Short version:

1. `now.json` holds up to 20 entries (most-recent first)
2. Always **prepend** new entries; never edit old ones
3. Commit message format: `now: <one-line summary>`
4. Allowed tags: `building` · `learning` · `reading` · `thinking` · `shipping` · `life`
5. **Never commit without Henry's explicit approval of the draft**

`now.json` schema:
```json
{
  "updated": "YYYY-MM-DD",
  "entries": [
    { "date": "YYYY-MM-DD", "tag": "building", "text": "One sentence, ≤140 chars." }
  ]
}
```

---

## Git conventions

- Claude AI work goes on a `claude/<topic>-<id>` branch, then merges to `main`
- Commit prefixes used in this repo: `feat:`, `fix:`, `style:`, `content:`, `now:`, `wip:`
- No linting, testing, or CI — changes are verified visually in a browser
- Push to `main` for production; GitHub Pages deploys automatically

---

## SEO / meta checklist (when updating identity info)

Touch all of these when Henry's bio changes:

- `<title>` and `<meta name="description">`
- `og:title`, `og:description`, `og:url`, `og:image`
- `twitter:title`, `twitter:description`, `twitter:image`
- JSON-LD `Person` block (name, jobTitle, alumniOf, sameAs)
- `images/henry-yang.vcf` (name, email, phone, URLs)

---

## Now Protocol — agent quick reference

Read `NOW_PROTOCOL.md` for the full spec. Key rules:

- Offer to update during conversations when Henry mentions building/learning/shipping/life events
- Draft one sentence (≤ 140 chars), pick one tag, show Henry before publishing
- Use today's date in `YYYY-MM-DD` (Asia/Taipei)
- Style: active, specific, present-tense. No emojis, no fluff, no marketing language
- Commit only `now.json`; commit message `now: <summary>`
- Max one entry per conversation unless asked for more
