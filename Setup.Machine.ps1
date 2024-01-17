param
(
  [Parameter(Mandatory)]
  [string]
  $DevRoot
)
#============================================================================================================
Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Starting Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host 

Write-Host "** Creating Folder: $DevRoot\Docker" -ForegroundColor Blue
Copy-Item "$PSScriptRoot\Docker"  -Destination "$DevRoot" -Recurse -Force 
New-Item -ItemType Directory -ErrorAction SilentlyContinue -Path "$DevRoot\Docker\Volumes\MSSQL"
New-Item -ItemType Directory -ErrorAction SilentlyContinue -Path "$DevRoot\Docker\Volumes\Azurite"

Write-Host "** Creating Folder: $DevRoot\Install" -ForegroundColor Blue
Copy-Item "$PSScriptRoot\Install" -Destination "$DevRoot" -Recurse -Force

Write-Host "** Creating Folder: $DevRoot\Source" -ForegroundColor Blue
New-Item -ItemType Directory -ErrorAction SilentlyContinue -Path "$DevRoot\Source"

Write-Host "** Creating Folder: $DevRoot\Support" -ForegroundColor Blue
Copy-Item "$PSScriptRoot\Support" -Destination "$DevRoot" -Recurse -Force
Write-Host 

.\Install\Winget.ps1

Write-Host
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "* Finished Developer Machine Setup               " -ForegroundColor Blue
Write-Host "*************************************************" -ForegroundColor Blue
Write-Host "*                PLEASE RESTART                 *" -ForegroundColor Red
Write-Host "*************************************************" -ForegroundColor Blue  
