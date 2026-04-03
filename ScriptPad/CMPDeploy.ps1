#================================================
#   [PreOS] Update Module
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
    OSLanguage = "pt-pt"
    OSLicense = "Volume"
    ZTI = $true
    Firmware = $false
}
Start-OSDCloud @Params



#================================================
#  [PostOS] Skip OOBE + AutoLogon
#================================================
Write-Host -ForegroundColor Green "Configurando Skip OOBE e AutoLogon"

$Unattend = @'
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
	<!--https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=pt-PT&Locale=pt-PT&Keyboard=00000816&GeoLocation=193&ProcessorArchitecture=amd64&ComputerNameMode=Random&CompactOsMode=Default&TimeZoneMode=Explicit&TimeZone=GMT+Standard+Time&PartitionMode=Interactive&DiskAssertionMode=Skip&WindowsEditionMode=Generic&WindowsEdition=enterprise&InstallFromMode=Automatic&PEMode=Default&UserAccountMode=Unattended&AccountName0=suporte&AccountDisplayName0=Suporte&AccountPassword0=aifrd5d&AccountGroup0=Administrators&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=Hidden&TaskbarSearch=Box&TaskbarIconsMode=Custom&TaskbarIconsXml=%3CLayoutModificationTemplate+xmlns%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FLayoutModification%22+xmlns%3Adefaultlayout%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FFullDefaultLayout%22+xmlns%3Astart%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FStartLayout%22+xmlns%3Ataskbar%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FTaskbarLayout%22+Version%3D%221%22%3E%0D%0A++%3CCustomTaskbarLayoutCollection+PinListPlacement%3D%22Replace%22%3E%0D%0A++++%3Cdefaultlayout%3ATaskbarLayout%3E%0D%0A++++++%3Ctaskbar%3ATaskbarPinList%3E%0D%0A++++++++%3Ctaskbar%3ADesktopApp+DesktopApplicationID%3D%22Microsoft.Windows.Explorer%22+%2F%3E%0D%0A++++++++%3Ctaskbar%3AUWA+AppUserModelID%3D%22windows.immersivecontrolpanel_cw5n1h2txyewy%21microsoft.windows.immersivecontrolpanel%22+%2F%3E%0D%0A++++++++%3Ctaskbar%3ADesktopApp+DesktopApplicationLinkPath%3D%22%25APPDATA%25%5CMicrosoft%5CWindows%5CStart+Menu%5CPrograms%5CWindows+PowerShell%5CWindows+PowerShell.lnk%22+%2F%3E%0D%0A++++++%3C%2Ftaskbar%3ATaskbarPinList%3E%0D%0A++++%3C%2Fdefaultlayout%3ATaskbarLayout%3E%0D%0A++%3C%2FCustomTaskbarLayoutCollection%3E%0D%0A%3C%2FLayoutModificationTemplate%3E&DisableWidgets=true&StartTilesMode=Default&StartPinsMode=Custom&StartPinsJson=%7B%0D%0A++%22pinnedList%22%3A+%5B%0D%0A++++%7B%0D%0A++++++%22desktopAppLink%22%3A+%22%25ALLUSERSPROFILE%25%5C%5CMicrosoft%5C%5CWindows%5C%5CStart+Menu%5C%5CPrograms%5C%5CMicrosoft+Edge.lnk%22%0D%0A++++%7D%2C%0D%0A++++%7B%0D%0A++++++%22desktopAppLink%22%3A+%22%25APPDATA%25%5C%5CMicrosoft%5C%5CWindows%5C%5CStart+Menu%5C%5CPrograms%5C%5CFile+Explorer.lnk%22%0D%0A++++%7D%2C%0D%0A++++%7B%0D%0A++++++%22packagedAppId%22%3A+%22windows.immersivecontrolpanel_cw5n1h2txyewy%21microsoft.windows.immersivecontrolpanel%22%0D%0A++++%7D%0D%0A++%5D%0D%0A%7D&AllowPowerShellScripts=true&HideEdgeFre=true&DisableEdgeStartupBoost=true&EffectsMode=Default&DeleteEdgeDesktopIcon=true&DesktopIconsMode=Default&StartFoldersMode=Default&WifiMode=Interactive&ExpressSettings=DisableAll&LockKeysMode=Skip&StickyKeysMode=Default&ColorMode=Default&WallpaperMode=Script&WallpaperScript=%23+Photo+by+Benjamin+Voros+on+Unsplash.+See+https%3A%2F%2Funsplash.com%2Fphotos%2Fsnow-mountain-under-stars-phIFdC6lA4E+for+more+info.%0D%0A%24url+%3D+%27https%3A%2F%2Fimages.unsplash.com%2Fphoto-1519681393784-d120267933ba%3Fw%3D2400%27%3B%0D%0A%26+%7B%0D%0A%09%24ProgressPreference+%3D+%27SilentlyContinue%27%3B%0D%0A%09%28+Invoke-WebRequest+-Uri+%24url+-UseBasicParsing+-TimeoutSec+30+%29.Content%3B%0D%0A%7D%3B&LockScreenMode=Script&LockScreenScript=foreach%28+%24drive+in+%5BSystem.IO.DriveInfo%5D%3A%3AGetDrives%28%29+%29+%7B%0D%0A++++if%28+%24found+%3D+Join-Path+-Path+%24drive.RootDirectory+-ChildPath+%27lockscreen.png%27+-Resolve+-ErrorAction+%27SilentlyContinue%27+%29+%7B%0D%0A++++++++return+%5BSystem.IO.File%5D%3A%3AReadAllBytes%28+%24found+%29%3B%0D%0A++++%7D%0D%0A%7D%0D%0A%27Cannot+find+any+files+that+match+pattern.%27+%7C+Write-Warning%3B&Remove3DViewer=true&RemoveBingSearch=true&RemoveClipchamp=true&RemoveClock=true&RemoveCortana=true&RemoveDevHome=true&RemoveFamily=true&RemoveFeedbackHub=true&RemoveGameAssist=true&RemoveGetHelp=true&RemoveMailCalendar=true&RemoveMaps=true&RemoveMediaFeatures=true&RemoveMixedReality=true&RemoveZuneVideo=true&RemoveNews=true&RemoveOffice365=true&RemoveOneNote=true&RemoveOneSync=true&RemoveOutlook=true&RemovePaint=true&RemovePaint3D=true&RemovePeople=true&RemovePowerAutomate=true&RemoveQuickAssist=true&RemoveSkype=true&RemoveSolitaire=true&RemoveStickyNotes=true&RemoveTeams=true&RemoveToDo=true&RemoveVoiceRecorder=true&RemoveWallet=true&RemoveWeather=true&RemoveFaxAndScan=true&RemoveWindowsMediaPlayer=true&RemoveZuneMusic=true&RemoveXboxApps=true&RemoveYourPhone=true&SystemScript0=Set-ExecutionPolicy+Bypass+-Scope+Process+-Force%0D%0A%5BSystem.Net.ServicePointManager%5D%3A%3ASecurityProtocol+%3D+3072%0D%0A%0D%0AInvoke-Expression+%28%28New-Object+System.Net.WebClient%29.DownloadString%28%27https%3A%2F%2Fcommunity.chocolatey.org%2Finstall.ps1%27%29%29&SystemScriptType0=Ps1&SystemScript1=Enable-WindowsOptionalFeature+-Online+-FeatureName+NetFx3&SystemScriptType1=Ps1&SystemScript3=Windows+Registry+Editor+Version+5.00+%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CRegisteredApplications%5D%0D%0A%22Windows+Photo+Viewer%22%3D%22Software%5C%5CMicrosoft%5C%5CWindows+Photo+Viewer%5C%5CCapabilities%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CMicrosoft%5CWindows+Photo+Viewer%5CCapabilities%5D%0D%0A%22ApplicationDescription%22%3D%22%40%25ProgramFiles%25%5C%5CWindows+Photo+Viewer%5C%5Cphotoviewer.dll%2C-3069%22%0D%0A%22ApplicationName%22%3D%22%40%25ProgramFiles%25%5C%5CWindows+Photo+Viewer%5C%5Cphotoviewer.dll%2C-3009%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CMicrosoft%5CWindows+Photo+Viewer%5CCapabilities%5CFileAssociations%5D%0D%0A%22.tif%22%3D%22PhotoViewer.FileAssoc.Tiff%22%0D%0A%22.tiff%22%3D%22PhotoViewer.FileAssoc.Tiff%22%0D%0A%22.jpg%22%3D%22PhotoViewer.FileAssoc.Jpeg%22%0D%0A%22.wdp%22%3D%22PhotoViewer.FileAssoc.Wdp%22%0D%0A%22.jfif%22%3D%22PhotoViewer.FileAssoc.JFIF%22%0D%0A%22.dib%22%3D%22PhotoViewer.FileAssoc.Bitmap%22%0D%0A%22.png%22%3D%22PhotoViewer.FileAssoc.Png%22%0D%0A%22.bmp%22%3D%22PhotoViewer.FileAssoc.Bitmap%22%0D%0A%22.jpe%22%3D%22PhotoViewer.FileAssoc.Jpeg%22%0D%0A%22.jpeg%22%3D%22PhotoViewer.FileAssoc.Jpeg%22%0D%0A%22.gif%22%3D%22PhotoViewer.FileAssoc.Tiff%22%0D%0A%22.webp%22%3D%22PhotoViewer.FileAssoc.Jpeg%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Bitmap%5D%0D%0A%22ImageOptionFlags%22%3Ddword%3A00000001%0D%0A%22FriendlyTypeName%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C%5C%0D%0A++00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C%5C%0D%0A++77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C%5C%0D%0A++00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C35%2C00%2C36%2C00%2C00%2C%5C%0D%0A++00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Bitmap%5CDefaultIcon%5D%0D%0A%40%3D%22%25SystemRoot%25%5C%5CSystem32%5C%5Cimageres.dll%2C-70%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Bitmap%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Bitmap%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.JFIF%5D%0D%0A%22EditFlags%22%3Ddword%3A00010000%0D%0A%22ImageOptionFlags%22%3Ddword%3A00000001%0D%0A%22FriendlyTypeName%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C%5C%0D%0A++00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C%5C%0D%0A++77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C%5C%0D%0A++00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C35%2C00%2C35%2C00%2C00%2C%5C%0D%0A++00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.JFIF%5CDefaultIcon%5D%0D%0A%40%3D%22%25SystemRoot%25%5C%5CSystem32%5C%5Cimageres.dll%2C-72%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.JFIF%5Cshell%5Copen%5D%0D%0A%22MuiVerb%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C%5C%0D%0A++69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C%5C%0D%0A++00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C%5C%0D%0A++72%2C00%2C5c%2C00%2C70%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C76%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C%5C%0D%0A++00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C34%2C00%2C33%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.JFIF%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.JFIF%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Jpeg%5D%0D%0A%22EditFlags%22%3Ddword%3A00010000%0D%0A%22ImageOptionFlags%22%3Ddword%3A00000001%0D%0A%22FriendlyTypeName%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C%5C%0D%0A++00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C%5C%0D%0A++77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C%5C%0D%0A++00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C35%2C00%2C35%2C00%2C00%2C%5C%0D%0A++00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Jpeg%5CDefaultIcon%5D%0D%0A%40%3D%22%25SystemRoot%25%5C%5CSystem32%5C%5Cimageres.dll%2C-72%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Jpeg%5Cshell%5Copen%5D%0D%0A%22MuiVerb%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C%5C%0D%0A++69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C%5C%0D%0A++00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C%5C%0D%0A++72%2C00%2C5c%2C00%2C70%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C76%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C%5C%0D%0A++00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C34%2C00%2C33%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Jpeg%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Jpeg%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Png%5D%0D%0A%22ImageOptionFlags%22%3Ddword%3A00000001%0D%0A%22FriendlyTypeName%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C%5C%0D%0A++00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C%5C%0D%0A++77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C%5C%0D%0A++00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C35%2C00%2C37%2C00%2C00%2C%5C%0D%0A++00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Png%5CDefaultIcon%5D%0D%0A%40%3D%22%25SystemRoot%25%5C%5CSystem32%5C%5Cimageres.dll%2C-71%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Png%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Png%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Wdp%5D%0D%0A%22EditFlags%22%3Ddword%3A00010000%0D%0A%22ImageOptionFlags%22%3Ddword%3A00000001%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Wdp%5CDefaultIcon%5D%0D%0A%40%3D%22%25SystemRoot%25%5C%5CSystem32%5C%5Cwmphoto.dll%2C-400%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Wdp%5Cshell%5Copen%5D%0D%0A%22MuiVerb%22%3Dhex%282%29%3A40%2C00%2C25%2C00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C%5C%0D%0A++69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C%5C%0D%0A++00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C%5C%0D%0A++72%2C00%2C5c%2C00%2C70%2C00%2C68%2C00%2C6f%2C00%2C74%2C00%2C6f%2C00%2C76%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C%5C%0D%0A++00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C2c%2C00%2C2d%2C00%2C33%2C00%2C30%2C00%2C34%2C00%2C33%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Wdp%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CPhotoViewer.FileAssoc.Wdp%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CApplications%5Cphotoviewer.dll%5Cshell%5Copen%5D%0D%0A%22MuiVerb%22%3D%22%40photoviewer.dll%2C-3043%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CApplications%5Cphotoviewer.dll%5Cshell%5Copen%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CApplications%5Cphotoviewer.dll%5Cshell%5Copen%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7BFFE2A43C-56B9-4bf5-9A79-CC6D4285608A%7D%22%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CApplications%5Cphotoviewer.dll%5Cshell%5Cprint%5Ccommand%5D%0D%0A%40%3Dhex%282%29%3A25%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C52%2C00%2C6f%2C00%2C6f%2C00%2C74%2C00%2C25%2C%5C%0D%0A++00%2C5c%2C00%2C53%2C00%2C79%2C00%2C73%2C00%2C74%2C00%2C65%2C00%2C6d%2C00%2C33%2C00%2C32%2C00%2C5c%2C00%2C72%2C00%2C75%2C00%2C%5C%0D%0A++6e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C00%2C33%2C00%2C32%2C00%2C2e%2C00%2C65%2C00%2C78%2C00%2C65%2C00%2C20%2C00%2C22%2C00%2C25%2C%5C%0D%0A++00%2C50%2C00%2C72%2C00%2C6f%2C00%2C67%2C00%2C72%2C00%2C61%2C00%2C6d%2C00%2C46%2C00%2C69%2C00%2C6c%2C00%2C65%2C00%2C73%2C00%2C%5C%0D%0A++25%2C00%2C5c%2C00%2C57%2C00%2C69%2C00%2C6e%2C00%2C64%2C00%2C6f%2C00%2C77%2C00%2C73%2C00%2C20%2C00%2C50%2C00%2C68%2C00%2C6f%2C%5C%0D%0A++00%2C74%2C00%2C6f%2C00%2C20%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C5c%2C00%2C50%2C00%2C68%2C00%2C%5C%0D%0A++6f%2C00%2C74%2C00%2C6f%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C65%2C00%2C72%2C00%2C2e%2C00%2C64%2C00%2C6c%2C00%2C6c%2C%5C%0D%0A++00%2C22%2C00%2C2c%2C00%2C20%2C00%2C49%2C00%2C6d%2C00%2C61%2C00%2C67%2C00%2C65%2C00%2C56%2C00%2C69%2C00%2C65%2C00%2C77%2C00%2C%5C%0D%0A++5f%2C00%2C46%2C00%2C75%2C00%2C6c%2C00%2C6c%2C00%2C73%2C00%2C63%2C00%2C72%2C00%2C65%2C00%2C65%2C00%2C6e%2C00%2C20%2C00%2C25%2C%5C%0D%0A++00%2C31%2C00%2C00%2C00%0D%0A%0D%0A%5BHKEY_LOCAL_MACHINE%5CSOFTWARE%5CClasses%5CApplications%5Cphotoviewer.dll%5Cshell%5Cprint%5CDropTarget%5D%0D%0A%22Clsid%22%3D%22%7B60fd46de-f830-4894-a628-6fa81bc0190d%7D%22&SystemScriptType3=Reg&FirstLogonScript0=choco+feature+enable+-n+allowGlobalConfirmation%0D%0Achoco+install+adobereader+-y%0D%0Achoco+install+nanazip+%2D%2Dyes%0D%0Achoco+install+firefox+%2D%2Dyes%0D%0Achoco+install+googlechrome+%2D%2Dignore-checksums+%2D%2Dyes%0D%0Achoco+install+notepadplusplus.install+%2D%2Dyes%0D%0Achoco+install+jre8+%2D%2Dyes%0D%0Achoco+install+pdf24+%2D%2Dyes%0D%0Achoco+install+vlc+%2D%2Dyes%0D%0Achoco+install+zoom+%2D%2Dyes%0D%0Achoco+install+dotnet-8.0-desktopruntime+%2D%2Dyes%0D%0Achoco+install+vcredist-all+-y%0D%0Achoco+install+choco-upgrade-all-at-startup&FirstLogonScriptType0=Ps1&FirstLogonScript3=%24Serial+%3D+%28Get-CimInstance+Win32_BIOS%29.SerialNumber%0D%0A%24Suffix+%3D+%24Serial.Substring%28%24Serial.Length+-+5%29%0D%0A%24NewName+%3D+%22CMP-%24Suffix%22%0D%0ARename-Computer+-NewName+%24NewName+-Force&FirstLogonScriptType3=Ps1&WdacMode=Skip&AppLockerMode=Skip-->
	<settings pass="offlineServicing"></settings>
	<settings pass="windowsPE">
		<component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<UILanguage>pt-PT</UILanguage>
		</component>
		<component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<UserData>
				<ProductKey>
					<Key>XGVPP-NMH47-7TTHJ-W3FW7-8HV2C</Key>
					<WillShowUI>OnError</WillShowUI>
				</ProductKey>
				<AcceptEula>true</AcceptEula>
			</UserData>
			<UseConfigurationSet>false</UseConfigurationSet>
		</component>
	</settings>
	<settings pass="generalize"></settings>
	<settings pass="specialize">
		<component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<RunSynchronous>
				<RunSynchronousCommand wcm:action="add">
					<Order>1</Order>
					<Path>powershell.exe -WindowStyle "Normal" -NoProfile -Command "$xml = [xml]::new(); $xml.Load('C:\Windows\Panther\unattend.xml'); $sb = [scriptblock]::Create( $xml.unattend.Extensions.ExtractScript ); Invoke-Command -ScriptBlock $sb -ArgumentList $xml;"</Path>
				</RunSynchronousCommand>
				<RunSynchronousCommand wcm:action="add">
					<Order>2</Order>
					<Path>powershell.exe -WindowStyle "Normal" -ExecutionPolicy "Unrestricted" -NoProfile -File "C:\Windows\Setup\Scripts\Specialize.ps1"</Path>
				</RunSynchronousCommand>
				<RunSynchronousCommand wcm:action="add">
					<Order>3</Order>
					<Path>reg.exe load "HKU\DefaultUser" "C:\Users\Default\NTUSER.DAT"</Path>
				</RunSynchronousCommand>
				<RunSynchronousCommand wcm:action="add">
					<Order>4</Order>
					<Path>powershell.exe -WindowStyle "Normal" -ExecutionPolicy "Unrestricted" -NoProfile -File "C:\Windows\Setup\Scripts\DefaultUser.ps1"</Path>
				</RunSynchronousCommand>
				<RunSynchronousCommand wcm:action="add">
					<Order>5</Order>
					<Path>reg.exe unload "HKU\DefaultUser"</Path>
				</RunSynchronousCommand>
			</RunSynchronous>
		</component>
		<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<TimeZone>GMT Standard Time</TimeZone>
		</component>
	</settings>
	<settings pass="auditSystem"></settings>
	<settings pass="auditUser"></settings>
	<settings pass="oobeSystem">
		<component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<InputLocale>0816:00000816</InputLocale>
			<SystemLocale>pt-PT</SystemLocale>
			<UILanguage>pt-PT</UILanguage>
			<UserLocale>pt-PT</UserLocale>
		</component>
		<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
			<UserAccounts>
				<LocalAccounts>
					<LocalAccount wcm:action="add">
						<Name>suporte</Name>
						<DisplayName>Suporte</DisplayName>
						<Group>Administrators</Group>
						<Password>
							<Value>aifrd5d</Value>
							<PlainText>true</PlainText>
						</Password>
					</LocalAccount>
				</LocalAccounts>
			</UserAccounts>
			<AutoLogon>
				<Username>suporte</Username>
				<Enabled>true</Enabled>
				<LogonCount>1</LogonCount>
				<Password>
					<Value>aifrd5d</Value>
					<PlainText>true</PlainText>
				</Password>
			</AutoLogon>
			<OOBE>
				<ProtectYourPC>3</ProtectYourPC>
				<HideEULAPage>true</HideEULAPage>
				<HideWirelessSetupInOOBE>false</HideWirelessSetupInOOBE>
				<HideOnlineAccountScreens>false</HideOnlineAccountScreens>
			</OOBE>
			<FirstLogonCommands>
				<SynchronousCommand wcm:action="add">
					<Order>1</Order>
					<CommandLine>powershell.exe -WindowStyle "Normal" -ExecutionPolicy "Unrestricted" -NoProfile -File "C:\Windows\Setup\Scripts\FirstLogon.ps1"</CommandLine>
				</SynchronousCommand>
			</FirstLogonCommands>
		</component>
	</settings>
	<Extensions xmlns="https://schneegans.de/windows/unattend-generator/">
		<ExtractScript>
