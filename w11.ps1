## Instalar Windows Photo Viewer como padrão
# Executar como Administrador
# Executar como Administrador

# Caminho do executável do Windows Photo Viewer
$viewerPath = "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll"

# Ativar o Windows Photo Viewer no registo
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations"

# Criar chave se não existir
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Extensões suportadas
$extensions = @(
    ".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tiff", ".ico"
)

# Associar extensões ao Photo Viewer
foreach ($ext in $extensions) {
    New-ItemProperty -Path $regPath -Name $ext -Value "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Force | Out-Null
}

# Registar a aplicação no sistema
$capabilitiesPath = "HKLM:\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities"

New-ItemProperty -Path $capabilitiesPath -Name "ApplicationName" -Value "Windows Photo Viewer" -PropertyType String -Force | Out-Null

# Adicionar ao RegisteredApplications
$registeredApps = "HKLM:\SOFTWARE\RegisteredApplications"

New-ItemProperty -Path $registeredApps -Name "Windows Photo Viewer" -Value "SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" -PropertyType String -Force | Out-Null

# Definir como default (requer associação por utilizador)
Write-Host "Associações feitas. Pode ser necessário definir manualmente como app padrão uma vez."

# Pasta de destino
$folder = "C:\Windows\Setup\Scripts"
$xmlPath = Join-Path $folder "DefaultApps.xml"

# Criar pasta se não existir
if (!(Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

# Conteúdo do XML
$xmlContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
    <Association Identifier=".jpg" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".jpeg" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".png" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".bmp" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".gif" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".tiff" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
    <Association Identifier=".ico" ProgId="PhotoViewer.FileAssoc.Tiff" ApplicationName="Windows Photo Viewer" />
</DefaultAssociations>
"@

# Criar ficheiro XML
$xmlContent | Out-File -FilePath $xmlPath -Encoding UTF8 -Force

Write-Host "XML criado em: $xmlPath"

# Importar associações (nível sistema)
Dism.exe /Online /Import-DefaultAppAssociations:$xmlPath

Write-Host "Associações importadas com sucesso."
