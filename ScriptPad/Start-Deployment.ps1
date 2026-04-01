Write-Host -ForegroundColor Green "Updating OSD PowerShell Module"
Install-Module OSD -Force

Write-Host  -ForegroundColor Green "Importing OSD PowerShell Module"
Import-Module OSD -Force   

#=======================================================================
#   [OS] Params and Start-OSDCloud
#=======================================================================
$Params = @{
    OSVersion = "Windows 11"
    OSBuild = "25H2"
    OSEdition = "Enterprise"
    OSLanguage = "pt-PT"
    OSLicense = "Volume"
    ZTI = $true
    Firmware = $false
}
Start-OSDCloud @Params


#================================================
#  [PostOS] SetupComplete CMD Command Line
#================================================
Write-Host -ForegroundColor Green "Create C:\Windows\Setup\Scripts\SetupComplete.cmd"
$SetupCompleteCMD = @'
try {
    if (-not (Test-Path -Path "C:\Windows\Panther")) {
        New-Item -Path "C:\Windows\Panther" -ItemType Directory -Force
    }

powershell.exe -Command Set-ExecutionPolicy RemoteSigned -Force
$UnattendURL = "https://raw.githubusercontent.com/nunomeiras/OSDCloud/autounattend.xml"
$UnattendPath = "C:\Windows\Panther\Unattend.xml"
Invoke-WebRequest -Uri $UnattendURL -OutFile $UnattendPath


'@
$SetupCompleteCMD | Out-File -FilePath 'C:\Windows\Setup\Scripts\SetupComplete.cmd' -Encoding ascii -Force

#=======================================================================
#   Restart-Computer
#=======================================================================
Write-Host  -ForegroundColor Green "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot




# Download autounattend


# Aplicar deployment
Start-OSDCloud -UnattendPath $UnattendPath