param(
    [xml] $Document
);

foreach( $file in $Document.unattend.Extensions.File ) {
    $path = [System.Environment]::ExpandEnvironmentVariables( $file.GetAttribute( 'path' ) );
    mkdir -Path( $path | Split-Path -Parent ) -ErrorAction 'SilentlyContinue';
    $encoding = switch( [System.IO.Path]::GetExtension( $path ) ) {
        { $_ -in '.ps1', '.xml' } { [System.Text.Encoding]::UTF8; }
        { $_ -in '.reg', '.vbs', '.js' } { [System.Text.UnicodeEncoding]::new( $false, $true ); }
        default { [System.Text.Encoding]::Default; }
    };
    $bytes = $encoding.GetPreamble() + $encoding.GetBytes( $file.InnerText.Trim() );
    [System.IO.File]::WriteAllBytes( $path, $bytes );
}
		</ExtractScript>
		<File path="C:\Windows\Setup\Scripts\RemovePackages.ps1">
$selectors = @(
	'Microsoft.Microsoft3DViewer';
	'Microsoft.BingSearch';
	'Clipchamp.Clipchamp';
	'Microsoft.WindowsAlarms';
	'Microsoft.549981C3F5F10';
	'Microsoft.Windows.DevHome';
	'MicrosoftCorporationII.MicrosoftFamily';
	'Microsoft.WindowsFeedbackHub';
	'Microsoft.Edge.GameAssist';
	'Microsoft.GetHelp';
	'microsoft.windowscommunicationsapps';
	'Microsoft.WindowsMaps';
	'Microsoft.MixedReality.Portal';
	'Microsoft.BingNews';
	'Microsoft.MicrosoftOfficeHub';
	'Microsoft.Office.OneNote';
	'Microsoft.OutlookForWindows';
	'Microsoft.Paint';
	'Microsoft.MSPaint';
	'Microsoft.People';
	'Microsoft.PowerAutomateDesktop';
	'MicrosoftCorporationII.QuickAssist';
	'Microsoft.SkypeApp';
	'Microsoft.MicrosoftSolitaireCollection';
	'Microsoft.MicrosoftStickyNotes';
	'MicrosoftTeams';
	'MSTeams';
	'Microsoft.Todos';
	'Microsoft.WindowsSoundRecorder';
	'Microsoft.Wallet';
	'Microsoft.BingWeather';
	'Microsoft.Xbox.TCUI';
	'Microsoft.XboxApp';
	'Microsoft.XboxGameOverlay';
	'Microsoft.XboxGamingOverlay';
	'Microsoft.XboxIdentityProvider';
	'Microsoft.XboxSpeechToTextOverlay';
	'Microsoft.GamingApp';
	'Microsoft.YourPhone';
	'Microsoft.ZuneMusic';
	'Microsoft.ZuneVideo';
);
$getCommand = {
  Get-AppxProvisionedPackage -Online;
};
$filterCommand = {
  $_.DisplayName -eq $selector;
};
$removeCommand = {
  [CmdletBinding()]
  param(
    [Parameter( Mandatory, ValueFromPipeline )]
    $InputObject
  );
  process {
    $InputObject | Remove-AppxProvisionedPackage -AllUsers -Online -ErrorAction 'Continue';
  }
};
$type = 'Package';
$logfile = 'C:\Windows\Setup\Scripts\RemovePackages.log';
&amp; {
	$installed = &amp; $getCommand;
	foreach( $selector in $selectors ) {
		$result = [ordered] @{
			Selector = $selector;
		};
		$found = $installed | Where-Object -FilterScript $filterCommand;
		if( $found ) {
			$result.Output = $found | &amp; $removeCommand;
			if( $? ) {
				$result.Message = "$type removed.";
			} else {
				$result.Message = "$type not removed.";
				$result.Error = $Error[0];
			}
		} else {
			$result.Message = "$type not installed.";
		}
		$result | ConvertTo-Json -Depth 3 -Compress;
	}
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; $logfile;
		</File>
		<File path="C:\Windows\Setup\Scripts\RemoveCapabilities.ps1">
$selectors = @(
	'Print.Fax.Scan';
	'OneCoreUAP.OneSync';
	'Microsoft.Windows.MSPaint';
	'App.Support.QuickAssist';
	'Media.WindowsMediaPlayer';
);
$getCommand = {
  Get-WindowsCapability -Online | Where-Object -Property 'State' -NotIn -Value @(
    'NotPresent';
    'Removed';
  );
};
$filterCommand = {
  ($_.Name -split '~')[0] -eq $selector;
};
$removeCommand = {
  [CmdletBinding()]
  param(
    [Parameter( Mandatory, ValueFromPipeline )]
    $InputObject
  );
  process {
    $InputObject | Remove-WindowsCapability -Online -ErrorAction 'Continue';
  }
};
$type = 'Capability';
$logfile = 'C:\Windows\Setup\Scripts\RemoveCapabilities.log';
&amp; {
	$installed = &amp; $getCommand;
	foreach( $selector in $selectors ) {
		$result = [ordered] @{
			Selector = $selector;
		};
		$found = $installed | Where-Object -FilterScript $filterCommand;
		if( $found ) {
			$result.Output = $found | &amp; $removeCommand;
			if( $? ) {
				$result.Message = "$type removed.";
			} else {
				$result.Message = "$type not removed.";
				$result.Error = $Error[0];
			}
		} else {
			$result.Message = "$type not installed.";
		}
		$result | ConvertTo-Json -Depth 3 -Compress;
	}
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; $logfile;
		</File>
		<File path="C:\Windows\Setup\Scripts\RemoveFeatures.ps1">
$selectors = @(
	'MediaPlayback';
);
$getCommand = {
  Get-WindowsOptionalFeature -Online | Where-Object -Property 'State' -NotIn -Value @(
    'Disabled';
    'DisabledWithPayloadRemoved';
  );
};
$filterCommand = {
  $_.FeatureName -eq $selector;
};
$removeCommand = {
  [CmdletBinding()]
  param(
    [Parameter( Mandatory, ValueFromPipeline )]
    $InputObject
  );
  process {
    $InputObject | Disable-WindowsOptionalFeature -Online -Remove -NoRestart -ErrorAction 'Continue';
  }
};
$type = 'Feature';
$logfile = 'C:\Windows\Setup\Scripts\RemoveFeatures.log';
&amp; {
	$installed = &amp; $getCommand;
	foreach( $selector in $selectors ) {
		$result = [ordered] @{
			Selector = $selector;
		};
		$found = $installed | Where-Object -FilterScript $filterCommand;
		if( $found ) {
			$result.Output = $found | &amp; $removeCommand;
			if( $? ) {
				$result.Message = "$type removed.";
			} else {
				$result.Message = "$type not removed.";
				$result.Error = $Error[0];
			}
		} else {
			$result.Message = "$type not installed.";
		}
		$result | ConvertTo-Json -Depth 3 -Compress;
	}
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; $logfile;
		</File>
		<File path="C:\Windows\Setup\Scripts\TaskbarLayoutModification.xml">
&lt;LayoutModificationTemplate xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification" xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" Version="1"&gt;
	&lt;CustomTaskbarLayoutCollection PinListPlacement="Replace"&gt;
		&lt;defaultlayout:TaskbarLayout&gt;
			&lt;taskbar:TaskbarPinList&gt;
				&lt;taskbar:DesktopApp DesktopApplicationID="Microsoft.Windows.Explorer" /&gt;
				&lt;taskbar:UWA AppUserModelID="windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /&gt;
				&lt;taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk" /&gt;
			&lt;/taskbar:TaskbarPinList&gt;
		&lt;/defaultlayout:TaskbarLayout&gt;
	&lt;/CustomTaskbarLayoutCollection&gt;
&lt;/LayoutModificationTemplate&gt;
		</File>
		<File path="C:\Windows\Setup\Scripts\UnlockStartLayout.vbs">
HKU = &amp;H80000003
Set reg = GetObject("winmgmts://./root/default:StdRegProv")
Set fso = CreateObject("Scripting.FileSystemObject")

If reg.EnumKey(HKU, "", sids) = 0 Then
	If Not IsNull(sids) Then
		For Each sid In sids
			key = sid + "\Software\Policies\Microsoft\Windows\Explorer"
			name = "LockedStartLayout"
			If reg.GetDWORDValue(HKU, key, name, existing) = 0 Then
				reg.SetDWORDValue HKU, key, name, 0
			End If
		Next
	End If
End If
		</File>
		<File path="C:\Windows\Setup\Scripts\UnlockStartLayout.xml">
&lt;Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"&gt;
	&lt;Triggers&gt;
		&lt;EventTrigger&gt;
			&lt;Enabled&gt;true&lt;/Enabled&gt;
			&lt;Subscription&gt;&amp;lt;QueryList&amp;gt;&amp;lt;Query Id="0" Path="Application"&amp;gt;&amp;lt;Select Path="Application"&amp;gt;*[System[Provider[@Name='UnattendGenerator'] and EventID=1]]&amp;lt;/Select&amp;gt;&amp;lt;/Query&amp;gt;&amp;lt;/QueryList&amp;gt;&lt;/Subscription&gt;
		&lt;/EventTrigger&gt;
	&lt;/Triggers&gt;
	&lt;Principals&gt;
		&lt;Principal id="Author"&gt;
			&lt;UserId&gt;S-1-5-18&lt;/UserId&gt;
			&lt;RunLevel&gt;LeastPrivilege&lt;/RunLevel&gt;
		&lt;/Principal&gt;
	&lt;/Principals&gt;
	&lt;Settings&gt;
		&lt;MultipleInstancesPolicy&gt;IgnoreNew&lt;/MultipleInstancesPolicy&gt;
		&lt;DisallowStartIfOnBatteries&gt;false&lt;/DisallowStartIfOnBatteries&gt;
		&lt;StopIfGoingOnBatteries&gt;false&lt;/StopIfGoingOnBatteries&gt;
		&lt;AllowHardTerminate&gt;true&lt;/AllowHardTerminate&gt;
		&lt;StartWhenAvailable&gt;false&lt;/StartWhenAvailable&gt;
		&lt;RunOnlyIfNetworkAvailable&gt;false&lt;/RunOnlyIfNetworkAvailable&gt;
		&lt;IdleSettings&gt;
			&lt;StopOnIdleEnd&gt;true&lt;/StopOnIdleEnd&gt;
			&lt;RestartOnIdle&gt;false&lt;/RestartOnIdle&gt;
		&lt;/IdleSettings&gt;
		&lt;AllowStartOnDemand&gt;true&lt;/AllowStartOnDemand&gt;
		&lt;Enabled&gt;true&lt;/Enabled&gt;
		&lt;Hidden&gt;false&lt;/Hidden&gt;
		&lt;RunOnlyIfIdle&gt;false&lt;/RunOnlyIfIdle&gt;
		&lt;WakeToRun&gt;false&lt;/WakeToRun&gt;
		&lt;ExecutionTimeLimit&gt;PT72H&lt;/ExecutionTimeLimit&gt;
		&lt;Priority&gt;7&lt;/Priority&gt;
	&lt;/Settings&gt;
	&lt;Actions Context="Author"&gt;
		&lt;Exec&gt;
			&lt;Command&gt;C:\Windows\System32\wscript.exe&lt;/Command&gt;
			&lt;Arguments&gt;C:\Windows\Setup\Scripts\UnlockStartLayout.vbs&lt;/Arguments&gt;
		&lt;/Exec&gt;
	&lt;/Actions&gt;
&lt;/Task&gt;
		</File>
		<File path="C:\Windows\Setup\Scripts\SetStartPins.ps1">
$json = '{
  "pinnedList": [
    {
      "desktopAppLink": "%ALLUSERSPROFILE%\\Microsoft\\Windows\\Start Menu\\Programs\\Microsoft Edge.lnk"
    },
    {
      "desktopAppLink": "%APPDATA%\\Microsoft\\Windows\\Start Menu\\Programs\\File Explorer.lnk"
    },
    {
      "packagedAppId": "windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel"
    }
  ]
}';
if( [System.Environment]::OSVersion.Version.Build -lt 20000 ) {
	return;
}
$key = 'Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start';
New-Item -Path $key -ItemType 'Directory' -ErrorAction 'SilentlyContinue';
Set-ItemProperty -LiteralPath $key -Name 'ConfigureStartPins' -Value $json -Type 'String';
		</File>
		<File path="C:\Windows\Setup\Scripts\GetWallpaper.ps1">
# Photo by Benjamin Voros on Unsplash. See https://unsplash.com/photos/snow-mountain-under-stars-phIFdC6lA4E for more info.
$url = 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=2400';
&amp; {
	$ProgressPreference = 'SilentlyContinue';
	( Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 30 ).Content;
};
		</File>
		<File path="C:\Windows\Setup\Scripts\SetWallpaper.ps1">
Add-Type -TypeDefinition '
	using System.Drawing;
	using System.Runtime.InteropServices;
	
	public static class WallpaperSetter {
		[DllImport("user32.dll")]
		private static extern bool SetSysColors(
			int cElements, 
			int[] lpaElements,
			int[] lpaRgbValues
		);

		[DllImport("user32.dll")]
		private static extern bool SystemParametersInfo(
			uint uiAction,
			uint uiParam,
			string pvParam,
			uint fWinIni
		);

		public static void SetDesktopBackground(Color color) {
			SystemParametersInfo(20, 0, "", 0);
			SetSysColors(1, new int[] { 1 }, new int[] { ColorTranslator.ToWin32(color) });
		}

		public static void SetDesktopImage(string file) {
			SystemParametersInfo(20, 0, file, 0);
		}
	}
' -ReferencedAssemblies 'System.Drawing';

function Set-WallpaperColor {
	param(
		[string]
		$HtmlColor
	);

	$color = [System.Drawing.ColorTranslator]::FromHtml( $HtmlColor );
	[WallpaperSetter]::SetDesktopBackground( $color );
	Set-ItemProperty -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers' -Name 'BackgroundType' -Type 'DWord' -Value 1 -Force;
	Set-ItemProperty -Path 'Registry::HKCU\Control Panel\Desktop' -Name 'WallPaper' -Type 'String' -Value '' -Force;
	Set-ItemProperty -Path 'Registry::HKCU\Control Panel\Colors' -Name 'Background' -Type 'String' -Value "$($color.R) $($color.G) $($color.B)" -Force;
}

function Set-WallpaperImage {
	param(
		[string]
		$LiteralPath
	);

	if( $LiteralPath | Test-Path ) {
		[WallpaperSetter]::SetDesktopImage( $LiteralPath );
		Set-ItemProperty -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers' -Name 'BackgroundType' -Type 'DWord' -Value 0 -Force;
		Set-ItemProperty -Path 'Registry::HKCU\Control Panel\Desktop' -Name 'WallPaper' -Type 'String' -Value $LiteralPath -Force;
	} else {
		"Cannot use '$LiteralPath' as a desktop wallpaper because that file does not exist.";
	}
}
Set-WallpaperImage -LiteralPath 'C:\Windows\Setup\Scripts\Wallpaper';
		</File>
		<File path="C:\Windows\Setup\Scripts\GetLockScreenImage.ps1">
foreach( $drive in [System.IO.DriveInfo]::GetDrives() ) {
    if( $found = Join-Path -Path $drive.RootDirectory -ChildPath 'lockscreen.png' -Resolve -ErrorAction 'SilentlyContinue' ) {
        return [System.IO.File]::ReadAllBytes( $found );
    }
}
'Cannot find any files that match pattern.' | Write-Warning;
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-01.ps1">
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = 3072

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-02.ps1">
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-03.reg">
Windows Registry Editor Version 5.00 

[HKEY_LOCAL_MACHINE\SOFTWARE\RegisteredApplications]
"Windows Photo Viewer"="Software\\Microsoft\\Windows Photo Viewer\\Capabilities"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities]
"ApplicationDescription"="@%ProgramFiles%\\Windows Photo Viewer\\photoviewer.dll,-3069"
"ApplicationName"="@%ProgramFiles%\\Windows Photo Viewer\\photoviewer.dll,-3009"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations]
".tif"="PhotoViewer.FileAssoc.Tiff"
".tiff"="PhotoViewer.FileAssoc.Tiff"
".jpg"="PhotoViewer.FileAssoc.Jpeg"
".wdp"="PhotoViewer.FileAssoc.Wdp"
".jfif"="PhotoViewer.FileAssoc.JFIF"
".dib"="PhotoViewer.FileAssoc.Bitmap"
".png"="PhotoViewer.FileAssoc.Png"
".bmp"="PhotoViewer.FileAssoc.Bitmap"
".jpe"="PhotoViewer.FileAssoc.Jpeg"
".jpeg"="PhotoViewer.FileAssoc.Jpeg"
".gif"="PhotoViewer.FileAssoc.Tiff"
".webp"="PhotoViewer.FileAssoc.Jpeg"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Bitmap]
"ImageOptionFlags"=dword:00000001
"FriendlyTypeName"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,\
  00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,\
  77,00,73,00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,\
  00,65,00,72,00,5c,00,50,00,68,00,6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,\
  65,00,72,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,35,00,36,00,00,\
  00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Bitmap\DefaultIcon]
