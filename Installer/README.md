```ini
[Setup]
AppName=Katana
AppVersion=0.4
PrivilegesRequired=none
DefaultDirName={userdesktop}\
AllowNoIcons=yes
DirExistsWarning=no
DisableDirPage=no
OutputDir=path\to\output
OutputBaseFilename=Katana-Installer
Compression=lzma
SolidCompression=yes

[Files]
Source: "InstallerFiles\pwn-cmd.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "InstallerFiles\pwn-start.cmd"; DestDir: "{app}"; Flags: ignoreversion

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
