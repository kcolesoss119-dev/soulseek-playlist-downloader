@echo off
title Undo Connection Fix
net session >nul 2>&1
if errorlevel 1 (
  echo This needs admin rights.
  echo Right-click this file and choose "Run as administrator".
  echo.
  pause
  exit /b
)
netsh int ipv4 set dynamicport tcp start=49152 num=16384
netsh int ipv6 set dynamicport tcp start=49152 num=16384
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /f
echo.
echo Back to Windows defaults. Restart your PC for it to take effect.
echo.
pause
