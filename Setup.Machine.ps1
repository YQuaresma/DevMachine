

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

Install-Windows-Feature -featureName "Containers-DisposableClientVM"        #Install Sandbox

.\Install.Winget.ps1
.\Install.ChocoPackages.ps1

RefreshEnv

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Finished Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*                PLEASE RESTART                 *" -ForegroundColor Red
Write-Host "*************************************************" -ForegroundColor Blue  