@="%SystemRoot%\\System32\\imageres.dll,-70"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Bitmap\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.JFIF]
"EditFlags"=dword:00010000
"ImageOptionFlags"=dword:00000001
"FriendlyTypeName"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,\
  00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,\
  77,00,73,00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,\
  00,65,00,72,00,5c,00,50,00,68,00,6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,\
  65,00,72,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,35,00,35,00,00,\
  00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.JFIF\DefaultIcon]
@="%SystemRoot%\\System32\\imageres.dll,-72"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.JFIF\shell\open]
"MuiVerb"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,\
  69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,\
  00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,\
  72,00,5c,00,70,00,68,00,6f,00,74,00,6f,00,76,00,69,00,65,00,77,00,65,00,72,\
  00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,34,00,33,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.JFIF\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Jpeg]
"EditFlags"=dword:00010000
"ImageOptionFlags"=dword:00000001
"FriendlyTypeName"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,\
  00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,\
  77,00,73,00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,\
  00,65,00,72,00,5c,00,50,00,68,00,6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,\
  65,00,72,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,35,00,35,00,00,\
  00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Jpeg\DefaultIcon]
@="%SystemRoot%\\System32\\imageres.dll,-72"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Jpeg\shell\open]
"MuiVerb"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,\
  69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,\
  00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,\
  72,00,5c,00,70,00,68,00,6f,00,74,00,6f,00,76,00,69,00,65,00,77,00,65,00,72,\
  00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,34,00,33,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Jpeg\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Png]
