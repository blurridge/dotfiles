---
name: fe
description: Manual invocation only. Use when explicitly invoked as $fe for frontend implementation, UI polish, design review, or visual product work.
---

# Frontend Design Workflow

Use this skill for frontend implementation, UI polish, design review, or visual product work.

Before editing:

1. Inspect the existing frontend stack, component conventions, styling system, and nearby UI patterns.
2. If a relevant Codex skill is available for frontend, web app, game, or image generation work, use it.
3. Preserve the existing product language and design system unless the user explicitly asks for a redesign.

Implementation rules:

- Build the usable experience, not a marketing landing page, unless the user explicitly asks for a landing page.
- Prefer established local components and helpers over new abstractions.
- Use icons for common actions when the app already has an icon system.
- Keep controls complete and ergonomic for the target workflow.
- Avoid nested cards, decorative orbs, one-note color palettes, cramped text, and overlapping UI.
- Ensure text fits in buttons, cards, sidebars, and compact panels on mobile and desktop.
- For apps that need a dev server, run it after implementation and provide the local URL.
- Verify the UI with available tests, builds, browser checks, or screenshots when feasible.

Treat any context after `$fe` as the actual frontend task.
