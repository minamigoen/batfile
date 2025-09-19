@echo off
chcp 65001 >nul
setlocal

:: この .bat が置いてあるフォルダ（末尾 \ 付き）
set "HERE=%~dp0"
set "FILE=%HERE%paths.txt"

if not exist "%FILE%" (
  echo 設定ファイルが見つかりません: "%FILE%"
  pause
  exit /b 1
)

:: 1行目=SRC, 2行目=DST を丸ごと読み取り（空白や日本語を保持）
for /f "usebackq tokens=1* delims=" %%A in ("%FILE%") do (
  if not defined SRC (set "SRC=%%A") else if not defined DST (set "DST=%%A")
)

echo.
echo 実行コマンド:
echo robocopy "%SRC%" "%DST%" /E /XO /FFT /Z /R:3 /W:5 /MT:2 /J
echo.
pause

robocopy "%SRC%" "%DST%" /E /XO /FFT /Z /R:3 /W:5 /MT:2 /J

echo.
echo 完了しました。
pause
