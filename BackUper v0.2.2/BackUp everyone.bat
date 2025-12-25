@echo off

	setlocal EnableExtensions EnableDelayedExpansion

rem Куда сохранять бэкап/Where to save backup
	set "BACKUP_PATH=C:\Users\Scane\Desktop\BackUper v0.2.1\Backups"

rem Имя игры или приложения/Name of the game or application
	set "NAME=7DtoD"

rem Что сохранять/What to save
	set "SOURCE_FOLDER=C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\Navezgane\Scane Faktin"

rem Путь к вин рару (я его кинул в комплект)/Path to WinRAR (I put it in the package)
	set "WINRAR=C:\Program Files\WinRAR\WinRAR.exe"

rem Создаем папку для бэкапов если её нет/Create a backup folder if it doesn't exist
	if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

rem Создаем имя архива с датой и временем (месяц-день_час;минута;секунда) / Create archive name with date and time (month-day_hour;minute;second)
	set "ts="
	for /l %%r in (1,1,3) do (
		if not defined ts for /f %%i in ('
			powershell -NoProfile -Command "$d=Get-Date; $d.ToString(\"yyyy-MM-dd\")+\"_\"+$d.ToString(\"HH\")+\";\"+$d.ToString(\"mm\")+\";\"+$d.ToString(\"ss\")"
		') do set "ts=%%i"
		if not defined ts timeout /t 1 /nobreak >nul
	)
	if not defined ts set "ts=fallback_!RANDOM!"
	set "archive_name=S-%NAME%_!ts!"

rem Создаем архив в фоне с сжатием (От m5 до m0, где m0 почти не сжимется а m5 сжимет максимально возможно)/Create an archive in the background with compression (from m5 to m0, where m0 is almost uncompressed and m5 is compressed as much as possible)
	start "" "%WINRAR%" a -r -ep1 -m5 -ibck -idc -y "%BACKUP_PATH%\!archive_name!.rar" "%SOURCE_FOLDER%\*"

rem a - Добавление в архив (Add)/Add to Archive (Add)
rem Это основная команда для создания нового архива. Она указывает WinRAR, что нужно добавить файлы в архив./This is the main command for creating a new archive. It tells WinRAR to add files to the archive.

rem -r - Рекурсивное обход (Recursive)/Recursive traversal
rem Обрабатывает все подпапки и файлы внутри указанной папки/Processes all subfolders and files inside the specified folder
rem Без этого параметра WinRAR добавил бы только файлы из корня %SOURCE_FOLDER%, но не из вложенных папок/Without this parameter, WinRAR would have added only files from the %SOURCE_FOLDER% root, but not from subfolders

rem -ep1 - Исключение базового пути (Exclude Path)/Exclude the base path (Exclude Path)
rem Этот параметр управляет тем, как пути сохраняются в архиве:/This parameter controls how paths are saved in the archive:
rem ep1 означает, что из архивных путей будет исключена базовая часть (F:\Games\Subnautica\world\)/ep1 means that the basic part will be excluded from the archive paths (F:\Games\Subnautica\world\)
rem Пример: Файл F:\Games\Subnautica\world\savegame\file1.dat в архиве будет сохранен как savegame\file1.dat/Example: File F:\Games\Subnautica\world\savegame\file1.dat in the archive will be saved as savegame\file1.dat
rem Альтернативы: -ep (полное исключение всех путей) или без параметра (сохраняются полные пути)/Alternatives: -ep (complete exclusion of all paths) or without parameter (full paths are preserved)

rem -m5 - Уровень сжатия (Method)/Compression Level (Method)
rem Задает степень сжатия файлов:/Sets the compression ratio of files:
rem m0 - Без сжатия (просто упаковка)/m0 - Without compression (just packaging)
rem m1 - Самый быстрый (минимальное сжатие)/m1 - Fastest (minimal compression)
rem m2 - Быстрый/m2 - Fast
rem m3 - Обычный (стандартный)/m3 - Normal (Standard)
rem m4 - Хороший (хорошее сжатие)/m4 - Good (good compression)
rem m5 - Максимальный (лучшее сжатие, но медленнее)/m5 - Maximum (better compression, but slower)
rem m6 - Максимальный (более агрессивный алгоритм)/m6 - Maximum (more aggressive algorithm)

rem -ibck - Фоновый режим (In Background)/Background mode (In Background)
rem Запускает WinRAR в фоновом режиме (сворачивает в трей)/Runs WinRAR in the background (collapses into the tray)
rem Позволяет продолжать использовать компьютер, пока создается архив/Allows you to continue using your computer while the archive is being created
rem Очень полезно для автоматических бэкапов, чтобы не мешать работе/Very useful for automatic backups so as not to interfere with work


