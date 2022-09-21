@echo off
Net session >nul 2>&1 || (PowerShell start -verb runas '%~0' &exit /b)
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
powershell -command Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
if not exist "wsl_update_x64.msi" (
	powershell Invoke-WebRequest "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "wsl_update_x64.msi"
	start wsl_update_x64.msi
)
wsl --set-default-version 2
wsl --install -d kali-linux
wsl --set-version kali-linux 2
wsl sudo apt update -y
wsl sudo apt install -y kali-win-kex
::wsl sudo apt install -y kali-linux-large
msg * The setup is complete run the microsoft Kali Linux application and type the following code: kex --esm --ip --sound
pause