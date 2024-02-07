# Setup Developer Machine

## Disclaimer
This repo is intended to help me when I need to set up a fresh development machine and keep record of all applications and settings I usually execute manually.

Feel free to use it but I strongly suggest to read all powershell scripts to certify they are safe for you to execute.

**ALWAYS READ THE CODE YOU ARE USING FROM 3RD-PARTIES**

## Installation

1. Download repo to a temporary folder
2. Execute Setup.Machine.ps1. It will:
    * Create Development Folders
    * Copy support files related to Docker and Resharper
    * Install applications focused on C# Development.

## Usage
Run a powershel session with elevated privileges

Setup basic packages and it can be executed multiple times
```powershell
    .\Setup.Machine.ps1
```
Development Root Folder is C:\Development
```powershell
    .\Setup.Machine.ps1 -$DevRoot 'C:\Development'
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
