param
(
  [Parameter(Mandatory)]
  [string]
  $DevRoot
)

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
Write-Host

.\Install\EnvFolders.ps1 -DevRoot $DevRoot
Copy-Item "$PSScriptRoot\Support" -Destination $devRoot -Recurse -Force
Copy-Item "$PSScriptRoot\Install" -Destination $devRoot -Recurse -Force
Copy-Item "$PSScriptRoot\Docker"  -Destination $devRoot -Recurse -Force


.\Install\Winget.ps1
.\Install\ChocoPackages.ps1
Install-Windows-Feature -featureName "Containers-DisposableClientVM"        #Install Sandbox

Write-Host
RefreshEnv

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Finished Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*                PLEASE RESTART                 *" -ForegroundColor Red
Write-Host "*************************************************" -ForegroundColor Blue  
