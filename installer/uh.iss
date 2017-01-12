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
#define APP_VERSION          "2017.1"
#endif

#define APP_NAME             "Unknown-Horizons"
#define APP_COMPILER         "VC14"
#define APP_PUBLISHER        "Unknown-Horizons Team"
#define APP_URL              "http://www.unknown-horizons.org/"
#define APP_SUPPORT_URL      "https://github.com/unknown-horizons/unknown-horizons/issues"
#define COPYRIGHT_YEAR        GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{8A27DF0C-689B-4B76-8BFC-AFCDD90C1A31}

; set application meta-data
AppName={#APP_NAME}
AppVerName={#APP_NAME} {#APP_VERSION}
AppVersion={#APP_VERSION}
AppCopyright=© {#APP_PUBLISHER}
AppPublisher={#APP_PUBLISHER}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_SUPPORT_URL}
AppUpdatesURL={#APP_URL}

; default installation folder is "c:\Unknown-Horizons". users might change this via dialog.
DefaultDirName=c:\Unknown-Horizons
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
; for example: "_build\Unknown-Horizons-2017.1-Setup-VC14-x86.exe"
OutputBaseFilename={#APP_NAME}-{#APP_VERSION}-Setup-{#APP_COMPILER}-x86
OutputDir=..\_build

; disable wizard pages: Welcome (by default), Ready
DisableReadyPage=yes

; enable wizard pages: Select Destination Location
DisableDirPage=no

; Tell Windows to reload the environment, because Registry change (env PATH change)
ChangesEnvironment=yes

; Tell Windows to reload the environment, because Registry change (file association change: .py)
ChangesAssociations=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Define the types of installations
; The user gets a drop-down list to select one of these types.
; Selecting a type will selected a set of components.
[Types]
Name: "full";          Description: "Full installation (game, engine)"
Name: "custom";        Description: "Custom installation"; Flags: iscustom

; Define components to install
[Components]
Name: "unknown_horizons"; Description: "[unknown-horizons] Unknown-Horizons";              Types: full;
Name: fifengine;          Description: "[fifengine] Fifengine - Isometric Game Engine";    Types: full;
Name: "Python";           Description: "[build tools] Python - programming language";    
Name: "Python\py27";      Description: "[build tools] Python v2.7";                        Types: full; Flags: exclusive

[Files]
Source: "..\repackage\unknown-horizons\*";      DestDir: "{app}\unknown-horizons";      Flags: recursesubdirs ignoreversion; Components: unknown_horizons
Source: "..\repackage\Python27\*";              DestDir: "{app}\python";                Flags: recursesubdirs ignoreversion; Components: "Python\py27"
; Fifengine below Python, because we are installing the python library into the Python installation folder
Source: "..\repackage\libfife.win32-py2.7.msi"; DestDir: "{app}\libfife";               Flags: recursesubdirs;               Components: fifengine

[Tasks]
Name: add_startmenu;       Description: Create Startmenu entries
Name: add_quicklaunchicon; Description: Create a &Quick Launch icon for Unknown Horizons; GroupDescription: Additional Icons:; Components: unknown_horizons
Name: add_desktopicon;     Description: Create a &Desktop icon for Unknown Horizons;      GroupDescription: Additional Icons:; Components: unknown_horizons

[Icons]
; define a group for the startmenu
Name: {group}\Start Unknown-Horizons; Filename: {app}\unknown-horizons\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_startmenu
Name: {group}\Uninstall; Filename: "{uninstallexe}"; Flags: preventpinning excludefromshowinnewinstall; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_startmenu
; desktop icon
Name: {userdesktop}\Unknown-Horizons; Filename: {app}\unknown-horizons\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_desktopicon
; quick launch icon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\Unknown Horizons; Filename: {app}\run_uh.bat; IconFilename: "{app}\unknown-horizons\content\gfx\uh.ico"; Tasks: add_quicklaunchicon

; Define items to run automatically on installation...
[Run]
; install "libfife for python2.7" only when "python27" and "fifengine" are selected
; install silently into the target dir
Filename: "msiexec.exe"; Parameters: "/i ""{app}\libfife\libfife.win32-py2.7.msi"" TARGETDIR=""{app}\python"" /qn"; StatusMsg: "Installing libFife for Python2.7"; Components: Python\py27 and fifengine

; Define items to run automatically on un-installation...
[UninstallRun]
; un-install "libfife"
Filename: "msiexec.exe"; Parameters: "/x ""{app}\libfife\libfife.win32-py2.7.msi"" /qn"; StatusMsg: "Uninstalling libFife for Python2.7"; Flags: runascurrentuser runhidden

[UninstallDelete]
;Type: filesandordirs; Name: "{userdocs}\My Games\unknown-horizons"
Type: filesandordirs; Name: "{app}\python"
Type: filesandordirs; Name: "{app}\unknown-horizons"

[Registry]
; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
;
; add path to Python
Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python')); Components: Python\py27;
;
; add path to libfife
Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python\Lib\site-packages\fife"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python\Lib\site-packages\fife')); Components: fifengine;
;
; Create File Association
Root: HKCR; Subkey: ".py";                            ValueType: string; ValueName: ""; ValueData: "Python.File"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "Python.File";                    ValueType: string; ValueName: ""; ValueData: "Python File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Python.File\DefaultIcon";        ValueType: string; ValueName: ""; ValueData: "{app}\python\DLLs\py.ico"
Root: HKCR; Subkey: "Python.File\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\python\python.exe"" ""%1"" %*"
   
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
    RemovePathLocalUser(ExpandConstant('{app}') + '\python');    
    // 3. refresh environment, so that the modified PATH var is activated
    RefreshEnvironment();
  end;
end;
