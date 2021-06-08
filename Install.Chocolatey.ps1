Write-Host "Installing Chocolatey"                             -ForegroundColor Cyan
Write-Host "*************************************************" -ForegroundColor Cyan

$path = "$env:ProgramData\chocolatey\choco.exe"

$installed = (Test-Path $path);
if ($installed) 
{    
    Write-Host "Already Installed."  -ForegroundColor Green
    Write-Host
    return
}

Write-Host "Installing Feature" -ForegroundColor Yellow
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))