# AI-assisted development attribution

This fork uses [Cursor](https://cursor.com) for some development work. When a commit
was written or edited with meaningful AI assistance, add:

```
Co-authored-by: Cursor <cursoragent@cursor.com>
```

## When to include it

- AI helped write or refactor the change (not for typo-only edits you made alone).
- You used Cursor Agent to implement a feature, script, or documentation block.

## How to add it

**Option A — git trailer (recommended):**

```bash
git commit -m "your subject and body" \
  --trailer "Co-authored-by: Cursor <cursoragent@cursor.com>"
```

**Option B — in the commit message body:**

```
feat: example change

Short description of what changed.

Co-authored-by: Cursor <cursoragent@cursor.com>
```

**Option C — use the repo commit template** (after one-time setup):

```bash
git config commit.template commit.template
```

The template reminds you to keep or remove the `Co-authored-by` line before saving.

## What GitHub shows

- You remain the **author** (your git `user.email`).
- The commit page may list **Co-authored-by** when the trailer is present.
- Cursor typically does **not** appear as a separate repo **Contributors** graph entry.

## Thesis / lab disclosure

Example methods sentence:

> Code and analysis scripts were developed with assistance from Cursor (AI-assisted
> IDE); AI-assisted commits are marked with `Co-authored-by: Cursor
<cursoragent@cursor.com>` in version control.
