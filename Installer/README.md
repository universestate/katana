```
Link: https://tinyurl.com/katana-installer
```
```iss
; Source:

; -- https://jrsoftware.org/ --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Katana
AppVersion=0.4
PrivilegesRequired=none
DefaultDirName={userdesktop}\
AllowNoIcons=yes
DirExistsWarning=no
DisableDirPage=no
OutputDir=path\to\output
OutputBaseFilename=Installer
Compression=lzma
SolidCompression=yes

[Files]
Source: "path\to\pwn-cmd.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "path\to\pwn-start.cmd"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Run Katana-CMD"; Filename: "{app}\pwn-cmd.cmd"
Name: "{group}\Run Katana-START"; Filename: "{app}\pwn-start.cmd"

[Code]
function IsAdmin: Boolean;
external 'IsUserAnAdmin@shell32.dll stdcall';

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
  begin
  end;
end;
```
