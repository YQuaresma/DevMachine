################################################
function AppValidation {
    param (
        $id,
        $path
    )
    
    Write-Host "Verify $id : " -ForegroundColor Yellow -NoNewline
    
    $installed = (Test-Path $path);
    if (-Not $installed) 
    {
        Write-Host "Failed"  -ForegroundColor Red
        return $installed
    }
    
    Write-Host "Installed"  -ForegroundColor Green
    return $installed
}