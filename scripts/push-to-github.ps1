# GitHub にリポジトリを作成して push する（要: GitHub CLI・初回のみログイン）
# 使い方（プロジェクト直下で）:
#   powershell -ExecutionPolicy Bypass -File .\scripts\push-to-github.ps1
# リポジトリ名を変える場合:
#   powershell -ExecutionPolicy Bypass -File .\scripts\push-to-github.ps1 -RepoName "my-app-name"

param(
    [string]$RepoName = "homon-kensu-app"
)

$ErrorActionPreference = "Stop"
# このファイルは プロジェクト/scripts/ に置く（1つ上がリポジトリルート）
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location $root

# winget 直後など PATH に gh が無い場合の救済
$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    $env:Path += ";$env:ProgramFiles\GitHub CLI"
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Error "GitHub CLI (gh) が見つかりません。winget install GitHub.cli を実行してください。"
}

gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host ">>> 初回だけ: GitHub へログインします（ブラウザが開きます）。" -ForegroundColor Cyan
    Write-Host ""
    gh auth login -h github.com -p https -w
}

Write-Host ""
Write-Host ">>> リポジトリ '$RepoName' を作成して push します..." -ForegroundColor Cyan
gh repo create $RepoName --private --source=. --remote=origin --push

Write-Host ""
Write-Host "完了。GitHub のページでリポジトリ URL を確認してください。" -ForegroundColor Green
