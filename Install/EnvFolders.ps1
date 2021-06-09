param
(
  [Parameter(Mandatory)]
  [string]
  $DevRoot
)

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
New-Dev-Folder -folder $devRoot -envVar "DevRoot";
New-Dev-Folder -folder "$devRoot\Source" -envVar "DevSource";
New-Dev-Folder -folder "$devRoot\Support";
New-Dev-Folder -folder "$devRoot\Install";
