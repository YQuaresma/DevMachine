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
function Install-Windows-Feature {
    param (
        $featureName
    )

    Write-Host "Installing " $featureName                          -ForegroundColor Cyan
    Write-Host "*************************************************" -ForegroundColor Cyan
    
    $result = Get-WindowsOptionalFeature -FeatureName $featureName -Online

    if ($null -eq $result) 
    {
        Write-Host "Feature Name is invalid ["$featureName"]"  -ForegroundColor Red
        return
    }

    if ($result.State -eq "Enabled")
    {
        Write-Host "Already Installed."  -ForegroundColor Green
        Write-Host
        return
    }
        
    Write-Host "Installing Feature" -ForegroundColor Yellow
    Enable-WindowsOptionalFeature -FeatureName $featureName -Online -NoRestart
    
    Write-Host
}
#============================================================================================================
Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Starting Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue

Install-Windows-Feature -featureName "Microsoft-Windows-Subsystem-Linux"    #Install WSL2
Install-Windows-Feature -featureName "VirtualMachinePlatform"               #Install WSL2
Install-Windows-Feature -featureName "Containers-DisposableClientVM"        #Install Sandbox

.\Install.Winget.ps1
.\Install.Chocolatey.ps1

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
Install-Choco-Package -id ccleaner
Install-Choco-Package -id everything
Install-Choco-Package -id notepadplusplus
Install-Choco-Package -id powertoys
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
Install-Choco-Package -id sourcetree


Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* IDE and Cloud Tools                            " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Install-Choco-Package -id microsoft-windows-terminal
Install-Choco-Package -id microsoftazurestorageexplorer
Install-Choco-Package -id azure-cli
Install-Choco-Package -id azure-cosmosdb-emulator
Install-Choco-Package -id visualstudio2019community
Install-Choco-Package -id vscode
Install-Choco-Package -id ssms

RefreshEnv

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Finished Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*                PLEASE RESTART                 *" -ForegroundColor Red
Write-Host "*************************************************" -ForegroundColor Blue  