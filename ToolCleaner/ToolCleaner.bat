@echo off
title Cleaner CMD -VER 1.0.0
cls
setlocal enabledelayedexpansion :: fa in modo che il programma non si spenga durante l inserimento di inputs.



:MENU
color 3
echo =============================================
echo =		CLEANER TOOL                =
echo =============================================
echo.
echo =============================================
echo = 1. Svuota cache                           =
echo = 2. Ripara file corrotti                   =
echo = 3. Scansione virus                        =
echo = 4. Esci                                   =
echo =============================================
set /p scelta=Scegli cosa fare: 
cls

if "!scelta!" == "1" (
	cls
	echo =============================================
	
	echo Pulizia File TEMP in corso...
	:: Pulisci la cartella TEMP utente
    del /s /q /f "%temp%\*.*" 2>nul
    for /d %%p in ("%temp%\*.*") do rd /s /q "%%p" 2>nul
    echo =============================================
    :: Pulisci la cartella TEMP di Windows
    del /s /q /f "C:\Windows\Temp\*.*" 2>nul
    for /d %%p in ("C:\Windows\Temp\*.*") do rd /s /q "%%p" 2>nul
	pause
    cls
	color 2
	echo.
	echo =============================================
    echo Pulizia completata con successo 
	echo =============================================
	pause
	cls
	goto MENU
) else if "!scelta!" == "2" (
	cls
	echo =============================================
	echo Avvio della scansione e riparazione file di sistema...
    echo Questa operazione potrebbe richiedere qualche minuto. Non chiudere la finestra.
    echo.
    
	DISM.exe /Online /Cleanup-image /Restorehealth

    sfc/ scannow :: esegue uno scan per file corrotti
    pause
    echo.
	cls
	color 2
	echo.
	echo =============================================
    echo Controllo completato  
	echo =============================================
	pause
	cls
	goto MENU
) else if "!scelta!" == "3" (
	cls
	echo =============================================
	echo =        Opzioni scansione virus            =
	echo =============================================
	echo.
	echo =============================================
	echo = 1. Scansione rapida                       =
	echo = 2. Scansione completa                     =
	echo = 3. Scansione personalizata                =
	echo = 4. Scansione offline                      =
	echo =============================================
	set /p SCV=Inserisci scelta scansione: 
	
	if "!SCV!" == "1" (
		cls
		echo =============================================
		echo Avvio della scansione virus rapida...
		echo Questa operazione potrebbe richiedere qualche minuto. Non chiudere la finestra.
		echo.
		
		"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
		pause
   
		echo.
		cls
		color 2
		echo.
		echo =============================================
		echo Scansione completata  
		echo =============================================
	) else if "!SCV!" == "2" (
		cls
		echo =============================================
		echo Avvio della scansione virus completa...
		echo Questa operazione potrebbe richiedere qualche minuto. Non chiudere la finestra.
		echo.
		
		"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2

		pause
   
		echo.
		cls
		color 2
		echo.
		echo =============================================
		echo Scansione completata  
		echo =============================================
	
	) else if "!SCV!" == "3" (
		cls
		echo =============================================
		set /p Path=Inserisci path cartella da controllare:
		
		cls
		echo =============================================
		echo Avvio della scansione virus personalizata...
		echo Questa operazione potrebbe richiedere qualche minuto. Non chiudere la finestra.
		echo.
		
		"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "%Path%"


		pause
   
		echo.
		cls
		color 2
		echo.
		echo =============================================
		echo Scansione completata  
		echo =============================================
	) else if "!SCV!" == "4" (
		cls
		echo =============================================
		echo Avvio della scansione virus offline...
		echo Questa operazione potrebbe richiedere qualche minuto. Non chiudere la finestra.
		echo.
		
		"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType OfflineScan


		pause
   
		echo.
		cls
		color 2
		echo.
		echo =============================================
		echo Scansione completata  
		echo =============================================
	) else (
	
	cls
	color C
	echo =============================================
	echo scelta non trovata riprovare.
	echo =============================================
	pause
	cls
	goto MENU
	)
	
	pause
	cls
	goto MENU
) else if "!scelta!" == "4" (
	cls
	echo =============================================
	echo Chiusura programma.
	echo =============================================
	pause
	exit
) else (
	cls
	color C
	echo =============================================
	echo scelta non trovata riprovare.
	echo =============================================
	pause
	cls
	goto MENU
)



pause