@echo off
REM Script untuk memindahkan portfolio ke path tanpa Unicode
REM Run as Administrator!

setlocal enabledelayedexpansion

echo.
echo ============================================
echo Portfolio Project Migration Script
echo ============================================
echo.
echo This script will help move your project to a path without Unicode characters
echo Current location: C:\Users\ramsc\OneDrive\ドキュメント\latihan\portfolio-main
echo.

set /p target="Enter target path (e.g., C:\Projects\portfolio-main): "

if exist "%target%" (
    echo Error: Target directory already exists!
    exit /b 1
)

echo.
echo Creating target directory...
mkdir "%target%"

echo Copying files...
xcopy "." "%target%" /E /I /Y

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo Migration successful!
    echo.
    echo Next steps:
    echo 1. Navigate to: %target%
    echo 2. Run: npm install
    echo 3. Run: npm run build
    echo 4. Run: npm run dev
    echo.
    echo Then you can delete the old folder from OneDrive\ドキュメント
    echo ============================================
) else (
    echo Error occurred during copy!
    exit /b 1
)

pause
