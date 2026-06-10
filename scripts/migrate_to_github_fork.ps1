# Creates a real GitHub fork and pushes local main to it.
# Prerequisite: rename old repo to neon-player-custom-GAIT-archive on GitHub first.

$ErrorActionPreference = "Stop"
$ForkName = "neon-player-custom-GAIT"
$Upstream = "pupil-labs/neon-player"

gh auth status | Out-Null

$repoRoot = Split-Path $PSScriptRoot -Parent
Set-Location $repoRoot

Write-Host "Working directory: $repoRoot"

if (git status --porcelain) {
    throw "Working tree not clean. Commit or stash changes first."
}

# GitHub redirects renamed repos: thommakoon/neon-player-custom-GAIT may still
# resolve to neon-player-custom-GAIT-archive. Only treat it as "taken" if the
# repo's actual name equals $ForkName.
$repoJson = gh repo view "thommakoon/$ForkName" --json name,isFork 2>$null
if ($LASTEXITCODE -eq 0) {
    $repo = $repoJson | ConvertFrom-Json
    if ($repo.name -eq $ForkName) {
        if ($repo.isFork) {
            Write-Host "Fork thommakoon/$ForkName already exists."
        } else {
            throw "thommakoon/$ForkName exists but is NOT a fork. Rename or delete it first."
        }
    } else {
        Write-Host "Name is free (redirects to $($repo.name))."
        Write-Host "Creating fork $ForkName from $Upstream ..."
        gh repo fork $Upstream --fork-name $ForkName --remote=false
    }
} else {
    Write-Host "Creating fork $ForkName from $Upstream ..."
    gh repo fork $Upstream --fork-name $ForkName --remote=false
}

Write-Host "Setting origin to fork ..."
git remote set-url origin "https://github.com/thommakoon/$ForkName.git"
if (-not (git remote | Select-String -Pattern "^upstream$" -Quiet)) {
    git remote add upstream "https://github.com/$Upstream.git"
}

Write-Host "Pushing main to fork ..."
git push -u origin main

Write-Host ""
Write-Host "Done. Open: https://github.com/thommakoon/$ForkName"
Write-Host "Confirm it shows: forked from pupil-labs/neon-player"
