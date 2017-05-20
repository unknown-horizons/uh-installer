;
;          _\|/_
;          (o o)
; +-----oOO-{_}-OOo------------------------------------------------------+
; |                                                                      |
; |  Unknown-Horizons - Inno Setup Script File                           |
; |  -------------------------------------------------------             |
; |                                                                      |
; |  Author:   Jens A. Koch <jakoch@web.de>                              |
; |  Author:   Thomas Kowaliczek-Schmer <thomas.kowaliczek@posteo.de>    |
; |  License:  MIT                                                       |
; |                                                                      |
; |  For the full copyright and license information, please view         |
; |  the LICENSE file that was distributed with this source code.        |
; |                                                                      |
; |  Note for developers                                                 |
; |  -------------------                                                 |
; |  A good resource for developing and understanding                    |
; |  Inno Setup Script files is the official "Inno Setup Help".          |
; |  Website:  http://jrsoftware.org/ishelp/index.php                    |
; |                                                                      |
; +---------------------------------------------------------------------<3

; version is set here, when the version isn't passed to the compiler on invocation
#ifndef APP_VERSION
#define APP_VERSION          "2017.2"
#endif

#define APP_NAME             "Unknown-Horizons"
#define APP_COMPILER         "VC14"
#define APP_PUBLISHER        "Unknown-Horizons Team"
#define APP_URL              "http://www.unknown-horizons.org/"
#define APP_SUPPORT_URL      "https://github.com/unknown-horizons/unknown-horizons/issues"
#define COPYRIGHT_YEAR        GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{797B9070-BD1B-4DD9-8434-3A02697F9984}

