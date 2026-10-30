# Open Typography Foundation - Thaana (Dhivehi / Maldives) Font Installer
$ErrorActionPreference = "Stop"

$FontsFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Fonts)
Write-Host "Installing 18+ Thaana (Dhivehi / Maldives) fonts into Windows..." -ForegroundColor Cyan

$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$fontFiles = Get-ChildItem -Path $CurrentDir -Include "*.ttf", "*.otf" -Recurse

foreach ($font in $fontFiles) {
    $targetPath = Join-Path $FontsFolder $font.Name
    if (-not (Test-Path $targetPath)) {
        Copy-Item -Path $font.FullName -Destination $targetPath -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $font.Name -Value $font.Name -PropertyType String -Force | Out-Null
        Write-Host "  Installed: $($font.Name)" -ForegroundColor Green
    }
}

Write-Host "Completed Thaana (Dhivehi / Maldives) font installation!" -ForegroundColor Cyan
