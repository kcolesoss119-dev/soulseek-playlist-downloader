@echo off
title Playlist Downloader
cd /d "%~dp0"
set "HERE=%~dp0"

rem ===== Settings =====
rem Where your music gets saved (one folder per playlist)
set "MUSIC_DIR=%HERE%Music"

rem Extra options. If lots of songs come back "not found", add --length-tol 10
set "EXTRA=--concurrent-jobs 3"
rem ====================

if not exist "sockseek.exe" (
  echo Can't find sockseek.exe in this folder.
  echo Download the Windows release from github.com/fiso64/sockseek/releases
  echo and put sockseek.exe in the same folder as this file.
  echo.
  pause
  exit /b
)

if not exist "failed.ps1" (
  echo Can't find failed.ps1 - put it in the same folder as this file.
  echo.
  pause
  exit /b
)

if not exist "prep.ps1" (
  echo Can't find prep.ps1 - put it in the same folder as this file.
  echo.
  pause
  exit /b
)

if not exist "sockseek.conf" (
  copy /y "sockseek.conf.example" "sockseek.conf" >nul
  echo First run: made your settings file, sockseek.conf.
  echo Put in your Soulseek username and password, save it, then run this again.
  echo.
  start "" notepad "sockseek.conf"
  pause
  exit /b
)

findstr /c:"YOUR_SOULSEEK_USERNAME" "sockseek.conf" >nul 2>&1
if not errorlevel 1 (
  echo Open sockseek.conf in Notepad and put in your Soulseek username and password first.
  echo.
  pause
  exit /b
)

if not exist "Playlists" mkdir "Playlists"
if not exist "%HERE%.work" mkdir "%HERE%.work"

rem You can also drag CSV files onto this .bat file
if not "%~1"=="" (
  for %%F in (%*) do call :grab "%%~fF"
  goto done
)

if not exist "Playlists\*.csv" (
  echo No playlists found.
  echo Export a playlist with Exportify and put the .csv file in the Playlists folder.
  goto done
)

for %%F in ("Playlists\*.csv") do call :grab "%%~fF"
goto done

:grab
echo.
echo ==================== "%~n1" ====================
rem Add each song's real length so live/remix versions get rejected
powershell -NoProfile -ExecutionPolicy Bypass -File "%HERE%prep.ps1" "%~1" "%HERE%.work\%~nx1"
if errorlevel 1 (
  echo Couldn't read "%~nx1" - skipping it.
  exit /b
)
sockseek.exe "%HERE%.work\%~nx1" -c "%HERE%sockseek.conf" -o "%MUSIC_DIR%" --artist-col "Artist Name(s)" --title-col "Track Name" --album-col "Album Name" --length-col "Length" --remove-ft --pref-strict-artist %EXTRA% %DEEP%
powershell -NoProfile -ExecutionPolicy Bypass -File "%HERE%failed.ps1" "%MUSIC_DIR%\%~n1"
if defined COOLDOWN (
  echo Letting Windows free up connections for %COOLDOWN% seconds before the next playlist...
  timeout /t %COOLDOWN% /nobreak >nul
)
exit /b

:done
echo.
echo All done. Your music is in the Music folder.
echo Each playlist folder has a "Failed songs.txt" listing anything that didn't download.
echo Run this again anytime - songs you already have get skipped.
echo.
pause