"ImageOptionFlags"=dword:00000001
"FriendlyTypeName"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,\
  00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,\
  77,00,73,00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,\
  00,65,00,72,00,5c,00,50,00,68,00,6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,\
  65,00,72,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,35,00,37,00,00,\
  00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Png\DefaultIcon]
@="%SystemRoot%\\System32\\imageres.dll,-71"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Png\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Png\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Wdp]
"EditFlags"=dword:00010000
"ImageOptionFlags"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Wdp\DefaultIcon]
@="%SystemRoot%\\System32\\wmphoto.dll,-400"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Wdp\shell\open]
"MuiVerb"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,\
  69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,\
  00,20,00,50,00,68,00,6f,00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,\
  72,00,5c,00,70,00,68,00,6f,00,74,00,6f,00,76,00,69,00,65,00,77,00,65,00,72,\
  00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,33,00,30,00,34,00,33,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Wdp\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\open]
"MuiVerb"="@photoviewer.dll,-3043"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\print\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,\
  00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,\
  25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,\
  00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,\
  6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,\
  00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,\
  5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,\
  00,31,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\print\DropTarget]
"Clsid"="{60fd46de-f830-4894-a628-6fa81bc0190d}"
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-04.ps1">
choco feature enable -n allowGlobalConfirmation
choco install adobereader -y
choco install nanazip --yes
choco install firefox --yes
choco install googlechrome --ignore-checksums --yes
choco install notepadplusplus.install --yes
choco install jre8 --yes
choco install pdf24 --yes
choco install vlc --yes
choco install zoom --yes
choco install dotnet-8.0-desktopruntime --yes
choco install vcredist-all -y
choco install choco-upgrade-all-at-startup
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-05.ps1">
$Serial = (Get-CimInstance Win32_BIOS).SerialNumber
$Suffix = $Serial.Substring($Serial.Length - 5)
$NewName = "CMP-$Suffix"
Rename-Computer -NewName $NewName -Force
		</File>
		<File path="C:\Windows\Setup\Scripts\Specialize.ps1">
