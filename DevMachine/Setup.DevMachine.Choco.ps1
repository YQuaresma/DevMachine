################################################
function Install-Windows-Feature {
    param (
        $featureName
    )
    
    Write-Host "Verify $id : " -ForegroundColor Yellow -NoNewline

    #Get-WindowsOptionalFeature -FeatureName "*Linux*" -Online

    $isInstalled = $false;

    if (-Not $isInstalled)
    {
        Write-Host "* Installing "  -ForegroundColor Blue
        Enable-WindowsOptionalFeature -FeatureName $featureName -Online -NoRestart #-All 
        return
    }
    
    Write-Host "Installed"  -ForegroundColor Green
}

################################################
function Is-App-Installed {
    param (
        $id,
        $path
    )
    
    Write-Host "Verify $id : " -ForegroundColor Yellow -NoNewline
    
    if ($path -eq $null -or $path -eq "") {return $false};

    $installed = (Test-Path $path);
    if (-Not $installed) 
    {
        Write-Host "Failed"  -ForegroundColor Red
        return $installed
    }
    
    Write-Host "Installed"  -ForegroundColor Green
    return $installed
}

########################################################################
function Choco-Install {
    param (
        $id
    )
    
    Write-Host
    Write-Host "*************************************************" -ForegroundColor Cyan
    Write-Host "Installing " $id                                   -ForegroundColor Cyan
    Write-Host "*************************************************" -ForegroundColor Cyan
    choco install $id --yes
}

Install-Windows-Feature -featureName "Microsoft-Windows-Subsystem-Linux"    #Install WSL2
Install-Windows-Feature -featureName "VirtualMachinePlatform"               #Install WSL2
Install-Windows-Feature -featureName "Containers-DisposableClientVM"        #Install Sandbox

#$isInstalled = Is-App-Installed -id "Sandbox"  -path "$env:windir\System32\WindowsSandbox.exe"
#if (-Not $isInstalled) 
#{
#    Write-Host "* Installing"  -ForegroundColor Blue
#    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
#}

$isInstalled = Is-App-Installed -id "Winget"  -path "$env:localappdata\Microsoft\WindowsApps\winget.exe"
if (-Not $isInstalled)
{
    .\Install.Winget.ps1
}

$isInstalled = Is-App-Installed -id "Chocolatey"  -path "$env:ProgramData\chocolatey\choco.exe"
if (-Not $isInstalled)
{
    Write-Host "* Installing"  -ForegroundColor Blue
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

Choco-Install 1Password
Choco-Install powertoys

Choco-Install notepadplusplus
Choco-Install winmerge
Choco-Install ccleaner

Choco-Install Zoom
Choco-Install onedrive
Choco-Install everything
Choco-Install treesizefree

Choco-Install firefox
Choco-Install googlechrome

Choco-Install git
Choco-Install sourcetree

Choco-Install microsoft-windows-terminal
Choco-Install microsoftazurestorageexplorer
Choco-Install azure-cli
Choco-Install azure-cosmosdb-emulator
Choco-Install visualstudio2019community
Choco-Install vscode
Choco-Install ssms