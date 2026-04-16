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
    Firmware = $true
}
Start-OSDCloud @Params



#================================================
#  [PostOS] Skip OOBE + AutoLogon
#================================================
Write-Host -ForegroundColor Green "Configurando Skip OOBE e AutoLogon"

$Unattend = @'
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
	<!--https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=pt-PT&Locale=pt-PT&Keyboard=00000816&GeoLocation=193&ProcessorArchitecture=amd64&ComputerNameMode=Random&CompactOsMode=Default&TimeZoneMode=Explicit&TimeZone=GMT+Standard+Time&PartitionMode=Interactive&DiskAssertionMode=Skip&WindowsEditionMode=Generic&WindowsEdition=enterprise&InstallFromMode=Automatic&PEMode=Default&UserAccountMode=Unattended&AccountName0=suporte&AccountDisplayName0=Suporte&AccountPassword0=aifrd5d&AccountGroup0=Administrators&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=Hidden&TaskbarSearch=Box&TaskbarIconsMode=Custom&TaskbarIconsXml=%3CLayoutModificationTemplate+xmlns%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FLayoutModification%22+xmlns%3Adefaultlayout%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FFullDefaultLayout%22+xmlns%3Astart%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FStartLayout%22+xmlns%3Ataskbar%3D%22http%3A%2F%2Fschemas.microsoft.com%2FStart%2F2014%2FTaskbarLayout%22+Version%3D%221%22%3E%0D%0A++%3CCustomTaskbarLayoutCollection+PinListPlacement%3D%22Replace%22%3E%0D%0A++++%3Cdefaultlayout%3ATaskbarLayout%3E%0D%0A++++++%3Ctaskbar%3ATaskbarPinList%3E%0D%0A++++++++%3Ctaskbar%3ADesktopApp+DesktopApplicationID%3D%22Microsoft.Windows.Explorer%22+%2F%3E%0D%0A++++++++%3Ctaskbar%3AUWA+AppUserModelID%3D%22windows.immersivecontrolpanel_cw5n1h2txyewy%21microsoft.windows.immersivecontrolpanel%22+%2F%3E%0D%0A++++++++%3Ctaskbar%3ADesktopApp+DesktopApplicationLinkPath%3D%22%25APPDATA%25%5CMicrosoft%5CWindows%5CStart+Menu%5CPrograms%5CWindows+PowerShell%5CWindows+PowerShell.lnk%22+%2F%3E%0D%0A++++++%3C%2Ftaskbar%3ATaskbarPinList%3E%0D%0A++++%3C%2Fdefaultlayout%3ATaskbarLayout%3E%0D%0A++%3C%2FCustomTaskbarLayoutCollection%3E%0D%0A%3C%2FLayoutModificationTemplate%3E&DisableWidgets=true&StartTilesMode=Default&StartPinsMode=Custom&StartPinsJson=%7B%0D%0A++%22pinnedList%22%3A+%5B%0D%0A++++%7B%0D%0A++++++%22desktopAppLink%22%3A+%22%25ALLUSERSPROFILE%25%5C%5CMicrosoft%5C%5CWindows%5C%5CStart+Menu%5C%5CPrograms%5C%5CMicrosoft+Edge.lnk%22%0D%0A++++%7D%2C%0D%0A++++%7B%0D%0A++++++%22desktopAppLink%22%3A+%22%25APPDATA%25%5C%5CMicrosoft%5C%5CWindows%5C%5CStart+Menu%5C%5CPrograms%5C%5CFile+Explorer.lnk%22%0D%0A++++%7D%2C%0D%0A++++%7B%0D%0A++++++%22packagedAppId%22%3A+%22windows.immersivecontrolpanel_cw5n1h2txyewy%21microsoft.windows.immersivecontrolpanel%22%0D%0A++++%7D%0D%0A++%5D%0D%0A%7D&AllowPowerShellScripts=true&HideEdgeFre=true&DisableEdgeStartupBoost=true&EffectsMode=Default&DeleteEdgeDesktopIcon=true&DesktopIconsMode=Default&StartFoldersMode=Default&WifiMode=Interactive&ExpressSettings=DisableAll&LockKeysMode=Skip&StickyKeysMode=Default&ColorMode=Default&WallpaperMode=Default&LockScreenMode=Default&Remove3DViewer=true&RemoveBingSearch=true&RemoveClipchamp=true&RemoveClock=true&RemoveCortana=true&RemoveDevHome=true&RemoveFamily=true&RemoveFeedbackHub=true&RemoveGameAssist=true&RemoveGetHelp=true&RemoveMailCalendar=true&RemoveMaps=true&RemoveMediaFeatures=true&RemoveMixedReality=true&RemoveZuneVideo=true&RemoveNews=true&RemoveOffice365=true&RemoveOneNote=true&RemoveOneSync=true&RemoveOutlook=true&RemovePaint=true&RemovePaint3D=true&RemovePeople=true&RemovePowerAutomate=true&RemoveQuickAssist=true&RemoveSkype=true&RemoveSolitaire=true&RemoveStickyNotes=true&RemoveTeams=true&RemoveToDo=true&RemoveVoiceRecorder=true&RemoveWallet=true&RemoveWeather=true&RemoveFaxAndScan=true&RemoveWindowsMediaPlayer=true&RemoveZuneMusic=true&RemoveXboxApps=true&RemoveYourPhone=true&SystemScript0=powercfg.exe+%2FHIBERNATE+OFF&SystemScriptType0=Cmd&FirstLogonScript0=Set-ExecutionPolicy+Bypass+-Scope+Process+-Force%3B+%5BSystem.Net.ServicePointManager%5D%3A%3ASecurityProtocol+%3D+%5BSystem.Net.ServicePointManager%5D%3A%3ASecurityProtocol+-bor+3072%3B+iex+%28%28New-Object+System.Net.WebClient%29.DownloadString%28%27https%3A%2F%2Fcommunity.chocolatey.org%2Finstall.ps1%27%29%29%0D%0A%0D%0A%24scriptUrl+%3D+%22https%3A%2F%2Fraw.githubusercontent.com%2Fnunomeiras%2FChoco%2Frefs%2Fheads%2Fmain%2Fapps_basicas.ps1%22%0D%0A%0D%0A%23+Download+and+execute+the+script%0D%0AInvoke-WebRequest+-Uri+%24scriptUrl+-OutFile+%22%24env%3ATEMP%5Cscript.ps1%22%0D%0A%26+%22%24env%3ATEMP%5Cscript.ps1%22&FirstLogonScriptType0=Ps1&FirstLogonScript1=Write-Host+-ForegroundColor+Cyan+%22Procurando+pen+USB+com+Office...%22%0D%0A%0D%0A%24OfficeInstalled+%3D+%24false%0D%0A%0D%0A%24Drives+%3D+Get-Volume+%7C+Where-Object+%7B%0D%0A++++%24_.DriveType+-eq+%27Removable%27+-and+%24_.DriveLetter%0D%0A%7D%0D%0A%0D%0Aforeach+%28%24Drive+in+%24Drives%29+%7B%0D%0A++++%24Path+%3D+%22%24%28%24Drive.DriveLetter%29%3A%5COffice%5Csetup.exe%22%0D%0A++++%24Config+%3D+%22%24%28%24Drive.DriveLetter%29%3A%5COffice%5Cconfig.xml%22%0D%0A%0D%0A++++if+%28Test-Path+%24Path%29+%7B%0D%0A++++++++Write-Host+-ForegroundColor+Green+%22Office+encontrado+em+%24Path%22%0D%0A%0D%0A++++++++if+%28Test-Path+%24Config%29+%7B%0D%0A++++++++++++Write-Host+%22Instalando+Office+com+config.xml...%22%0D%0A++++++++++++Start-Process+-FilePath+%24Path+-ArgumentList+%22%2Fconfigure+%60%22%24Config%60%22%22+-Wait%0D%0A++++++++%7D%0D%0A++++++++else+%7B%0D%0A++++++++++++Write-Host+%22Instalando+Office+modo+default...%22%0D%0A++++++++++++Start-Process+-FilePath+%24Path+-ArgumentList+%22%2Fquiet%22+-Wait%0D%0A++++++++%7D%0D%0A%0D%0A++++++++%24OfficeInstalled+%3D+%24true%0D%0A++++++++break%0D%0A++++%7D%0D%0A%7D%0D%0A%0D%0Aif+%28-not+%24OfficeInstalled%29+%7B%0D%0A++++Write-Host+-ForegroundColor+Yellow+%22Nenhuma+instala%C3%A7%C3%A3o+do+Office+encontrada+na+pen.%22%0D%0A%7D&FirstLogonScriptType1=Ps1&FirstLogonScript2=%24Serial+%3D+%28Get-CimInstance+Win32_BIOS%29.SerialNumber%0D%0A%24Suffix+%3D+%24Serial.Substring%28%24Serial.Length+-+5%29%0D%0A%24NewName+%3D+%22CMP-%24Suffix%22%0D%0ARename-Computer+-NewName+%24NewName+-Force&FirstLogonScriptType2=Ps1&WdacMode=Skip&AppLockerMode=Skip-->
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
		<File path="C:\Windows\Setup\Scripts\unattend-01.cmd">
