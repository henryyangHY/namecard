# Now Protocol — for AI agents

This file tells AI assistants (Copilot CLI, Claude, etc.) how to maintain Henry's
**Now page** at `now.json` in this repo, surfaced at
<https://henryyanghy.github.io/namecard/> via the rail's `● Now` button.

> Goal: **ambient capture** — Henry doesn't write status updates manually.
> The AI offers, drafts, commits.

---

## When to offer an update

During any conversation with Henry, watch for moments like:

- He says he's **building / shipping** something new (a feature, a project, a side-thing)
- He's **learning** a new tool, concept, framework, or domain
- He's **reading** a notable book, paper, or long article
- He's **thinking** through a problem, narrative, or decision (e.g., MBA recruiting story)
- He **launches** something (talk, podcast episode, product, post)
- He mentions a **life** beat worth surfacing (training milestone, trip, hobby)

When you spot one, **proactively ask**:

> "想把這個更新到你的 Now page 嗎？我可以幫你寫一句話。"
> (or in English if the conversation is in English)

Do **not** ask every time something interesting comes up — be tasteful. Aim for
~1 offer per substantive conversation, max. Skip if Henry has already declined
something similar in the same session.

---

## How to draft

If Henry says yes:

1. Draft **one short sentence** (≤ 90 chars ideally, hard cap 140) capturing
   what he's doing/learning/reading/thinking. Active voice. No emojis.
2. Pick one **tag** from the allowed set (see below).
3. Show him the draft + tag. Let him edit before publishing.
4. Use today's date in `YYYY-MM-DD` (Asia/Taipei, ISO).

### Allowed tags

| tag | use for |
|---|---|
| `building` | Active projects he's working on (code, products, content) |
| `learning` | Skills / concepts / frameworks being studied |
| `reading` | Books, papers, long articles |
| `thinking` | Open problems, narratives, decisions being worked through |
| `shipping` | Just launched / completed / published |
| `life` | Personal — training, travel, hobbies, family |

Pick exactly one. Default to `thinking` if unsure.

---

## How to publish

The data lives at `now.json` in this repo (`henryyangHY/namecard`). Schema:

```json
{
  "updated": "YYYY-MM-DD",
  "entries": [
    { "date": "YYYY-MM-DD", "tag": "building", "text": "..." },
    ...
  ]
}
```

Update flow:

1. Fetch current file (locally or via `gh api`).
2. **Prepend** the new entry to `entries[]` (most recent first).
3. Update top-level `updated` to today.
4. Optional: trim `entries` to the latest 20 (older history kept in git log).
5. Commit message: `now: <one-line summary>` — e.g., `now: shipped namecard v2 QR feature`.
6. Push to `main`. GitHub Pages redeploys in ~30s.

### Using `gh` CLI (preferred — no clone needed)

```bash
# fetch
gh api repos/henryyangHY/namecard/contents/now.json --jq '.content' | base64 -d > /tmp/now.json

# (edit /tmp/now.json — prepend entry, bump updated)

# push back
NEW_CONTENT=$(base64 -w0 < /tmp/now.json)
SHA=$(gh api repos/henryyangHY/namecard/contents/now.json --jq .sha)
gh api repos/henryyangHY/namecard/contents/now.json \
  -X PUT \
  -f message="now: <summary>" \
  -f content="$NEW_CONTENT" \
  -f sha="$SHA"
```

### Using local clone

If a clone exists (e.g. `~/namecard-deploy` or via the namecard workspace),
edit `now.json` and run `git add now.json && git commit -m "now: ..." && git push`.

---

## Style rules for entries

- **Active, specific, present-tense.** "Building X." not "Working on X stuff."
- **No marketing fluff.** No "excited to", "thrilled to", "honored to".
- **One concrete noun.** Mention the thing by name when possible.
- **No URLs in text.** (We can add `link` to schema later if needed.)
- **English** by default. Chinese OK if the entry is about something Chinese.
- **Don't be sycophantic.** This is Henry's status, not a hype post.

### Examples (good)

- ✅ `Building an AI-updatable Now page for my namecard.`
- ✅ `Studying agentic workflow design patterns.`
- ✅ `"Working Backwards" — Bryar & Carr on Amazon's PR/FAQ method.`
- ✅ `Sharpening my MBA recruiting narrative around AI builder identity.`

### Examples (bad)

- ❌ `Excited to share I'm working on some cool new AI stuff! 🚀` (fluff, emoji)
- ❌ `Doing things.` (vague)
- ❌ `Building [project] which is a tool that helps users do X by leveraging Y to enable Z.` (too long)

---

## Don't

- Don't update without explicit "yes" from Henry. Always show the draft first.
- Don't backfill past events without asking.
- Don't auto-update on a schedule. This is *ambient*, not cron.
- Don't commit other files in the same `now: ...` commit.
- Don't add more than one entry per conversation unless Henry asks.

---

Last revised: 2026-05-20
