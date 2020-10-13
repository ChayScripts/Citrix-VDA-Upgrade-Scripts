if (!(Test-Path -Path C:\temp)) {
    New-Item -ItemType Directory -Path C:\ -Name Temp
    Copy-Item "\\server\Install.bat" -Destination C:\temp -Force
    Copy-Item "\\server\Remove.ps1" -Destination C:\temp -Force
    Copy-Item "\\server\VDAWorkstationSetup_1912.exe" -Destination C:\temp -Force
}
else {
    Copy-Item "\\server\Install.bat" -Destination C:\temp -Force
    Copy-Item "\\server\Remove.ps1" -Destination C:\temp -Force
    Copy-Item "\\server\VDAWorkstationSetup_1912.exe" -Destination C:\temp -Force

}

    $time = (Get-Date).AddMinutes(3)
    $action = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument "-noprofile -executionpolicy bypass -file c:\temp\Remove.ps1"
    $trigger = New-ScheduledTaskTrigger -Once -At $time
    $principal = New-ScheduledTaskPrincipal  -RunLevel Highest -UserID "NT AUTHORITY\SYSTEM" -LogonType S4U

    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "VDAUninstall" -Description "Citrix VDA Uninstall" 

    $action = New-ScheduledTaskAction -Execute 'c:\temp\install.bat'
    $trigger = New-ScheduledTaskTrigger -AtStartup 
    $principal = New-ScheduledTaskPrincipal  -RunLevel Highest -UserID "NT AUTHORITY\SYSTEM" -LogonType S4U

    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "VDAInstall" -Description "Citrix VDA Install" 
