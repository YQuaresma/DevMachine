################################################
function AppValidation {
    param (
        $name,
        $path
    )
    
    Write-Host "Verify $name : " -ForegroundColor Yellow -NoNewline
    
    $installed = (Test-Path $path);
    if (-Not $installed) 
    {
        Write-Host "Failed"  -ForegroundColor Red
        return $installed
    }
    
    Write-Host "Installed"  -ForegroundColor Green
    return $installed
}