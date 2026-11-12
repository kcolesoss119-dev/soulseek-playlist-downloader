@echo off
rem Re-runs your playlists, retrying ONLY the songs that failed, with a deeper
rem search (-d) to get around blocked or oddly named files.
rem Tuned to stay gentle on Windows' connection limits:
rem   one search at a time, 2 downloads at a time, and a 2-minute break between playlists.
set "DEEP=-d --concurrent-searches 1 --concurrent-jobs 2"
set "COOLDOWN=120"
call "%~dp0Download Playlists.bat" %*
