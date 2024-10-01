@echo off
setlocal

:: PowerShellでファイル選択ダイアログを表示
set "filePath="
for /f "delims=" %%I in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.OpenFileDialog; $dialog.Filter = 'All Files (*.*)|*.*'; if ($dialog.ShowDialog() -eq 'OK') { $dialog.FileName }"') do set "filePath=%%I"

:: ファイルの存在チェック
if not exist "%filePath%" (
    echo エラー：参照ファイルがみつからない。
    pause
    exit /b
)

:: PowerShellでファイルサイズを取得
for /f "delims=" %%A in ('powershell -command "(Get-Item '%filePath%').length"') do set "fileSize=%%A"

:: サイズを各単位に変換
echo 計算中... しばらくお待ちください。

:: カウントダウンの開始
for /L %%i in (3,-1,1) do (
    echo %%i
    timeout /t 1 >nul
)

:: キロバイトの計算
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1KB), 2)"') do set "sizeKB=%%A"
:: メガバイトの計算
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1MB), 2)"') do set "sizeMB=%%A"
:: ギガバイトの計算
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1GB), 2)"') do set "sizeGB=%%A"

:: 結果を表示
:: ファイルサイズ（バイト単位）を表示
echo.
echo 計算結果を表示
echo バイト（B）: %fileSize%
:: ファイルサイズ（キロバイト単位）を表示
echo キロバイト（KB）: %sizeKB%
:: ファイルサイズ（メガバイト単位）を表示
echo メガバイト（MB）: %sizeMB%
:: ファイルサイズ（ギガバイト単位）を表示
echo ギガバイト（GB）: %sizeGB%

:: エンターキーを待機
echo.
:: ユーザーが何かキーを押すまで待機
echo 何かキーを押すと終了します...
pause >nul

endlocal
