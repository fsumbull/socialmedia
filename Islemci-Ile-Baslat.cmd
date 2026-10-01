@echo off
cd /d "%~dp0"
set MINILLM_GPU_LAYERS=0
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\launch.ps1"
if errorlevel 1 pause