; set application meta-data
AppName={#APP_NAME}
AppVerName={#APP_NAME} {#APP_VERSION}
AppVersion={#APP_VERSION}
AppCopyright=© {#APP_PUBLISHER}
AppPublisher={#APP_PUBLISHER}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_SUPPORT_URL}
AppUpdatesURL={#APP_URL}
UninstallDisplayIcon={app}\unknown-horizons\content\gfx\uh.ico
UninstallDisplayName={#APP_NAME}

; default installation folder is "C:\Unknown-Horizons". users might change this via dialog.
DefaultDirName=C:\Unknown-Horizons
DefaultGroupName={#APP_NAME}
DirExistsWarning=No
EnableDirDoesntExistWarning=Yes
AllowNoIcons=yes

; compression
Compression=lzma2/ultra
LZMAUseSeparateProcess=yes
LZMANumBlockThreads=2
InternalCompressLevel=max
SolidCompression=true

; style
WizardImageFile=images\WizardImage.bmp
WizardSmallImageFile=images\WizardSmallImage.bmp
SetupIconFile=images\uh.ico
 
; this creates the installer executable in the build folder
; for example: "_build\Unknown-Horizons-2017.2-Setup-VC14-x86.exe"
OutputBaseFilename={#APP_NAME}-{#APP_VERSION}-Setup-{#APP_COMPILER}-x86
OutputDir=..\_build

; disable wizard pages: Welcome (by default), Ready
DisableReadyPage=yes

; enable wizard pages: Select Destination Location
DisableDirPage=no

; Tell Windows to reload the environment, because Registry change (env PATH change)
ChangesEnvironment=yes

; Logging
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Define the types of installations
; The user gets a drop-down list to select one of these types.
; Selecting a type will selected a set of components.
[Types]
Name: "full";          Description: "Full installation (game and engine)"
Name: "custom";        Description: "Custom installation"; Flags: iscustom

; Define components to install
[Components]
Name: "unknown_horizons"; Description: "[unknown-horizons] Unknown-Horizons";              Types: full
Name: vcredist2015;       Description: "[dep libs] VCRedist2015";                          Types: full

[Files]
Source: "..\repackage\unknown-horizons\*";      DestDir: "{app}\unknown-horizons";      Flags: recursesubdirs ignoreversion; Components: unknown_horizons
Source: "..\repackage\Python27\*";              DestDir: "{app}\python";                Flags: recursesubdirs ignoreversion; Components: unknown_horizons
Source: "..\repackage\vc_redist.x86.exe";       DestDir: "{tmp}";                       Flags: deleteafterinstall;           Components: unknown_horizons

[Tasks]
Name: add_startmenu;       Description: Create Startmenu entries;                         Components: unknown_horizons
Name: add_quicklaunchicon; Description: Create a &Quick Launch icon for Unknown Horizons; GroupDescription: Additional Icons:; Components: unknown_horizons
Name: add_desktopicon;     Description: Create a &Desktop icon for Unknown Horizons;      GroupDescription: Additional Icons:; Components: unknown_horizons

[Icons]
; define a group for the startmenu
Name: {group}\Start Unknown-Horizons; Filename: {app}\unknown-horizons\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_startmenu
Name: {group}\Start Unknown-Horizons Debug; Filename: {app}\unknown-horizons\run_uh.bat; Parameters: "--debug"; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_startmenu
Name: {group}\Uninstall Unknown-Horizons; Filename: "{uninstallexe}"; Tasks: add_startmenu
; desktop icon
Name: {userdesktop}\Unknown-Horizons; Filename: {app}\unknown-horizons\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_desktopicon
; quick launch icon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\Unknown Horizons; Filename: {app}\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_quicklaunchicon

; Define items to run automatically on installation...
[Run]
; add the Parameters, WorkingDir and StatusMsg as you wish, just keep here
; the conditional installation Check
Filename: "{tmp}\vc_redist.x86.exe"; Parameters: "/q /norestart"; Check: VCRedistNeedsInstall; StatusMsg: "Installing VC++ redistributables..."

[UninstallDelete]
;Type: filesandordirs; Name: "{userdocs}\My Games\unknown-horizons"
Type: filesandordirs; Name: "{app}\python"
Type: filesandordirs; Name: "{app}\unknown-horizons"

[Registry]
; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
; add path to fife (because libpng16-16.dll and other dependencies needs to be found)
Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python\Lib\site-packages\fife"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python\Lib\site-packages\fife')); Components: unknown_horizons

[Code]
// modification and path lookup helper for env PATH 
#include "includes\envpath.iss"

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  // Removing a path from the PATH variable works in 3 steps:
  // 1. get the old env var PATH
  if (CurUninstallStep =  usUninstall) then
  begin
    SaveOldPathLocalUser();
  end;  
  // 2. remove paths from the env var PATH 
  if (CurUninstallStep = usPostUninstall) then
  begin
    RemovePathLocalUser(ExpandConstant('{app}') + '\python\Lib\site-packages\fife');   
    // 3. refresh environment, so that the modified PATH var is activated
    RefreshEnvironment();
  end;
end;

#IFDEF UNICODE
  #DEFINE AW "W"
#ELSE
  #DEFINE AW "A"
#ENDIF
type
  INSTALLSTATE = Longint;
const
  INSTALLSTATE_INVALIDARG = -2;  { An invalid parameter was passed to the function. }
  INSTALLSTATE_UNKNOWN = -1;     { The product is neither advertised or installed. }
  INSTALLSTATE_ADVERTISED = 1;   { The product is advertised but not installed. }
  INSTALLSTATE_ABSENT = 2;       { The product is installed for a different user. }
  INSTALLSTATE_DEFAULT = 5;      { The product is installed for the current user. }

  // Visual C++ 2015 Redistributable 14.0.24215.1
  VC_2015_REDIST_X86 = '{e2803110-78b3-4664-a479-3611a381656a}';
//  VC_2015_REDIST_X64 = '{d992c12e-cab2-426f-bde3-fb8c53950b0d}';

function MsiQueryProductState(szProduct: string): INSTALLSTATE;
  external 'MsiQueryProductState{#AW}@msi.dll stdcall';

function VCVersionInstalled(const ProductID: string): Boolean;
begin
  Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;

function VCRedistNeedsInstall: Boolean;
begin
  Result := not (VCVersionInstalled(VC_2015_REDIST_X86));
end;
