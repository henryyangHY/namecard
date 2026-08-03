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
│   └── css/
│       └── v2.css          # All styles (v2.3, dark premium tech theme)
│       └── fontawesome-all.min.css
└── images/
    ├── avatar.jpg          # Profile photo (200×200, displayed on card)
    ├── henry-yang.vcf      # vCard downloaded when visitor taps avatar
    ├── og-v3.png          # Share image for index.html (1200×630, rendered)
    ├── og-story-v3.png    # Share image for story.html (1200×630, rendered)
    ├── og.png             # Legacy share image (old dark theme, unreferenced)
    ├── favicon-32.png
    ├── favicon-192.png
    └── apple-touch-icon.png
```

---

## Design system

**Palette** (CSS custom properties in `:root`):

| Token | Value | Role |
|---|---|---|
| `--paper` | `#002045` | Card / page background (deep navy) |
| `--paper-elev` | `#00294f` | Elevated surfaces |
| `--ink` | `#fdedd4` | Primary text (warm ivory) |
| `--accent` | `#ff5c00` | Interactive elements, highlights (flame orange) |
| `--kellogg` | `#4E2A84` | Kellogg brand purple pill |
| `--muted` | `#a09080` | Secondary / subdued text |

**Typography**:
- Display + body: `Outfit` (Google Fonts, weights 300/400/500/600/700)
- Monospace accents: `JetBrains Mono` (weights 400/500)
- `.mono` utility class: 11px, 0.08em letter-spacing, uppercase

**Layout**: single centred card (max-width 580px), flex column. Lower section
(`.section-lower`) uses warm parchment `#E4D5B4` as a contrast panel.

---

## Features

| Feature | How |
|---|---|
| Save contact | Click avatar → `#vcard-link` (hidden `<a>`) triggers `.vcf` download + toast |
| QR modal | `#qr-btn` → renders QR via `api.qrserver.com` (no library needed), lazy-loaded once |
| Now modal | `#now-btn` → fetches `now.json?_=<timestamp>` (cache-busted), renders up to 5 entries |
| Toast | `showToast(msg)` — auto-dismisses after 3.4 s |
| Grain overlay | SVG `feTurbulence` filter via `data:` URI, `position: fixed`, `mix-blend-mode: overlay` |

All JS is vanilla, inline in `index.html` (no external scripts).

---

## How to make changes

### Content updates
- **Name, bio, tagline, links** → edit `index.html` directly
- **Contact info** → edit `images/henry-yang.vcf` (vCard 3.0 format)
- **Profile photo** → replace `images/avatar.jpg` (keep square, 200×200+ px)
- **OG image** → replace `images/og.png` (1200×630 px)
- **Footer year** → update `.mono.mono--muted` text in `index.html` rail + footer

### Styling
- All styles live in `assets/css/v2.css`
- **After editing `v2.css`, bump the `?v=` on the `<link>` in BOTH `index.html` and
  `story.html`.** GitHub Pages sends no-revalidate caching headers, so returning
  visitors otherwise render the new markup against a stale cached stylesheet — the
  page falls back to the dark theme with no card container and a broken grid.
- Change palette by editing CSS custom properties in `:root`
- Responsive breakpoints: 560px (2-col links grid), 400px (narrow pill sizing), 340px (extra-narrow)
- Respect `prefers-reduced-motion` — the reset block at the bottom of `v2.css` handles it

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

- Branch for Claude AI work: `claude/claude-md-docs-sKNQx`
- Commit prefixes used in this repo: `feat:`, `fix:`, `style:`, `now:`, `wip:`
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
