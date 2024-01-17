#============================================================================================================
function WingetInstall {
    param (
            [string] $id            
        )
    
    Write-Host "** Installing : $id" -ForegroundColor Blue
    winget install -e --id $id
    Write-Host
}

Write-Host
WingetInstall "Mozilla.Thunderbird"
WingetInstall "Mozilla.Firefox"
WingetInstall "Zoom.Zoom"
WingetInstall "voidtools.Everything.Lite"
WingetInstall "Notepad++.Notepad++"
WingetInstall "Microsoft.PowerToys"
WingetInstall "JAMSoftware.TreeSize.Free"
WingetInstall "WinMerge.WinMerge"
WingetInstall "Git.Git"
WingetInstall "Postman.Postman"
WingetInstall "Docker.DockerDesktop"
WingetInstall "Microsoft.Azure.StorageExplorer"
WingetInstall "Microsoft.SQLServerManagementStudio"
WingetInstall "Microsoft.VisualStudioCode"
WingetInstall "Microsoft.VisualStudio.2022.Community"
WingetInstall "JetBrains.Toolbox"
WingetInstall "Atlassian.Sourcetree"
WingetInstall "Google.Chrome"