$scripts = @(
	{
		Remove-Item -LiteralPath 'Registry::HKLM\Software\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate' -Force -ErrorAction 'SilentlyContinue';
	};
	{
		Remove-Item -LiteralPath 'Registry::HKLM\Software\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate' -Force -ErrorAction 'SilentlyContinue';
	};
	{
		reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v ConfigureChatAutoInstall /t REG_DWORD /d 0 /f;
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\RemovePackages.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\RemoveCapabilities.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\RemoveFeatures.ps1';
	};
	{
		net.exe accounts /maxpwage:UNLIMITED;
	};
	{
		reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d 1 /f;
		[System.Diagnostics.EventLog]::CreateEventSource( 'UnattendGenerator', 'Application' );
	};
	{
		Register-ScheduledTask -TaskName 'UnlockStartLayout' -Xml $( Get-Content -LiteralPath 'C:\Windows\Setup\Scripts\UnlockStartLayout.xml' -Raw );
	};
	{
		Remove-Item -LiteralPath 'C:\Users\Public\Desktop\Microsoft Edge.lnk' -ErrorAction 'SilentlyContinue' -Verbose;
	};
	{
		Set-ExecutionPolicy -Scope 'LocalMachine' -ExecutionPolicy 'RemoteSigned' -Force;
	};
	{
		reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f;
	};
	{
		reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v HideFirstRunExperience /t REG_DWORD /d 1 /f;
	};
	{
		reg.exe add "HKLM\Software\Policies\Microsoft\Edge\Recommended" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f;
		reg.exe add "HKLM\Software\Policies\Microsoft\Edge\Recommended" /v StartupBoostEnabled /t REG_DWORD /d 0 /f;
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\SetStartPins.ps1';
	};
	{
		try {
		  $bytes = &amp; 'C:\Windows\Setup\Scripts\GetWallpaper.ps1';
		  [System.IO.File]::WriteAllBytes( 'C:\Windows\Setup\Scripts\Wallpaper', $bytes );
		} catch {
		  $_;
		}
	};
	{
		try {
		  $bytes = &amp; 'C:\Windows\Setup\Scripts\GetLockScreenImage.ps1';
		  [System.IO.File]::WriteAllBytes( 'C:\Windows\Setup\Scripts\LockScreenImage', $bytes );
		  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v LockScreenImagePath /t REG_SZ /d "C:\Windows\Setup\Scripts\LockScreenImage" /f;
		} catch {
		  $_;
		}
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-01.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-02.ps1';
	};
	{
		reg.exe import "C:\Windows\Setup\Scripts\unattend-03.reg";
	};
);

