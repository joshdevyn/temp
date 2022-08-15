<#
    .SYNOPSIS
Downloads and configures .NuGet Base, PowershellGet, NuGet v2, ChromeDriver, IEDriver, MSEdgeDriver, WinAppDriver.
#>
     
     
Write-Output \'Updating Windows Dependencies\'

Write-Output \'Updating SecurityProtocolType\'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Output \'Install NuGet Base\'
Install-PackageProvider -Name NuGet -Force

Write-Output \'Update PowershellGet\'
Install-Module PowershellGet -Force
Update-Module -Name PowerShellGet

Write-Output \'Install NuGet v2\'
Register-PackageSource -Name MyNuGet -Location https://www.nuget.org/api/v2 -ProviderName NuGet -Trusted

Write-Output \'Creating directory for web drivers\'
New-Item -Path "C:\\" -Name "tools" -ItemType "directory" -Force
New-Item -Path "C:\\tools\\" -Name "selenium" -ItemType "directory" -Force

Write-Output \'Installing ChromeDriver\'
Install-Package Selenium.WebDriver.ChromeDriver -Destination "C:\\tools\\selenium" -Force

Write-Output \'Installing IEDriver\'
Install-Package Selenium.WebDriver.IEDriver -Destination "C:\\tools\\selenium" -Force

Write-Output \'Installing MSEdgeDriver\'
Install-Package Selenium.WebDriver.MSEdgeDriver -Destination "C:\\tools\\selenium" -Force
ls C:\\tools\\selenium

Write-Output \'Installing WinAppDriver and checking install\'
New-Item -Path "C:\\Program Files (x86)\\" -Name "Windows Application Driver" -ItemType "directory"
Invoke-WebRequest 'https://github.com/microsoft/WinAppDriver/releases/download/v1.2.1/WindowsApplicationDriver_1.2.1.msi' -Method 'GET' -OutFile 'WindowsApplicationDriver.msi'
Start-Process msiexec.exe -Wait -ArgumentList \'/i C:\\Program Files (x86)\\Windows Application Driver\\WindowsApplicationDriver.msi /QN /L*V C:\\Program Files (x86)\\Windows Application Driver\\temp\\msilog.log\'
cd "C:\\Program Files (x86)\\Windows Application Driver"
ls
