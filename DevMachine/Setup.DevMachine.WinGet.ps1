################################################
function AppValidation {
    param (
        $id,
        $path
    )
    
    Write-Host "Verify $id : " -ForegroundColor Yellow -NoNewline
    
    if ($path -eq $null -or $path -eq "") {return $false};

    $installed = (Test-Path $path);
    if (-Not $installed) 
    {
        Write-Host "Failed"  -ForegroundColor Red
        return $installed
    }
    
    Write-Host "Installed"  -ForegroundColor Green
    return $installed
}
########################################################################

#$isInstalled = AppValidation -name "Sandbox"  -path "$env:windir\System32\WindowsSandbox.exe"
#if (-Not $isInstalled) 
#{
#    Write-Host "* Installing"  -ForegroundColor Blue
#    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
#}
#
#$isInstalled = AppValidation -name "Winget"  -path "$env:localappdata\Microsoft\WindowsApps\winget.exe"
#if (-Not $isInstalled) , 
#{
#    .\Install.Winget.ps1
#}


$wingetFiles = @(
    @{id = "Atlassian.Sourcetree"                  ; rootFolder = ${env:ProgramFiles(x86)} ; folder = "Atlassian\Sourcetree"                  ; setLocation = $false},
    @{id = "gerardog.gsudo"                        ; rootFolder = ${env:ProgramFiles(x86)} ; folder = "Gsudo"                                 ; setLocation = $false},    
    @{id = "Microsoft.AzureStorageExplorer"        ; rootFolder = ${env:ProgramFiles(x86)} ; folder = "Microsoft Azure Storage Explorer"      ; setLocation = $false},
    @{id = "Microsoft.AzureCLI"                    ; rootFolder = ${env:ProgramFiles(x86)} ; folder = "Microsoft SDKs\Azure"                  ; setLocation = $false},
    #@{id = "Microsoft.VisualStudio.2019.Community" ; rootFolder = ${env:ProgramFiles(x86)} ; folder = "Microsoft\Visual Studio\2019\Community"; setLocation = $true},
    @{id = "Microsoft.AzureCosmosEmulator"         ; rootFolder = ${env:ProgramFiles}      ; folder = "Azure Cosmos DB Emulator"              ; setLocation = $false},
    @{id = "voidtools.everything"                  ; rootFolder = ${env:ProgramFiles}      ; folder = "Everything"                            ; setLocation = $false},
    @{id = "TimKosse.FilezillaClient"              ; rootFolder = ${env:ProgramFiles}      ; folder = "FileZilla FTP Client"                  ; setLocation = $false},
    @{id = "Git.Git"                               ; rootFolder = ${env:ProgramFiles}      ; folder = "Git"                                   ; setLocation = $false},
    @{id = "Mozilla.Firefox"                       ; rootFolder = ${env:ProgramFiles}      ; folder = "Mozilla Firefox"                       ; setLocation = $false},
    @{id = "Notepad++.Notepad++"                   ; rootFolder = ${env:ProgramFiles}      ; folder = "Notepad++"                             ; setLocation = $false},
    @{id = "Microsoft.PowerToys"                   ; rootFolder = ${env:ProgramFiles}      ; folder = "PowerToys"                             ; setLocation = $false},
    @{id = "Microsoft.SQLServerManagementStudio"   ; rootFolder = ${env:ProgramFiles}      ; folder = "Microsoft SQL Server"                  ; setLocation = $true},
    @{id = "Microsoft.VisualStudioCode"            ; rootFolder = ${env:ProgramFiles}      ; folder = "Microsoft\Visual Studio Code"          ; setLocation = $true},
    @{id = "WinMerge.WinMerge"                     ; rootFolder = ${env:ProgramFiles}      ; folder = "WinMerge"                              ; setLocation = $true},
    @{id = "AgileBits.1Password"                   ; rootFolder = ${env:localappdata}      ; folder = "1Password"                             ; setLocation = $false},
    @{id = "Microsoft.OneDrive"                    ; rootFolder = ${env:localappdata}      ; folder = "Microsoft\OneDrive"                    ; setLocation = $false},
    @{id = "Microsoft.WindowsTerminal"             ; rootFolder = $null                    ; folder = $null                                   ; setLocation = $false}
)

foreach ($wingetFile in $wingetFiles)
{
    $location = $null;
    if ($wingetFile.rootFolder -ne $null -and $wingetFile.folder -ne $null) 
    {    
        $location = Join-Path -Path $wingetFile.rootFolder -ChildPath $wingetFile.folder
    }
    
    $isInstalled = AppValidation -id $wingetFile.id  -path $location
    
    if (-Not $isInstalled) 
    {
        Write-Host "Installing " $wingetFile.id -ForegroundColor Blue

        if ($wingetFile.setLocation)
        {                
            winget install -e --id $wingetFile.id --location "$location"
        }
        else
        {
            winget install -e --id $wingetFile.id
        }
        Write-Host
    }
}

# winget install -e --id Docker.DockerDesktop


# winget install -e --id Microsoft.VisualStudio.2019.Community
# winget install -e --id JetBrains.dotUltimate