&amp; {
  [float] $complete = 0;
  [float] $increment = 100 / $scripts.Count;
  foreach( $script in $scripts ) {
    Write-Progress -Id 0 -Activity 'Running scripts to customize your Windows installation. Do not close this window.' -PercentComplete $complete;
    '*** Will now execute command &#xAB;{0}&#xBB;.' -f $(
      $script.ToString().Trim() -replace '\s+', ' ' -replace '^(.{99})(.+)$', '$1&#x2026;';
    );
    $start = [datetime]::Now;
    &amp; $script;
    '*** Finished executing command after {0:0} ms.' -f [datetime]::Now.Subtract( $start ).TotalMilliseconds;
    "`r`n" * 3;
    $complete += $increment;
  }
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; "C:\Windows\Setup\Scripts\Specialize.log";
		</File>
		<File path="C:\Windows\Setup\Scripts\UserOnce.ps1">
$scripts = @(
	{
		[System.Diagnostics.EventLog]::WriteEntry( 'UnattendGenerator', "User '$env:USERNAME' has requested to unlock the Start menu layout.", [System.Diagnostics.EventLogEntryType]::Information, 1 );
	};
	{
		Remove-Item -LiteralPath "${env:USERPROFILE}\Desktop\Microsoft Edge.lnk" -ErrorAction 'SilentlyContinue' -Verbose;
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\SetWallpaper.ps1';
	};
);

&amp; {
  [float] $complete = 0;
  [float] $increment = 100 / $scripts.Count;
  foreach( $script in $scripts ) {
    Write-Progress -Id 0 -Activity 'Running scripts to configure this user account. Do not close this window.' -PercentComplete $complete;
    '*** Will now execute command &#xAB;{0}&#xBB;.' -f $(
      $script.ToString().Trim() -replace '\s+', ' ' -replace '^(.{99})(.+)$', '$1&#x2026;';
    );
    $start = [datetime]::Now;
    &amp; $script;
    '*** Finished executing command after {0:0} ms.' -f [datetime]::Now.Subtract( $start ).TotalMilliseconds;
    "`r`n" * 3;
    $complete += $increment;
  }
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; "$env:TEMP\UserOnce.log";
		</File>
		<File path="C:\Windows\Setup\Scripts\DefaultUser.ps1">
$scripts = @(
	{
		reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f;
	};
	{
		reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" /v "StartLayoutFile" /t REG_SZ /d "C:\Windows\Setup\Scripts\TaskbarLayoutModification.xml" /f;
		reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" /v "LockedStartLayout" /t REG_DWORD /d 1 /f;
	};
	{
		reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "UnattendedSetup" /t REG_SZ /d "powershell.exe -WindowStyle \""Normal\"" -ExecutionPolicy \""Unrestricted\"" -NoProfile -File \""C:\Windows\Setup\Scripts\UserOnce.ps1\""" /f;
	};
);

&amp; {
  [float] $complete = 0;
  [float] $increment = 100 / $scripts.Count;
  foreach( $script in $scripts ) {
    Write-Progress -Id 0 -Activity 'Running scripts to modify the default user&#x2019;&#x2019;s registry hive. Do not close this window.' -PercentComplete $complete;
    '*** Will now execute command &#xAB;{0}&#xBB;.' -f $(
      $script.ToString().Trim() -replace '\s+', ' ' -replace '^(.{99})(.+)$', '$1&#x2026;';
    );
    $start = [datetime]::Now;
    &amp; $script;
    '*** Finished executing command after {0:0} ms.' -f [datetime]::Now.Subtract( $start ).TotalMilliseconds;
    "`r`n" * 3;
    $complete += $increment;
  }
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; "C:\Windows\Setup\Scripts\DefaultUser.log";
		</File>
		<File path="C:\Windows\Setup\Scripts\FirstLogon.ps1">
$scripts = @(
	{
		Set-ItemProperty -LiteralPath 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoLogonCount' -Type 'DWord' -Force -Value 0;
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-04.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-05.ps1';
	};
	{
		Remove-Item -LiteralPath @(
		  'C:\Windows\Panther\unattend.xml';
		  'C:\Windows\Panther\unattend-original.xml';
		  'C:\Windows\Setup\Scripts\Wifi.xml';
		) -Force -ErrorAction 'SilentlyContinue' -Verbose;
	};
);

&amp; {
  [float] $complete = 0;
  [float] $increment = 100 / $scripts.Count;
  foreach( $script in $scripts ) {
    Write-Progress -Id 0 -Activity 'Running scripts to finalize your Windows installation. Do not close this window.' -PercentComplete $complete;
    '*** Will now execute command &#xAB;{0}&#xBB;.' -f $(
      $script.ToString().Trim() -replace '\s+', ' ' -replace '^(.{99})(.+)$', '$1&#x2026;';
    );
    $start = [datetime]::Now;
    &amp; $script;
    '*** Finished executing command after {0:0} ms.' -f [datetime]::Now.Subtract( $start ).TotalMilliseconds;
    "`r`n" * 3;
    $complete += $increment;
  }
} *&gt;&amp;1 | Out-String -Width 1KB -Stream &gt;&gt; "C:\Windows\Setup\Scripts\FirstLogon.log";
		</File>
	</Extensions>
</unattend>

'@

$Unattend | Out-File -FilePath "C:\Windows\Panther\Unattend.xml" -Encoding utf8 -Force

#=======================================================================
#   Restart-Computer
#=======================================================================
Write-Host  -ForegroundColor Green "Restarting in 10 seconds!"
Start-Sleep -Seconds 10
wpeutil reboot
