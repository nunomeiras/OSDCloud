#================================================
# OSDCloud Universal (HP / Lenovo / Dell)
#================================================

Start-OSDCloud `
    -OSVersion "Windows 11" `
    -OSLanguage pt-pt `
    -OSEdition Pro `
    -OSActivation Volume `
    -ZTI `
    -Firmware `
    -SkipAutopilot `
    -Restart `
    -PostOSCommand @'

Write-Host "=== Pós-instalação iniciada ==="

#------------------------------------------------
# 1. DETECTAR FABRICANTE
#------------------------------------------------
$Manufacturer = (Get-CimInstance Win32_ComputerSystem).Manufacturer

Write-Host "Fabricante detectado: $Manufacturer"

#------------------------------------------------
# 2. ATIVAR ADMIN
#------------------------------------------------
net user Administrator /active:yes
net user Administrator aifrdrd

#------------------------------------------------
# 3. DETECTAR USB
#------------------------------------------------
$Drives = Get-Volume | Where-Object { $_.DriveLetter }

#------------------------------------------------
# 4. INSTALL OFFICE (USB)
#------------------------------------------------
foreach ($Drive in $Drives) {
    $OfficePath = "$($Drive.DriveLetter):\Office\setup.exe"
    $Config = "$($Drive.DriveLetter):\Office\config.xml"

    if (Test-Path $OfficePath) {
        Write-Host "Office encontrado em $OfficePath"

        if (Test-Path $Config) {
            Start-Process $OfficePath -ArgumentList "/configure `"$Config`"" -Wait
        } else {
            Start-Process $OfficePath -ArgumentList "/quiet" -Wait
        }
        break
    }
}

#------------------------------------------------
# 5. DRIVERPACK (USB)
#------------------------------------------------
foreach ($Drive in $Drives) {
    $DriverPath = "$($Drive.DriveLetter):\Drivers"

    if (Test-Path $DriverPath) {
        Write-Host "Drivers encontrados em $DriverPath"

        Get-ChildItem $DriverPath -Recurse -Filter *.inf | ForEach-Object {
            pnputil /add-driver $_.FullName /install
        }
        break
    }
}

#------------------------------------------------
# 6. OEM DRIVER TOOLS
#------------------------------------------------
$WorkDir = "C:\OEM"
New-Item -ItemType Directory -Path $WorkDir -Force | Out-Null

#========== HP ==========
if ($Manufacturer -like "*HP*") {

    Write-Host "HP detetado - usar HPIA"

    $url = "https://ftp.hp.com/pub/caps-softpaq/cmit/HPIA.exe"
    $file = "$WorkDir\HPIA.exe"

    Invoke-WebRequest $url -OutFile $file

    Start-Process $file -ArgumentList "/s /e /f $WorkDir\HPIA" -Wait

    $exe = "$WorkDir\HPIA\HPImageAssistant.exe"

    Start-Process $exe -ArgumentList "/Operation:Analyze /Action:Install /Silent /Category:All" -Wait
    Start-Process $exe -ArgumentList "/Operation:Analyze /Action:Install /Silent /Category:BIOS,Firmware" -Wait
}

#========== LENOVO ==========
elseif ($Manufacturer -like "*Lenovo*") {

    Write-Host "Lenovo detetado - usar System Update"

    $url = "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.08.exe"
    $file = "$WorkDir\Lenovo.exe"

    Invoke-WebRequest $url -OutFile $file

    Start-Process $file -ArgumentList "/VERYSILENT" -Wait

    $exe = "C:\Program Files (x86)\Lenovo\System Update\tvsu.exe"

    Start-Process $exe -ArgumentList "/CM -search A -action INSTALL -noicon -reboot NO" -Wait
}

#========== DELL ==========
elseif ($Manufacturer -like "*Dell*") {

    Write-Host "Dell detetado - usar Dell Command Update"

    $url = "https://downloads.dell.com/FOLDER12345678M/1/Dell-Command-Update.exe"
    $file = "$WorkDir\Dell.exe"

    Invoke-WebRequest $url -OutFile $file

    Start-Process $file -ArgumentList "/s" -Wait

    $exe = "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe"

    Start-Process $exe -ArgumentList "/applyUpdates -silent -reboot=disable" -Wait
}

else {
    Write-Host "Fabricante não suportado"
}

#------------------------------------------------
# 7. FX3 (OTIMIZAÇÕES)
#------------------------------------------------
powercfg -h off
powercfg /setactive SCHEME_MIN

#------------------------------------------------
# 8. LIMPEZA
#------------------------------------------------
Remove-Item $WorkDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "=== Pós-instalação concluída ==="

'@
