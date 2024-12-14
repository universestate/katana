```iss
; -- https://jrsoftware.org/ --

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!
[Setup]
AppName=Katana Compiler.
AppVersion=0.0.4
PrivilegesRequired=none
DefaultDirName={userdesktop}\
AllowNoIcons=no
DirExistsWarning=no
DisableDirPage=no
OutputDir=path\to\output
OutputBaseFilename=Installer
Compression=lzma
SolidCompression=yes
SetupIconFile=path\to\default.ico

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
