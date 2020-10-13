#If user is logged in to the VDI, sends message to user every 2 minutes. After 10 minutes, VDA uninstall script will start.
#If user is not logged in, directly starts the VDA uninstall script.

$Timer = 10
while (Invoke-Command -ScriptBlock { quser }) {       
    if ($Timer -ne "0") {
        msg * "This machine will be restarted in $Timer mins for Citrix VDA upgrade activity. Please save your work and disconnect from VDI." 
        Start-Sleep -Seconds 120
        $Timer = $Timer - 2
    }
    else {
        msg * "Grace period complete. Starting VDA uninstall. Your VDI will reboot by itself. Try connecting after 2 hours." 
        start-sleep -seconds 5
        Start-Process "C:\Program Files\Citrix\XenDesktopVdaSetup\XenDesktopVdaSetup.exe" -ArgumentList "/REMOVEALL /QUIET /NOREBOOT" -Wait
        Start-Sleep -Seconds 5
        Restart-Computer -Confirm:$false -Force
    }
}
        
if (!(Invoke-Command -ScriptBlock { quser })) {
    Start-Process "C:\Program Files\Citrix\XenDesktopVdaSetup\XenDesktopVdaSetup.exe" -ArgumentList "/REMOVEALL /QUIET /NOREBOOT" -Wait
    Start-Sleep -Seconds 5
    Restart-Computer -Confirm:$false -Force
}

