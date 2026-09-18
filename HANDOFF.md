# Handoff — "The recent projects I'm doing" section

Branch: `claude/focused-feynman-ls50n9` · Written 2026-09-18

The section is **built and working** on `index.html`. The ClaudeGamepad demo
landed in a local session the same day (see "Done locally" below); what is
left is optional copy and polish.

---

## What already ships

| Piece | State |
|---|---|
| Collapsed section at the bottom of the card | Done — native `<details>`, works with JS off |
| Two-column card grid (one column below 700px) | Done |
| Verb chip (one treatment for every role) + verb repeated in the title in cobalt | Done |
| Detail layer (modal) per project | Done — Esc / backdrop / close button, focus returns to the card |
| Workshop photos (3) | Done — `images/projects/workshop/` |
| Workshop YouTube, click-to-load player | Done — no request to Google until someone presses play |
| ClaudeGamepad photo (1) + copy | Done — `images/projects/claudegamepad/01-desk.jpg` |
| ClaudeGamepad card cover | Done — muted timelapse `thumb-loop.mp4` (512 KB) + `thumb-cover.jpg` poster; loads and plays only once the section is expanded, poster only under reduced motion |
| ClaudeGamepad demo | Done — YouTube Short `BqHP_jRhW2g` in the click-to-load player, poster `demo-cover.jpg` |
| Deep link `index.html#p-workshop` / `#p-claudegamepad` | Done — opens the section and that project |
| `v2.css` cache buster | Bumped to `?v=3.6` in `index.html`, `story.html`, `og.html` |

Verified in Chromium at 1200px and 390px: open/close, Esc, focus return,
deep link, mobile reflow, zero console errors.

---

## Done locally (2026-09-18, by Claude)

- **Demo went to YouTube, not a self-hosted loop.** The demo is Henry
  explaining the app, so it needs sound; unmuted video cannot autoplay anyway,
  and 82 s with audio would be 6–8 MB in git forever. The `.MOV` and the 100 MB
  GIF stayed out of the repo.
- **Photo and demo share one row** (`.pd__pair`): both are portrait, so they sit
  side by side in 3:4 frames with the "The demo" label and YouTube link over and
  under the right one only. Below 560px they stack.
- **The "Screens" label is gone** for ClaudeGamepad; meta reads "Open Source"
  instead of "MIT".
- **Project modal scrolls inside `#project-body`**, not on `.cb-modal`. Scrolling
  on the modal forced `overflow-x` to auto too, which clipped the overhanging ✕
  and produced a horizontal scrollbar. Modal widened 720 → 800px.
- **Fixed:** under 560px a single-shot `.pd__shots--one` fell back to half width.

The earlier "second screenshot" and "video link" asks are closed by the above.

---

## Still open (optional)

### 1. Workshop — a second line of description

The detail currently carries one line, your own slide subtitle:

> How to take notes that help you think — and connect ideas across every subject.

A second sentence on what people walked out with would round it off. Your words,
not mine. It goes as a second `<p>` inside `.pd__body`.

### 2. Workshop — a real poster frame (optional)

The player currently reuses `01-room.jpg` as its poster. A frame pulled from the
recording itself would look less like a repeat:

```bash
ffmpeg -i <the recording> -ss 12 -vframes 1 -vf scale=1600:-2 \
  images/projects/workshop/session-cover.jpg
```

Then point the player's `<img src>` at it.

---

## Decisions I made that you can overrule

- **Deep links are in.** `#p-workshop` opens the section and that project.
  Closing the modal strips the hash. Say so if you want it gone — it is one
  block in the script.
- **Section title is your original wording**, "The recent projects I'm doing".
- **Card cover images reuse the detail photos** rather than separate crops, to
  keep the page light. Total added weight so far: 756 KB for four photos.
- **QR and Now modals were left alone.** They do not return focus to their
  trigger on close, same as before this change. Worth fixing, but it was not
  part of this task.

## Adding the next engagement (RDB, or whatever comes)

Copy one `<article class="project">` block in `index.html`, change the `id` to
`p-<slug>`, swap the images, chip, title and copy. The card and its detail live
in the same block, so there is only one place to edit. `CLAUDE.md` has the same
note under "Projects section".

## Checking your work

No build step. Open `index.html` in a browser and check:
expand, both cards open, Esc closes, the page still reads at 390px wide, and
the video plays. If `v2.css` changes, bump `?v=` in all three HTML files.
