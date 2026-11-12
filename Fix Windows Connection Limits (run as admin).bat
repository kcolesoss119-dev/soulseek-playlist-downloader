@echo off
title Fix Windows Connection Limits
net session >nul 2>&1
if errorlevel 1 (
  echo This needs admin rights.
  echo Right-click this file and choose "Run as administrator".
  echo.
  pause
  exit /b
)
echo Giving Windows more connection slots and freeing closed ones faster...
echo.
rem 1. More ports for outgoing connections (Windows default is about 16,000)
netsh int ipv4 set dynamicport tcp start=10000 num=55535
netsh int ipv6 set dynamicport tcp start=10000 num=55535
rem 2. Free closed connections after 30 seconds instead of the default 2 minutes
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f
echo.
echo Done. RESTART your PC for this to take effect.
echo To undo it later, run "Undo Connection Fix (run as admin).bat".
echo.
pause
