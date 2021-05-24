# Initialize Temp Folder

$tempFolder = Join-Path -Path $PSScriptRoot -ChildPath 'WinGetInstall'
New-Item $tempFolder -ItemType Directory -ea 0 | Out-Null

# Check if Windows Sandbox is enabled
Write-Host "* Verify Sandbox Installation." -ForegroundColor Yellow
if (-Not (Test-Path "$env:windir\System32\WindowsSandbox.exe")) {
    Write-Host "Please run the statement below to enable Windows Sandbox."  
    Write-Host
    Write-Host "Enable-WindowsOptionalFeature -FeatureName ""Containers-DisposableClientVM"" -All -Online"
}
  
# Set dependencies
Write-Host "* Downloading Relevant files." -ForegroundColor Yellow
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
    $fileFullName = Join-Path -Path $file.savedFolder -ChildPath $file.savedName

    try
    { 
        if (-Not (Test-Path ($fileFullName)))
        {
            Write-Host "  => Downloading $($file.source)" -ForegroundColor Blue
            Invoke-WebRequest -Uri $file.source -OutFile $fileFullName
        }
    } 
    catch { throw "Error downloading $($file.source) ." }
}

# Create Bootstrap script
Write-Host "* Creating Boostrap File" -ForegroundColor Yellow
$bootstrapPs1Content = @"
Add-AppxPackage -Path $($vcLibsX86.savedName)
Add-AppxPackage -Path $($vcLibs64.savedName)
Add-AppxPackage -Path $($desktopAppInstaller.savedName)
"@

$bootstrapPs1FileName = 'Bootstrap.ps1'
$bootstrapPs1Content | Out-File (Join-Path -Path $tempFolder -ChildPath $bootstrapPs1FileName)

# Create Wsb file
Write-Host "* Creating Manisfest (WSB File)."  -ForegroundColor Yellow
$tempFolderInSandbox = Join-Path -Path 'C:\Users\WDAGUtilityAccount\Desktop' -ChildPath (Split-Path $tempFolder -Leaf)

$sandboxTestWsbContent = @"
<Configuration>
    <MappedFolders>
        <MappedFolder>
            <HostFolder>$tempFolder</HostFolder>
            <ReadOnly>true</ReadOnly>
        </MappedFolder>
    </MappedFolders>
    <LogonCommand>
        <Command>PowerShell Start-Process PowerShell -WorkingDirectory '$tempFolderInSandbox' -ArgumentList '-ExecutionPolicy Bypass -NoExit -File $bootstrapPs1FileName'</Command>
    </LogonCommand>
</Configuration>
"@

$sandboxTestWsbFileName = 'SandboxTest.wsb'
$sandboxTestWsbFile = Join-Path -Path $tempFolder -ChildPath $sandboxTestWsbFileName
$sandboxTestWsbContent | Out-File $sandboxTestWsbFile

Write-Host "* Starting Windows Sandbox and trying to install the manifest file."  -ForegroundColor Yellow
WindowsSandbox $SandboxTestWsbFile
Write-Host