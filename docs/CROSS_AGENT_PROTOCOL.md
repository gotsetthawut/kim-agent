# Cross-Agent Protocol

This document defines how agents in the gotsetthawut AI Agent ecosystem communicate and hand off knowledge to each other.

---

## The Ecosystem

| Agent | Role | Repo |
|-------|------|------|
| **BIVA** | Business Idea Validation Analyst | gotsetthawut/BIVA |
| **KIM** | Knowledge Intelligence Manager (shared vault) | gotsetthawut/kim-agent |
| **Thomas** | Personal Teaching Agent | gotsetthawut/thomas-agent |
| **Atlas** | Coming soon | gotsetthawut/atlas-agent |

**KIM is the central hub.** All agents write to KIM and read from KIM.

---

## Handoff Commands

### Sending Knowledge to KIM (any agent → KIM)

At the end of any session, output:

```
KIM STORE:
---
title: [PREFIX-NNNN]: [Title]
tags: [agent-source, topic, subtopic]
source: agent:[biva|thomas|atlas]
created: YYYY-MM-DD
updated: YYYY-MM-DD
summary: One-line summary.
---

[full document content]
```

The user pastes this into the KIM Chat Project or KIM Cowork skill.

### Retrieving from KIM (any agent → KIM)

To check if KIM already has knowledge on a topic before working:

```
KIM RETRIEVE: [topic or keyword]
```

KIM returns matching documents. The agent reads them and incorporates them before starting work.

### Requesting Another Agent (any agent → user → other agent)

Agents cannot directly invoke each other — the user routes between them. Standard handoff phrases:

- **BIVA → Thomas:** "I recommend learning more about [topic] before validating this idea. Ask Thomas: teach me [topic]."
- **Thomas → BIVA:** "Now that you understand [topic], you could validate a business idea around it. Ask BIVA to run an idea intake."
- **Any → KIM:** "This output should be stored in KIM. Copy the KIM STORE block above into your KIM session."

---

## Document Prefix Reference

| Agent | Document Type | Prefix |
|-------|--------------|--------|
| Thomas | Lesson note | LES |
| Thomas | Research report | RES |
| Thomas | Study guide | SGD |
| Thomas | Learning path | LPT |
| BIVA | Idea intake | IDEA |
| BIVA | Feasibility | FEAS |
| BIVA | Validation plan | VAL |
| BIVA | Business case | CASE |
| BIVA | Decision log | DEC |

---

## KIM Tags Convention

All agents tag their documents consistently so KIM can be searched across agent outputs:

| Tag | Meaning |
|-----|---------|
| `agent:thomas` | Created by Thomas |
| `agent:biva` | Created by BIVA |
| `teaching` | A lesson or study material |
| `validation` | A business validation document |
| `research` | A research report |
| `decision` | A GO/REVISE/HOLD/NO-GO decision |

---

## Cowork Session Protocol

When running all agents in a single Cowork session:

1. Load all skills: thomas.skill, kim.skill, biva.skill
2. Start with KIM: "KIM LIST" — see what is already in the vault
3. Invoke agents with their trigger phrases:
   - "teach me X" → Thomas activates
   - "validate this idea: X" → BIVA activates
   - "remember this / what do we know about X" → KIM activates
4. After each agent completes, outputs are visible to all agents in the shared context
5. Route KIM STORE commands to KIM immediately after each output

---

## Chat Project Protocol

When using separate Chat Projects:

1. **Work in the relevant agent project** (e.g. Thomas for learning)
2. **Copy the KIM STORE block** from the output
3. **Switch to KIM project** and paste it — KIM stores it
4. **Return to your project** and continue

The KIM project is always open in a separate browser tab.