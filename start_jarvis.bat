@echo off
setlocal enabledelayedexpansion

echo Starting JARVIS Auto-Launcher...
echo.

:: Function to find JARVIS folder
:find_jarvis
set "JARVIS_PATH="

:: Check common locations
set "SEARCH_PATHS=C:\Users\%USERNAME%\Desktop C:\Users\%USERNAME%\Documents C:\Users\%USERNAME%\Documents\Code* C:\ D:\ E:\"

for %%P in (%SEARCH_PATHS%) do (
    if exist "%%P" (
        for /f "delims=" %%F in ('dir /b /s /ad "%%P" 2^>nul ^| findstr /i "J.A.R.V.I.S"') do (
            if exist "%%F\JARVIS.py" (
                set "JARVIS_PATH=%%F"
                goto :found_jarvis
            )
        )
    )
)

:: If not found in common locations, search entire drives (slower)
echo Searching for JARVIS installation...
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\" (
        for /f "delims=" %%F in ('dir /b /s /ad "%%D:\J.A.R.V.I.S" 2^>nul') do (
            if exist "%%F\JARVIS.py" (
                set "JARVIS_PATH=%%F"
                goto :found_jarvis
            )
        )
    )
)

echo ERROR: JARVIS installation not found!
echo Please ensure J.A.R.V.I.S folder exists and contains JARVIS.py
pause
exit /b 1

:found_jarvis
echo Found JARVIS at: %JARVIS_PATH%
echo.

:: Change to JARVIS directory
cd /d "%JARVIS_PATH%"

:: Check if virtual environment exists
if not exist "venv\Scripts\activate.bat" (
    echo ERROR: Virtual environment not found at %JARVIS_PATH%\venv
    echo Please ensure the virtual environment is properly set up
    pause
    exit /b 1
)

:: Activate virtual environment
echo Activating virtual environment...
call "venv\Scripts\activate.bat"

:: Check if JARVIS.py exists
if not exist "JARVIS.py" (
    echo ERROR: JARVIS.py not found in %JARVIS_PATH%
    pause
    exit /b 1
)

:: Install pyautogui if not already installed (for auto-clicking)
echo Checking dependencies...
python -c "import pyautogui" 2>nul || (
    echo Installing pyautogui for auto-clicking...
    pip install pyautogui
)

:: Start JARVIS with auto-click
echo Starting JARVIS...
echo.
start /min python auto_click_jarvis.py
python JARVIS.py

pause
