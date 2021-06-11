# Setup Developer Machine

## Disclaimer
This repo is intended to help me when I need to set up a fresh development machine and keep record of all applications and set up I usually execute manually.

Feel free to use but I strongly suggest to read all powershell scripts to certify they are safe for you to execute.

**ALWAYS READ THE CODE YOU ARE USING FROM 3RD-PARTIES**

## Installation

1. Download repo to a temporary folder
2. Execute Setup.Machine.ps1. It will:
    * Create Environment Variables 
    * Create Development Folders
    * Copy support files related to Docker and Resharper
    * Install Windows Sandbox
    * Install WSL2 Ubuntu
    * Install Chocolatey
    * Install applications focused on C# Development.


## Usage

Setup basic packages and it can be executed multiple times
```powershell
    .\Setup.Machine.ps1
```

Development Root Folder is C:\Development
```powershell
    .\Setup.Machine.ps1 -$DevRoot 'C:\Development'
```

## Support Powershell Scripts

### Install.Chocolatey.ps1
### Install.Winget.ps1
### Install.WSL2.ps1

## License
[MIT](https://choosealicense.com/licenses/mit/)