powercfg.exe /HIBERNATE OFF
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-02.ps1">
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$scriptUrl = "https://raw.githubusercontent.com/nunomeiras/Choco/refs/heads/main/apps_basicas.ps1"

# Download and execute the script
Invoke-WebRequest -Uri $scriptUrl -OutFile "$env:TEMP\script.ps1"
&amp; "$env:TEMP\script.ps1"
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-03.ps1">
Write-Host -ForegroundColor Cyan "Procurando pen USB com Office..."

$OfficeInstalled = $false

$Drives = Get-Volume | Where-Object {
    $_.DriveType -eq 'Removable' -and $_.DriveLetter
}

foreach ($Drive in $Drives) {
    $Path = "$($Drive.DriveLetter):\Office\setup.exe"
    $Config = "$($Drive.DriveLetter):\Office\config.xml"

    if (Test-Path $Path) {
        Write-Host -ForegroundColor Green "Office encontrado em $Path"

        if (Test-Path $Config) {
            Write-Host "Instalando Office com config.xml..."
            Start-Process -FilePath $Path -ArgumentList "/configure `"$Config`"" -Wait
        }
        else {
            Write-Host "Instalando Office modo default..."
            Start-Process -FilePath $Path -ArgumentList "/quiet" -Wait
        }

        $OfficeInstalled = $true
        break
    }
}

if (-not $OfficeInstalled) {
    Write-Host -ForegroundColor Yellow "Nenhuma instala&#xE7;&#xE3;o do Office encontrada na pen."
}
		</File>
		<File path="C:\Windows\Setup\Scripts\unattend-04.ps1">
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
		C:\Windows\Setup\Scripts\unattend-01.cmd;
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
		&amp; 'C:\Windows\Setup\Scripts\unattend-02.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-03.ps1';
	};
	{
		&amp; 'C:\Windows\Setup\Scripts\unattend-04.ps1';
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
