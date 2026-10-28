@echo off
chcp 65001 >nul
title Bilirkisi Analiz Sistemi - Onarim Araci
echo ============================================
echo  Bilirkisi Analiz Sistemi - Onarim Araci
echo ============================================
echo.
echo Bu arac, otomatik guncellemenin calismadigi durumlar icin
echo programi en guncel surume ELLE tasir. Lutfen bekleyin...
echo.

taskkill /F /IM BilirkisiAnalizSistemi.exe >nul 2>&1
timeout /t 2 /nobreak >nul

set HEDEF=
if exist "%USERPROFILE%\Desktop\BilirkisiAnalizSistemi.exe" set HEDEF=%USERPROFILE%\Desktop\BilirkisiAnalizSistemi.exe
if "%HEDEF%"=="" if exist "%~dp0BilirkisiAnalizSistemi.exe" set HEDEF=%~dp0BilirkisiAnalizSistemi.exe
if "%HEDEF%"=="" if exist "%USERPROFILE%\Downloads\BilirkisiAnalizSistemi.exe" set HEDEF=%USERPROFILE%\Downloads\BilirkisiAnalizSistemi.exe
if "%HEDEF%"=="" set HEDEF=%USERPROFILE%\Desktop\BilirkisiAnalizSistemi.exe

echo Program konumu: %HEDEF%
echo En guncel surum indiriliyor, lutfen bekleyin (biraz surebilir)...
set GECICI=%TEMP%\hts_onar_yeni.exe
del "%GECICI%" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://github.com/baran43777-creator/bilirkisi-indirme/releases/latest/download/BilirkisiAnalizSistemi-Windows.exe' -OutFile '%GECICI%' -UseBasicParsing } catch { exit 1 }"

if not exist "%GECICI%" (
  echo.
  echo HATA: Indirme basarisiz oldu. Internet baglantinizi kontrol edip
  echo bu dosyayi tekrar calistirin. Sorun devam ederse destek ile iletisime gecin.
  pause
  exit /b 1
)

copy /y "%GECICI%" "%HEDEF%" >nul 2>&1
if errorlevel 1 (
  echo.
  echo HATA: Dosya kopyalanamadi. "%HEDEF%" konumuna yazma izniniz
  echo olmayabilir. Lutfen bu araci "Yonetici olarak calistir" ile tekrar deneyin.
  pause
  exit /b 1
)
del "%GECICI%" >nul 2>&1

echo.
echo Tamamlandi! Program yeniden baslatiliyor...
start "" "%HEDEF%"
timeout /t 3 /nobreak >nul
exit /b 0
