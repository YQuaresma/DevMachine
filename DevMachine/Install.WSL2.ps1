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

Write-Host "WSL Update"                                        -ForegroundColor Cyan
Write-Host "*************************************************" -ForegroundColor Cyan
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi  -OutFile wsl_update_x64.msi -UseBasicParsing
.\wsl_update_x64.msi /passive /norestart
wsl --set-default-version 2

Write-Host 
Write-Host "Downloading and Installing Ubuntu"                 -ForegroundColor Cyan
Write-Host "*************************************************" -ForegroundColor Cyan
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx