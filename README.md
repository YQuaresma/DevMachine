# Setup Developer Machine


## Installation

Use Powershell session as ADMIN and execute the Setup.Machine.ps1

```PowerShell
.\Setup.Machine.ps1
```

## Usage

Setup basic packages and it can be executed multiple times
```powershell
    .\Setup.Machine.ps1
```


Includes the installation of WSL (Ubuntu)
```powershell
    .\Setup.Machine.ps1 --InstallWSL $true
```

## Support Powershell Scripts

### Install.Chocolatey.ps1

### Install.Winget.ps1
### Install.WSL2.ps1

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)


# Foobar

Foobar is a Python library for dealing with word pluralization.

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install foobar.

```bash
pip install foobar
```

## Usage

```python
import foobar

foobar.pluralize('word') # returns 'words'
foobar.pluralize('goose') # returns 'geese'
foobar.singularize('phenomena') # returns 'phenomenon'
```
