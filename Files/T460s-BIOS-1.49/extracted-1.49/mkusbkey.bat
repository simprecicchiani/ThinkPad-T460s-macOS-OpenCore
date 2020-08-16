@echo off
  echo.
  echo   Windows tool to create a bootable BIOS flash USB memory key
  echo   Version 1.00
  echo.

set Drive=%1
set DefaultDir=%~dp0

if "%1"=="" goto syntaxError

  echo.
  echo   Creating directories.
  echo.

mkdir %Drive%\EFI\Boot
if errorlevel 1 goto not_dir
mkdir %Drive%\Flash
if errorlevel 1 goto not_dir

  echo.
  echo   Copying files.
  echo.

copy BootX64.efi    %Drive%\EFI\Boot\BootX64.efi       >NUL
if errorlevel 1 goto not_file
xcopy  /S /E *.*  %Drive%\Flash\      >NUL
if errorlevel 1 goto not_file


  echo.
  echo   Deleting unnecessary files.
  echo.

del %Drive%\Flash\*.exe
del %Drive%\Flash\*.bat
del %Drive%\Flash\*.txt
del %Drive%\Flash\*.config

rmdir /S /Q %Drive%\Flash\32bit
rmdir /S /Q %Drive%\Flash\64bit

goto Complete

:syntaxError
  echo.
  echo Syntax : mkusbkey [Drive]
  echo.
  echo [Drive]
  echo  D:,E:,F:... : Drive letter of USB memory key
  echo.
  echo Example : mkusbkey D:
  echo.
goto exit


:not_dir
  echo.
  echo ERROR: Directory was not able to be created in USB memory key. 
  echo.
goto exit

:not_file
  echo.
  echo ERROR: Related file was not able to be copied to USB memory key.
  echo.
goto exit

:Complete
  echo.
  echo Operation completed successfully.
  echo.

:exit
cd %DefaultDir%
set Drive=
set DefaultDir=
