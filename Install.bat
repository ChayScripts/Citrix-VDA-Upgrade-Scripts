REM change port number in below command.
REM Use citrix vda command line helper tool from citrix. https://support.citrix.com/article/CTX234824 if needed
REM Install new VDA agent, delete files and scheduled tasks. Finally reboot.

c:\temp\VDAWorkstationSetup_1912.exe /controllers "DDCFQDN1 DDCFQDN2 DDCFQDN3" /noreboot /quiet /enable_remote_assistance /disableexperiencemetrics /enable_framehawk_port /enable_hdx_ports /enable_hdx_udp_ports /exclude "AppDisks VDA Plug-in","Citrix Files for Outlook","Citrix Files for Windows","Citrix Personalization for App-V - VDA","Personal vDisk" /PORTNUMBER 0000 /COMPONENTS VDA
C:\Windows\system32\schtasks.exe /delete /tn VDAInstall /f
C:\Windows\system32\schtasks.exe /delete /tn VDAUninstall /f
del c:\temp\remove.bat /F
del c:\temp\VDAWorkstationSetup_1912.exe /F
C:\Windows\System32\timeout.exe /t 5
C:\Windows\System32\shutdown.exe /r /t 20 /f
del c:\temp\install.bat /F
