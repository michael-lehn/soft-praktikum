@echo off
set SCRIPT=install_logout_task.ps1

:: Run PowerShell script with admin rights
echo Running as admin...
runas /user:Administrator "powershell -ExecutionPolicy Bypass -File \"%SCRIPT%\""

