Write-Host "*************************************************" -ForegroundColor Cyan
Write-Host "Installing Winget"                                 -ForegroundColor Cyan
Write-Host "*************************************************" -ForegroundColor Cyan

$path = "$env:localappdata\Microsoft\WindowsApps\winget.exe"

$installed = (Test-Path $path);
if ($installed) 
{    
    Write-Host "Already Installed."  -ForegroundColor Green
    Write-Host
    return
}

Write-Host "Installing Feature" -ForegroundColor Yellow

$tempFolder = Join-Path -Path $PSScriptRoot -ChildPath 'InstallWinget'
New-Item $tempFolder -ItemType Directory -ea 0 | Out-Null

# Set dependencies
$desktopAppInstaller = @{
    source      = 'https://github.com/microsoft/winget-cli/releases/download/v-0.4.11391-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle'
    savedName   = 'Microsoft.DesktopAppInstaller.appxbundle'
    savedFolder = $tempFolder
}

$vcLibsX86 = @{
    source      = 'https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx'
    savedName   = 'Microsoft.VCLibs.x86.14.00.Desktop.appx'
    savedFolder = $tempFolder 
}

$vcLibs64 = @{
    source      = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
    savedName   = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
    savedFolder = $tempFolder
}

$files = @($desktopAppInstaller, $vcLibsX86, $vcLibs64 )
foreach ($file in $files)
{
    $file.fileFullName = Join-Path -Path $file.savedFolder -ChildPath $file.savedName

    try
    { 
        if (-Not (Test-Path ($file.fileFullName)))
        {
            Write-Host " => Downloading $($file.source)" -ForegroundColor Blue
            Invoke-WebRequest -Uri $file.source -OutFile $file.fileFullName 
        }
    } 
    catch { throw "Error downloading $($file.source) ." }
}

Write-Host " => Installing VcLibsX86" -ForegroundColor Blue
Add-AppxPackage -Path $($vcLibsX86.fileFullName)

Write-Host " => Installing VcLibs64" -ForegroundColor Blue
Add-AppxPackage -Path $($vcLibs64.fileFullName)

Write-Host " => Installing DesktopInstaller" -ForegroundColor Blue
Add-AppxPackage -Path $($desktopAppInstaller.fileFullName)
