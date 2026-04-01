# Instalar módulos necessários
Install-Module OSD -Force
Install-Module OSDCloud -Force

Import-Module OSD
Import-Module OSDCloud

# Configuração idioma PT-PT
$Global:OSDCloud = @{
    OSVersion = "Windows 11"
    OSBuild = "25H2"
    OSEdition = "Enterprise"
    OSLanguage = "pt-pt"
    OSLicense = "Volume"
}

# URL do autounattend no GitHub
$UnattendURL = "https://raw.githubusercontent.com/nunomeiras/OSDCloud/autounattend.xml"

# Download autounattend
$UnattendPath = "C:\OSDCloud\autounattend.xml"
Invoke-WebRequest -Uri $UnattendURL -OutFile $UnattendPath

# Aplicar deployment
Start-OSDCloud -UnattendPath $UnattendPath
