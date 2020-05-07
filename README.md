# Citrix-VDA-Upgrade

Scripts to upgrade Citrix VDA agent

## Description

Upgrade Citrix VDA agent from one version to another version. Example 7.15 LTSR to 1912 LTSR.

### Prerequisites

Download VDAWorkstationSetup_1912.exe from citrix downloads page. 

### Usage

*  Customize and copy install.bat, remove.bat and VDAWorkstationSetup_1912.exe to a network share. 
*  Run VDA upgrade.ps1 file. It will copy install.bat, remove.bat, and VDAWorkstationSetup_1912.exe from network share to c:\temp on        every VDI in the list.

### How does it work

*  Creates Scheduled tasks - One for uninstalling existing VDA agent and another for installing new VDA agent.
*  Executes VDAUninstall scheduled task first. This scheduled task runas after 3 minutes it is created. Once started, it runs remove.bat    file and restart the VDA.
*  After reboot, it runs VDAInstall scheduled task. This scheduled task runs install.bat file. No user login is required.
*  After installation is complete, it deletes install.bat, remove.bat, VDAWorkstationSetup_1912.exe files from c:\temp and VDAuninstall,    VDAInstall scheduled tasks.

### Built With

* [PowerShell](https://en.wikipedia.org/wiki/PowerShell)
* [Batch Script](https://en.wikipedia.org/wiki/Batch_file)

### Authors

* **Tech Guy** - [TechScripts](https://github.com/TechScripts)

### Contributing

Please follow [github flow](https://guides.github.com/introduction/flow/index.html) for contributing.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
