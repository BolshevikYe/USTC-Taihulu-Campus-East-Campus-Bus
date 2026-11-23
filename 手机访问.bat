@echo off
chcp 65001 >nul
title 园区班车 - 手机访问
cd /d "%~dp0"

set "PORT=8686"
set "PY="
where python >nul 2>nul && set "PY=python"
if not defined PY (where py >nul 2>nul && set "PY=py")

echo.
echo   园区班车 · 用手机浏览器打开下面的地址
echo   --------------------------------------------------
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
  for /f "tokens=1" %%b in ("%%a") do echo        http://%%b:%PORT%/
)
echo   --------------------------------------------------
echo   手机和电脑连同一个 Wi-Fi 才能打开
echo   建议在手机上「添加到主屏幕」，以后一点就开
echo   关掉这个窗口 = 停止服务
echo.

if defined PY (
  start "" "http://127.0.0.1:%PORT%/"
  %PY% -m http.server %PORT% --bind 0.0.0.0
) else (
  echo   没找到 Python。
  echo   也可以直接把 index.html 发到手机，用浏览器打开，一样能用。
  pause
)
