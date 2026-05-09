---
name: kim
description: >
  KIM (Knowledge Intelligence Manager) is your persistent local knowledge vault. Use KIM whenever
  you want to STORE knowledge (notes, docs, summaries, code snippets, research), RETRIEVE stored
  knowledge to answer questions or pass to other agents, LIST or SEARCH the vault, or ORGANIZE
  existing entries. KIM is token-efficient: it always checks the local vault before going online,
  saving tokens and time. Use KIM proactively whenever a user says "remember this", "save this for
  later", "what did we learn about X", "pass this to another agent", "keep this knowledge",
  "document this", "store this file", or asks a question whose answer might already be in the vault.
  KIM understands Obsidian-style markdown and is seeded with knowledge about the
  obsidian-digital-garden plugin repo (gotsetthawut/obsidian-digital-garden).
---

# KIM — Knowledge Intelligence Manager

KIM is a persistent local knowledge vault that stores, organizes, and serves knowledge across
sessions. Its job is to eliminate redundant web lookups and token waste by being the single source
of truth for everything you and your agents have already learned.

---

## The KIM Vault

KIM stores all knowledge in a vault directory: **`kim-vault/`** inside the user's workspace folder.

**Structure:**
```
kim-vault/
├── INDEX.md          ← master catalogue of all entries
└── topics/
    ├── [slug].md     ← one file per knowledge entry
    └── ...
```

On every action, check whether `kim-vault/INDEX.md` exists. If it doesn't, initialize the vault
first (see "Initializing the Vault" below). The vault path is relative to the user's connected
workspace folder, or the outputs directory if none is connected.

---

## Initializing the Vault

If `kim-vault/` does not exist, create it with this `INDEX.md`:

```markdown
---
title: KIM Knowledge Vault Index
created: <TODAY>
---

# KIM Knowledge Vault

| Slug | Title | Tags | Updated |
|------|-------|------|---------|
```

Confirm: "✅ KIM vault initialized. Ready to store knowledge."

---

## Operations

### STORE — Add knowledge to the vault

Triggered by: "remember this", "save this", "store this", "keep this", "document this",
receiving a file/text/URL from user or another agent.

**Steps:**
1. Determine a short kebab-case `slug` (e.g. `obsidian-publish-workflow`)
2. Check if slug exists already → if yes, ask: overwrite or append?
3. Write `kim-vault/topics/<slug>.md` with frontmatter:
   ```yaml
   ---
   title: <Human-readable title>
   tags: [<relevant tags>]
   source: <URL or "user-provided" or "agent:<name>">
   created: <YYYY-MM-DD>
   updated: <YYYY-MM-DD>
   summary: <1-2 sentence summary>
   ---
   ```
   followed by full content in clean markdown.
4. Append row to `kim-vault/INDEX.md` table: `| slug | title | tags | updated |`
5. Confirm: "✅ Stored as `<slug>`. Tags: `<tags>`."

**Content quality:**
- Strip boilerplate, ads, nav menus from web content
- Preserve code blocks with language tags
- Preserve headers for navigability
- For files >500 lines, add `## TL;DR` summary at top

---

### RETRIEVE — Fetch knowledge from the vault

Triggered by: "what do we know about X", "get me the docs on Y", "pass this to another agent",
"what's stored about Z", "recall X".

1. Read `kim-vault/INDEX.md` → find candidate slugs
2. Read `kim-vault/topics/<slug>.md`
3. Return content (full for agents, summarized for quick user questions)
4. If not found → say so and offer to fetch + store from the web

When serving another agent, return full markdown including frontmatter.

---

### LIST — Show all stored knowledge

Triggered by: "what's in KIM", "list all knowledge", "show my vault", "what do you know".

Read `kim-vault/INDEX.md` and render the table. Group by tags if >20 entries.

---

### SEARCH — Find knowledge by keyword or tag

Triggered by: "search for X in KIM", "find notes tagged Y", "do we have anything about Z".

Search all files in `kim-vault/topics/`. Return matching slugs, titles, and 2–3 lines of
context around each match.

---

### ORGANIZE — Re-tag, rename, or restructure entries

Triggered by: "organize KIM", "clean up vault", "retag X as Y", "merge these notes".

Present vault summary, suggest improvements, apply with user confirmation.
Always update `INDEX.md` after changes.

---

### DIGEST — Summarize a topic from stored knowledge

Triggered by: "summarize what KIM knows about X", "give me a briefing on Y".

Read all entries for the topic, synthesize a coherent summary, list source slugs at bottom.

---

## Built-in Seed Knowledge

KIM is pre-seeded with knowledge about the **obsidian-digital-garden** plugin. When asked
about this repo, read `references/obsidian-digital-garden.md` before any web lookup.

---

## Working with Other Agents

- **Receiving from an agent**: Store with `source: "agent:<name>"` in frontmatter
- **Serving to an agent**: Return full markdown with frontmatter
- **Token savings**: Always prefer vault over web search. State: "Answering from KIM vault."

---

## Tone

- ✅ successful ops · 🔍 searches · 📚 retrievals · 🗂️ organize
- Always confirm the slug when storing
- If vault is empty or topic not found, suggest what to store next

---

## Reference Files

- `references/obsidian-digital-garden.md` — complete knowledge doc for the
  obsidian-digital-garden plugin (gotsetthawut/obsidian-digital-garden). Read when users
  ask about the repo, its features, setup, code structure, or publishing workflow.
