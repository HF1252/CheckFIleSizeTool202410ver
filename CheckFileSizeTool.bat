@echo off
setlocal

:: PowerShell�Ńt�@�C���I���_�C�A���O��\��
set "filePath="
for /f "delims=" %%I in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.OpenFileDialog; $dialog.Filter = 'All Files (*.*)|*.*'; if ($dialog.ShowDialog() -eq 'OK') { $dialog.FileName }"') do set "filePath=%%I"

:: �t�@�C���̑��݃`�F�b�N
if not exist "%filePath%" (
    echo �G���[�F�Q�ƃt�@�C�����݂���Ȃ��B
    pause
    exit /b
)

:: PowerShell�Ńt�@�C���T�C�Y���擾
for /f "delims=" %%A in ('powershell -command "(Get-Item '%filePath%').length"') do set "fileSize=%%A"

:: �T�C�Y���e�P�ʂɕϊ�
echo �v�Z��... ���΂炭���҂����������B

:: �J�E���g�_�E���̊J�n
for /L %%i in (3,-1,1) do (
    echo %%i
    timeout /t 1 >nul
)

:: �L���o�C�g�̌v�Z
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1KB), 2)"') do set "sizeKB=%%A"
:: ���K�o�C�g�̌v�Z
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1MB), 2)"') do set "sizeMB=%%A"
:: �M�K�o�C�g�̌v�Z
for /f "delims=" %%A in ('powershell -command "[math]::round((%fileSize% / 1GB), 2)"') do set "sizeGB=%%A"

:: ���ʂ�\��
:: �t�@�C���T�C�Y�i�o�C�g�P�ʁj��\��
echo.
echo �v�Z���ʂ�\��
echo �o�C�g�iB�j: %fileSize%
:: �t�@�C���T�C�Y�i�L���o�C�g�P�ʁj��\��
echo �L���o�C�g�iKB�j: %sizeKB%
:: �t�@�C���T�C�Y�i���K�o�C�g�P�ʁj��\��
echo ���K�o�C�g�iMB�j: %sizeMB%
:: �t�@�C���T�C�Y�i�M�K�o�C�g�P�ʁj��\��
echo �M�K�o�C�g�iGB�j: %sizeGB%

:: �G���^�[�L�[��ҋ@
echo.
:: ���[�U�[�������L�[�������܂őҋ@
echo �����L�[�������ƏI�����܂�...
pause >nul

endlocal
