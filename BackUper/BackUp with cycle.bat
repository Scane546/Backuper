@echo off

	setlocal EnableExtensions EnableDelayedExpansion

	if not "%~1"=="hidden" (
	start /min "" cmd /c ""%~f0" hidden"
	exit /b
	)

rem Куда сохранять бэкап/Where to save backup
	set "BACKUP_PATH=C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\BackUp\BackUps"

rem Что сохранять/What to save
	set "SOURCE_FOLDER=C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\Navezgane\Scane Faktin"

rem Путь к вин рару (я его кинул в комплект)/The way to the vintage (I threw it in the kit)
	set "WINRAR=C:\Program Files\WinRAR\WinRAR.exe"

rem Здесь нужно  указать вместо 7DaysToDie.exe название игры в диспетчере задач в двух местах после строки :loop/Here you need to specify instead 7DaysToDie.exe The name of the game in the task manager is in two places after the line :loop
	:loop
	tasklist /FI "IMAGENAME eq 7DaysToDie.exe" 2>NUL | find /I "7DaysToDie.exe" >NUL
	if not errorlevel 1 (
	if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

	set "archive_name="
	for /l %%r in (1,1,3) do (
	if not defined archive_name for /f %%i in ('
	powershell -NoProfile -Command "(Get-Date).ToString(\"MM_HH-mm-ss\")"
	') do set "archive_name=%%i"
	if not defined archive_name timeout /t 1 /nobreak >nul
	)
	if not defined archive_name set "archive_name=fallback_!RANDOM!"

rem Создаем архив в фоне с сжатием (От m5 до m0, где m0 почти не сжимется а m5 сжимет максимально возможно)/Creating an archive in a compressed background (From m5 to m0, where m0 is almost uncompressed and m5 is compressed as much as possible)
	"%WINRAR%" a -r -ep1 -m5 -ibck -idc -y "%BACKUP_PATH%\!archive_name!.rar" "%SOURCE_FOLDER%\*" >nul 2>&1
	)
rem раз в сколько секунд создается бэкап(число 120 меняй на свое)/every how many seconds a backup is created (change the number 120 to your own)
	timeout /t 600 /nobreak >nul
	goto loop

rem 		----------------------ТИТРЫ--------------------
rem 		----------В создании принимали участиЕ--------
rem		 ---------------Deep Seek - кодер №1-----------
rem		 -----------------Cursor - кодер №2-------------
rem		-------------------------и-----------------------
rem		 ----------------------ДимоН--------------------
rem		 ----------------------Он жЕ--------------------
rem		 ----------------------ScanE--------------------
rem		----------------------Он жЕ---------------------
rem		 ---------------Писатель комментоВ-------------
rem 		----------------------Он жЕ---------------------
rem 		---Человек который обожает помогать людяМ---
rem 		-------№1 и №2 всегда к вашим усугаМ---------
rem 		--А вот Димон наверное опять где-то валяетсЯ--
rem		-И забил большой и длинный ***на свою работУ-

rem		 ----------------------------- TITLES -----------------------------
rem 		---------- The following people participated in the creation:----------
rem		 ------------------------ Deep Seek - coder №1 -------------------
rem 		------------------------ Cursor - The coder №2---------------------
rem 		-------------------------------- and-------------------------------
rem		 ------------------------------ Dimon------------------------------
rem 		------------------------------- He's--------------------------------
rem 		------------------------------ ScanE-------------------------------
rem 		------------------------------- He's--------------------------------
rem 		------------------------ Writer of Comments------------------------
rem 		--------------------------- He's The same--------------------------
rem 		--------------------A man who loves helping people-----------------
rem 		----------------No.1 and No. 2 are always at your service-----------
rem 		-----------But Dimon is probably lying around somewhere again-------
rem 		----------------And scored a big and long ***To His job-------------