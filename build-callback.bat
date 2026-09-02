@echo off
setlocal

rem Build AutoHotkey_H with the callback-enabled DLL configuration.
set "PLATFORM=%~1"
if "%PLATFORM%"=="" set "PLATFORM=x64"

set "CONFIGURATION=%~2"
if "%CONFIGURATION%"=="" set "CONFIGURATION=Debug.dll"

set "TARGET=%~3"
if "%TARGET%"=="" set "TARGET=Build"

call "%~dp0vsc-build-env.cmd"
if errorlevel 1 (
    echo Could not find the Visual Studio build environment.
    exit /b 1
)

msbuild "%~dp0AutoHotkeyx.sln" ^
  /p:Platform=%PLATFORM% ^
  /p:Configuration=%CONFIGURATION% ^
  /t:%TARGET% ^
  /p:GenerateFullPaths=true ^
  /consoleloggerparameters:NoSummary

set "BUILD_EXIT=%ERRORLEVEL%"
if not "%BUILD_EXIT%"=="0" (
    echo Build failed with exit code %BUILD_EXIT%.
    exit /b %BUILD_EXIT%
)

echo Build succeeded: %CONFIGURATION%^|%PLATFORM%

copy "C:\Users\Samir\Desktop\learning_cpp\AutoHotkey_H\bin_debug\x64\AutoHotkey64.dll" "C:\Users\Samir\Desktop\learning_cpp\keyboard_profile\lib\AutoHotkey64.dll"
endlocal
