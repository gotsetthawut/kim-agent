# KIM — Knowledge Intelligence Manager

> A persistent local knowledge vault and Claude Agent skill for token-efficient knowledge management.

KIM is a Claude Agent skill that acts as a shared knowledge layer across AI agents. Instead of
each agent fetching the same information repeatedly from the web, KIM stores, organizes, and
serves knowledge from a local vault — saving tokens and lookup time.

---

## What KIM Does

| Operation | Trigger phrase | What happens |
|-----------|---------------|--------------|
| **STORE** | "remember this", "save this", "document this" | Saves content as an Obsidian-style markdown file with frontmatter |
| **RETRIEVE** | "what do we know about X", "recall X" | Returns stored knowledge from vault |
| **LIST** | "what's in KIM", "show my vault" | Shows the full knowledge index |
| **SEARCH** | "search for X", "find notes tagged Y" | Full-text search across the vault |
| **ORGANIZE** | "clean up vault", "retag X as Y" | Re-tags and restructures entries |
| **DIGEST** | "summarize what KIM knows about X" | Synthesizes a briefing from stored entries |

---

## Vault Structure

KIM maintains a local vault at `kim-vault/` in the connected workspace:

```
kim-vault/
├── INDEX.md              ← master catalogue (slug, title, tags, updated)
└── topics/
    ├── <slug>.md         ← one file per knowledge entry
    └── ...
```

Each knowledge entry uses Obsidian-compatible YAML frontmatter:

```yaml
---
title: My Knowledge Entry
tags: [topic, subtopic]
source: https://example.com   # or "user-provided" or "agent:kim"
created: 2026-05-09
updated: 2026-05-09
summary: One-line summary shown in the index.
---
```

---

## Seed Knowledge

KIM ships with a built-in reference document for the
[obsidian-digital-garden](https://github.com/gotsetthawut/obsidian-digital-garden) plugin:

- Full feature list (content types, navigation, customization, hosting)
- Complete setup guide (GitHub token, Vercel deploy, first note)
- Publishing workflow and frontmatter reference
- Local development guide
- Common issues and tips

See [`references/obsidian-digital-garden.md`](references/obsidian-digital-garden.md).

---

## Installation (Cowork Skill)

1. Clone or download this repo
2. Run `create-kim-skill.bat` (Windows) to generate `kim.skill`
3. Drag `kim.skill` into a Claude Cowork chat → click **Save skill**
4. KIM is now available in every Cowork session

---

## For AI Agents (Codex / API Access)

The knowledge reference files in this repo are structured for direct AI consumption:

- **[`SKILL.md`](SKILL.md)** — complete agent instructions (operations, vault schema, tone)
- **[`references/obsidian-digital-garden.md`](references/obsidian-digital-garden.md)** — seed knowledge document

Each reference file includes YAML frontmatter with title, tags, source, and a TL;DR summary
at the top, making it easy to parse and embed into agent context windows.

To use KIM's knowledge in a Codex or API workflow:
```python
# Example: fetch seed knowledge for context
import requests

base = "https://raw.githubusercontent.com/gotsetthawut/kim-agent/main"
skill    = requests.get(f"{base}/SKILL.md").text
seed_doc = requests.get(f"{base}/references/obsidian-digital-garden.md").text
# Inject into your agent's system prompt or context
```

---

## Repository Structure

```
kim-agent/
├── SKILL.md                              ← Claude Agent skill instructions
├── README.md                             ← this file
├── .gitignore
├── create-kim-skill.bat                  ← packages kim-agent/ → kim.skill
└── references/
    └── obsidian-digital-garden.md        ← seed knowledge document
```

---

## Owner

Built by **gotsetthawut** as part of a personal Claude Agent setup.
Seed knowledge sourced from: [gotsetthawut/obsidian-digital-garden](https://github.com/gotsetthawut/obsidian-digital-garden)
