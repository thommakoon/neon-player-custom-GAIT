# Migrate to a real GitHub fork (Option B)

Your repo `neon-player-custom-GAIT` was created by push, not by GitHub **Fork**.
This guide recreates it as a true fork of `pupil-labs/neon-player`.

## Prerequisites

- GitHub CLI: `gh auth login`
- Local branch `main` is clean and pushed to the old repo (backup)

## Steps

### 1. Rename the old repo (GitHub website)

1. Open https://github.com/thommakoon/neon-player-custom-GAIT/settings
2. **Repository name** → `neon-player-custom-GAIT-archive`
3. **Rename**

This frees the name `neon-player-custom-GAIT` and keeps a backup.

### 2. Create the real fork

```powershell
cd path\to\neon-player
gh auth login
.\scripts\migrate_to_github_fork.ps1
```

Or manually:

```powershell
gh repo fork pupil-labs/neon-player --fork-name neon-player-custom-GAIT --remote=false
git remote set-url origin https://github.com/thommakoon/neon-player-custom-GAIT.git
git push -u origin main
```

### 3. Verify on GitHub

- Repo page shows **forked from pupil-labs/neon-player**
- **Sync fork** button is visible
- CI passes on Actions tab

### 4. Delete archive (optional, after verification)

https://github.com/thommakoon/neon-player-custom-GAIT-archive/settings → Delete repository

### 5. Remotes (final)

```text
origin   → https://github.com/thommakoon/neon-player-custom-GAIT.git  (fork)
upstream → https://github.com/pupil-labs/neon-player.git
```

```powershell
git remote -v
git fetch upstream
```

## Custom commits preserved

These remain on `main` after push:

- Camera K matrix plugin
- Scene extrinsics plugin
- IMU yaw documentation
- AI attribution docs + commit template
- Upstream merge + tests
