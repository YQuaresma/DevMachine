Import-Module -Name .\Setup.Module.psm1 -Force

#Write-Host "Verify Sandbox : " -ForegroundColor Yellow -NoNewline

$isInstalled = AppValidation -name "Sandbox"  -path "$env:windir\System32\WindowsSandbox.exe"
if (-Not $isInstalled) 
{
    Write-Host "* Installing"  -ForegroundColor Blue
    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
}

$isInstalled = AppValidation -name "Winget"  -path "$env:localappdata\Microsoft\WindowsApps\winget.exe"
if (-Not $isInstalled) 
{
    .\Install.Winget.ps1
}



$wingetFiles = @(
    @{id = "gerardog.gsudo"; path = $env:ProgramFiles + "\Gsudo" ; name = "gsudo.exe"},
    @{id = "WinMerge.WinMerge"; path = $env:ProgramFiles + "\WinMerge" ; name = "WinMergeU.exe"}
)


foreach ($wingetFile in $wingetFiles)
{
    $fullName = Join-Path -Path $wingetFile.path -ChildPath $wingetFile.name
    
    Write-Host $a

    $isInstalled = AppValidation -name $wingetFile.id  -path $fullName
    if (-Not $isInstalled) 
    {
        Write-Host "Installing " $wingetFile.id -ForegroundColor Blue
        winget install -e --id $wingetFile.id --location $wingetFile.path
    }
}

# winget install -e --id WinMerge.WinMerge
# winget install -e --id gerardog.gsudo
# winget install -e --id Mozilla.Firefox
# winget install -e --id Notepad++.Notepad++
# winget install -e --id AgileBits.1Password
# winget install -e --id Logitech.UnifyingSoftware
# winget install -e --id Microsoft.PowerToys
# winget install -e --id Microsoft.WindowsTerminal
# winget install -e --id Microsoft.OneDrive
# winget install -e --id voidtools.Everything
# winget install -e --id TimKosse.FilezillaClient

# winget install -e --id Microsoft.AzureStorageExplorer
# winget install -e --id Microsoft.AzureCLI
# winget install -e --id Microsoft.AzureCosmosEmulator

# winget install -e --id Docker.DockerDesktop
# winget install -e --id Datalust.Seq

# winget install -e --id Git.Git
# winget install -e --id Atlassian.Sourcetree

# winget install -e --id Microsoft.SQLServerManagementStudio
# winget install -e --id Microsoft.VisualStudioCode
# winget install -e --id Microsoft.VisualStudio.2019.Community
# winget install -e --id JetBrains.dotUltimate