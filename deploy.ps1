param(
  [Parameter(Mandatory=$true)][string]$Server,
  [string]$User = "root",
  [string]$IdentityFile = "",
  [string]$RemotePath = "/opt/visa-dashboard"
)

$ErrorActionPreference = "Stop"
$projectRoot = $PSScriptRoot
$archive = Join-Path ([System.IO.Path]::GetTempPath()) "visa-dashboard.tar.gz"
$sshArgs = @()
if ($IdentityFile) { $sshArgs += @("-i", $IdentityFile) }

try {
  tar -czf $archive --exclude=".git" --exclude="node_modules" -C $projectRoot .
  ssh @sshArgs "$User@$Server" "mkdir -p '$RemotePath'"
  scp @sshArgs $archive "$User@${Server}:/tmp/visa-dashboard.tar.gz"
  ssh @sshArgs "$User@$Server" "tar -xzf /tmp/visa-dashboard.tar.gz -C '$RemotePath' && cd '$RemotePath' && docker compose up -d --build && rm /tmp/visa-dashboard.tar.gz"
  Write-Host "Deployed: http://$Server"
}
finally {
  if (Test-Path -LiteralPath $archive) { Remove-Item -LiteralPath $archive -Force }
}
