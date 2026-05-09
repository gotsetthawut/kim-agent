---
title: Obsidian Digital Garden Plugin — Complete Knowledge Document
repo: https://github.com/gotsetthawut/obsidian-digital-garden
upstream: https://github.com/oleeskild/obsidian-digital-garden
tags: [obsidian, plugin, digital-garden, typescript, svelte, publishing]
updated: 2026-05-09
summary: >
  Complete reference for the obsidian-digital-garden Obsidian plugin.
  Covers architecture, features, setup, publishing workflow, customization,
  and local development. This is gotsetthawut's personal fork of oleeskild/obsidian-digital-garden.
---

# Obsidian Digital Garden Plugin

## TL;DR

An Obsidian plugin that publishes selected notes from your vault to a website (your "digital garden").
Only notes explicitly marked `dg-publish: true` are ever published — private notes stay private.
Free, open-source, self-hosted via Vercel/Netlify, or managed via Forestry.md.

---

## Repository Details

| Field | Value |
|-------|-------|
| Owner | gotsetthawut (fork of oleeskild/obsidian-digital-garden) |
| URL | https://github.com/gotsetthawut/obsidian-digital-garden |
| Language | TypeScript (83.4%), Svelte (12.9%), CSS (2.6%), JavaScript (1.1%) |
| Entry point | `main.ts` |
| Build tool | esbuild (`esbuild.config.mjs`) |
| Test runner | Jest (`jest.config.js`) |
| Package manager | npm (also has bun.lockb) |
| Node version | .nvmrc managed |
| Linting | ESLint + Prettier |
| Git hooks | Husky |

---

## What It Does

Turns an Obsidian vault into a publicly accessible website. Core concept:
- **Selective publishing**: Only notes with `dg-publish: true` in frontmatter are published
- **No accidental leaks**: Linked notes are never auto-published
- **Digital garden philosophy**: Notes are living ideas that grow over time, not static blog posts

---

## Key Features

### Content Support
- Basic Markdown, wikilinks (`[[Note]]`, `[[Note#Header]]`)
- Obsidian Bases, Dataview queries (codeblocks, inline, dataviewjs)
- Canvas files, Excalidraw drawings, embedded images
- Embedded PDFs (up to 20MB, rendered inline)
- Callouts/Admonitions, Code Blocks, MathJax
- Highlighted text, Footnotes, Mermaid diagrams, PlantUML diagrams

### Navigation & Discovery
- Fast search with live preview
- Filetree navigation, Backlinks
- Local graph, Global graph
- Table of contents, Link previews on hover

### Customization
- Obsidian Themes support, Style Settings plugin support
- Customizable via CSS variables
- Custom filters (regex-based content transformation)
- Note icons, Timestamps (created/updated), Customizable UI text

### Privacy & Control
- Only `dg-publish: true` notes are published
- No automatic publishing of linked notes

### Hosting Options
- **Vercel** — One-click deploy, automatic builds (primary/recommended)
- **Netlify** — Alternative hosting
- **Forestry.md** — Managed hosting, no GitHub setup required (open beta)

---

## Frontmatter Properties

```yaml
# Required for home page (one note only)
dg-home: true

# Required to publish any note
dg-publish: true

# Optional
dg-permalink: custom-url-path
dg-hide: true
dg-hide-in-graph: true
dg-pinned: true
dg-note-icon: 1
```

---

## Initial Setup (~10 minutes)

1. Create GitHub + Vercel accounts
2. Open [oleeskild/digitalgarden](https://github.com/oleeskild/digitalgarden) → click "Deploy to Vercel"
3. Create a Fine-grained GitHub Personal Access Token:
   - Permissions: **Contents: Read and write**, **Pull requests: Read and write**
   - Scope: only the garden repo
4. Obsidian → Settings → Digital Garden → enter: GitHub username, repo name, token
5. Create first note with `dg-home: true` + `dg-publish: true`
6. Command palette → `Digital Garden: Publish Single Note`
7. Visit Vercel URL — appears within ~1 minute

---

## Publishing Workflow

```
Obsidian note (dg-publish: true)
  → "Publish Single Note" command
    → Plugin pushes markdown + images to GitHub repo
      → Vercel detects push → rebuilds static site → live (~1 min)
```

Commands:
- `Digital Garden: Publish Single Note`
- `Digital Garden: Publish Multiple Notes`

Template update: Settings → Site Template → Manage → "Create PR" → review Vercel preview → merge.

---

## Local Export (Self-Hosting / Preview)

1. Plugin settings → set **Local Export** path to local `digitalgarden/` folder
2. `Export Garden to Local Folder` command
3. In `digitalgarden/`: `npm run dev`

---

## CSS Customization

- Place CSS/SCSS in `src/site/styles/user/` — loads last, overrides everything
- CSS variables for: colors, typography, spacing, component styling

## Custom Components

- Nunjucks templates in `src/site/_includes/components/user/`
- Not overwritten by template updates

---

## Local Development

```bash
git clone https://github.com/gotsetthawut/obsidian-digital-garden
nvm install && nvm use
npm install
npm run dev
# Open src/dg-testVault in Obsidian for testing
```

### .env for test vault
```env
GITHUB_REPO=
GITHUB_TOKEN=
GITHUB_USERNAME=
FORESTRY_BASE_URL=https://api.forestry.md/app
FORESTRY_PAGE_NAME=
FORESTRY_API_KEY=
LOCAL_GARDEN_PATH=../digitalgarden
```

### Dev workflow
1. `npm run dev` (this repo) → builds plugin, copies to test vault
2. Open test vault in Obsidian → `Export Garden to Local Folder`
3. `npm run dev` (digitalgarden/) → serves with hot reload

---

## Project Structure

```
obsidian-digital-garden/
├── main.ts                    ← Obsidian plugin entry point
├── manifest.json              ← Plugin manifest
├── manifest-beta.json
├── versions.json
├── esbuild.config.mjs         ← Build config
├── jest.config.js             ← Test config
├── src/
│   ├── dg-testVault/          ← Test vault for development
│   └── (plugin source)
├── __mocks__/
├── scripts/
├── img/
├── .github/                   ← GitHub Actions
└── .husky/                    ← Git hooks
```

---

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Plugin language | TypeScript |
| UI components | Svelte |
| Bundler | esbuild |
| Testing | Jest |
| Linting/Formatting | ESLint + Prettier |
| Git hooks | Husky |
| Garden site engine | Eleventy (11ty) |

Garden site custom code: `src/helpers/userSetup.js` (survives template updates).

---

## Forestry.md (No-GitHub Alternative)

1. Create account at forestry.md
2. Get Garden Key from dashboard
3. Obsidian → Digital Garden settings → enter Garden Key
4. Publish directly — no GitHub/Vercel needed

---

## Community & Ecosystem

- **Docs**: https://docs.forestry.md/
- **Discord**: https://discord.gg/UsPH74nEVS
- **Community gardens**: https://vaults.obsidian-community.com/
- **Upstream**: https://github.com/oleeskild/obsidian-digital-garden

Projects built on this plugin: Flowershow, Quartz Syncer, Enveloppe.

---

## Common Issues & Tips

| Issue | Solution |
|-------|----------|
| Linked note not showing | It also needs `dg-publish: true` |
| Note not appearing after publish | Wait ~1 min for Vercel rebuild |
| CSS overridden by template update | Use `src/site/styles/user/` only |
| Access token expired | Regenerate Fine-grained PAT, update in plugin settings |
| Updating template | Always via PR; check Vercel preview first |
| Local dev issues | Use `src/dg-testVault`, not personal vault |
