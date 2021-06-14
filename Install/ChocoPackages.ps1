#============================================================================================================
function Install-Choco-Package  {
    param (
        $id,
        $params
    )
    
    Write-Host "Installing " $id                                   -ForegroundColor Cyan
    Write-Host "*************************************************" -ForegroundColor Cyan
    Write-Host $params
     if ($null -eq $params)
     {
        choco install $id --yes
     }
     else {        
        choco install $id --yes --params "${params}"
     }
    Write-Host
}
#============================================================================================================

Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "Installing Chocolatey"                             -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue

$path = "$env:ProgramData\chocolatey\choco.exe"

$installed = (Test-Path $path);
if ($installed) 
{    
    Write-Host "Already Installed."  -ForegroundColor Green
    Write-Host    
}
else 
{
    Write-Host "Installing Feature" -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))        
}

Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Productive Tools                               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Install-Choco-Package -id firefox
Install-Choco-Package -id googlechrome
Install-Choco-Package -id onedrive
Install-Choco-Package -id Zoom
Install-Choco-Package -id 1Password

Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*Support Tools                                   " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Install-Choco-Package -id 7zip
Install-Choco-Package -id everything
Install-Choco-Package -id notepadplusplus
Install-Choco-Package -id powertoys
Install-Choco-Package -id putty.install
Install-Choco-Package -id sysinternals  -params "/InstallDir:${env:ProgramFiles(x86)}\Sysinternals"
Install-Choco-Package -id treesizefree
Install-Choco-Package -id winmerge


Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Dev Tools                                      " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Install-Choco-Package -id chocolateygui
Install-Choco-Package -id choco-cleaner
Install-Choco-Package -id git
Install-Choco-Package -id gsudo
Install-Choco-Package -id Linqpad
Install-Choco-Package -id insomnia-rest-api-client
Install-Choco-Package -id nswagstudio 
Install-Choco-Package -id Postman
Install-Choco-Package -id pwsh
Install-Choco-Package -id smartgit
Install-Choco-Package -id docker-desktop

Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* IDE and Cloud Tools                            " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Install-Choco-Package -id microsoft-windows-terminal
Install-Choco-Package -id microsoftazurestorageexplorer
Install-Choco-Package -id azure-cli
Install-Choco-Package -id visualstudio2019community
Install-Choco-Package -id vscode
Install-Choco-Package -id ssms
Install-Choco-Package -id resharper-ultimate-all -params "/PerMachine /NoCpp /NoTeamCityAddin"