$vdilist = Get-Content C:\temp\list.txt

foreach ($vdi in $vdilist) {
Write-Host "Working on $vdi"
    if (!(Test-Path -Path \\$vdi\c$\temp)) {
        New-Item -ItemType Directory -Path \\$vdi\c$ -Name Temp
        Copy-Item "\\server\install.bat" -Destination \\$vdi\c$\temp -Force
        Copy-Item "\\server\remove.bat" -Destination \\$vdi\c$\temp -Force
        Copy-Item "\\server\VDAWorkstationSetup_1912.exe" -Destination \\$vdi\c$\temp -Force
    }
    else {
        Copy-Item "\\server\install.bat" -Destination \\$vdi\c$\temp -Force
        Copy-Item "\\server\remove.bat" -Destination \\$vdi\c$\temp -Force
        Copy-Item "\\server\VDAWorkstationSetup_1912.exe" -Destination \\$vdi\c$\temp -Force

    }
    Invoke-Command -ComputerName $vdi -Scriptblock {
        $time = (Get-Date).AddMinutes(3)
        $action = New-ScheduledTaskAction -Execute 'c:\temp\remove.bat'
        $trigger = New-ScheduledTaskTrigger -Once -At $time
        $principal = New-ScheduledTaskPrincipal  -RunLevel Highest -UserID "NT AUTHORITY\SYSTEM" -LogonType S4U

        Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "VDAUninstall" -Description "Citrix VDA Uninstall" 
    }

    Invoke-Command -ComputerName $vdi -Scriptblock {
        $action = New-ScheduledTaskAction -Execute 'c:\temp\install.bat'
        $trigger = New-ScheduledTaskTrigger -AtStartup 
        $principal = New-ScheduledTaskPrincipal  -RunLevel Highest -UserID "NT AUTHORITY\SYSTEM" -LogonType S4U

        Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "VDAInstall" -Description "Citrix VDA Install" 

    } 


}

