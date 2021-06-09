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
function New-Dev-Folder {
param (
        [string] $folder,
        [string] $envVar = ""
    )
    
    if ($envVar -ne "")
    {
        [Environment]::SetEnvironmentVariable($envVar , $folder.TrimEnd('\')  , 'Machine')
    }

    [System.IO.Directory]::CreateDirectory($folder.TrimEnd('\')) | Out-Null
    
    Write-Host "Creating Folder : " -NoNewline
    Write-Host $folder -ForegroundColor Green
}

#============================================================================================================

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Starting Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host

New-Dev-Folder -folder $devRoot -envVar "DevRoot";
New-Dev-Folder -folder "$devRoot\Source" -envVar "DevSource";

Copy-Item "$PSScriptRoot\Support" -Destination $devRoot -Recurse -Force
Copy-Item "$PSScriptRoot\Install" -Destination $devRoot -Recurse -Force

Install-Windows-Feature -featureName "Containers-DisposableClientVM"        #Install Sandbox

.\Install\Winget.ps1
.\Install\ChocoPackages.ps1

Write-Host
RefreshEnv

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Finished Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*                PLEASE RESTART                 *" -ForegroundColor Red
Write-Host "*************************************************" -ForegroundColor Blue  
