@echo off

rem Чуда сохранять бэкап/Where to save backup
	set BACKUP_PATH=C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\BackUp\BackUps

rem Что сохранять/What to save
	set SOURCE_FOLDER=C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\Navezgane\Scane Faktin

rem Путь к вин рару (я его кинул в комплект)/Path to the wine rack (I put it in the package)
	set WINRAR="C:\Program Files\WinRAR\WinRAR.exe"

rem Создаем папку для бэкапов если её нет/Create a backup folder if it doesn't exist
	if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

rem Создаем имя архива с месяцем, числом и временем (месяц-день_час-минута-секунда(возможна ошибка из за одинаковых имен нажимешь ок и идешь чистить бэкапы (откуда у тебя столько места? ммм?) но пропользоваться без чистки бэкапов нужно не 1 год или вы должны быть везунчиком))/Create an archive name with the month, date, and time (month-day_hour-minute-second (you may get an error because of the same names, click OK, and go clean your backups (where did you get so much space? mmm?) but you need to use it for more than 1 year without cleaning your backups, or you have to be lucky))
	for /f "tokens=1-3 delims=." %%a in ('wmic os get LocalDateTime ^| find "."') do (
	    set datetime=%%a
	)
	set archive_name=%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%

rem Создаем архив в фоне с сжатием (От m5 до m0, где m0 почти не сжимется а m5 сжимет максимально возможно)/Create an archive in the background with compression (from m5 to m0, where m0 is almost uncompressed and m5 is compressed as much as possible)
	start /B "" %WINRAR% a -r -ep1 -m5 -ibck "%BACKUP_PATH%\%archive_name%.rar" "%SOURCE_FOLDER%\*"

rem a - Добавление в архив (Add)
rem Это основная команда для создания нового архива. Она указывает WinRAR, что нужно добавить файлы в архив.

rem -r - Рекурсивное обход (Recursive)
rem Обрабатывает все подпапки и файлы внутри указанной папки
rem Без этого параметра WinRAR добавил бы только файлы из корня %SOURCE_FOLDER%, но не из вложенных папок

rem -ep1 - Исключение базового пути (Exclude Path)
rem Этот параметр управляет тем, как пути сохраняются в архиве:
rem ep1 означает, что из архивных путей будет исключена базовая часть (F:\Games\Subnautica\world\)
rem Пример: Файл F:\Games\Subnautica\world\savegame\file1.dat в архиве будет сохранен как savegame\file1.dat
rem Альтернативы: -ep (полное исключение всех путей) или без параметра (сохраняются полные пути)

rem -m5 - Уровень сжатия (Method)
rem Задает степень сжатия файлов:
rem m0 - Без сжатия (просто упаковка)
rem m1 - Самый быстрый (минимальное сжатие)
rem m2 - Быстрый
rem m3 - Обычный (стандартный)
rem m4 - Хороший (хорошее сжатие)
rem m5 - Максимальный (лучшее сжатие, но медленнее)
rem m6 - Максимальный (более агрессивный алгоритм)-m5 - Уровень сжатия (Method)

rem -ibck - Фоновый режим (In Background)
rem Запускает WinRAR в фоновом режиме (сворачивает в трей)
rem Позволяет продолжать использовать компьютер, пока создается архив
rem Очень полезно для автоматических бэкапов, чтобы не мешать работе


rem a - Add to Archive (Add)
rem is the main command for creating a new archive. It tells WinRAR to add files to the archive.

rem -r - Recursive traversal
rem Processes all subfolders and files inside the specified
rem folder Without this parameter, WinRAR would have added only files from the %SOURCE_FOLDER% root, but not from subfolders

rem -ep1 - Exclude the base path (Exclude Path)
rem This parameter controls how paths are saved in the archive:
rem ep1 means that the basic part will be excluded from the archive paths (F:\Games\Subnautica\world \)
rem Example: File F:\Games\Subnautica\world\savegame\file1.dat the archive will be saved as savegame\file1.dat
rem.: -ep (complete exclusion of all paths) or without parameter (full paths are preserved)

rem -m5 - Compression Level (Method)
rem Sets the compression ratio of files:
rem m0 - Without compression (just packaging)
rem m1 - Fastest (minimal compression)
rem m2 - Fast
rem m3 - Normal (Standard)
rem m4 - Good (good compression)
rem m5 - Maximum (better compression, but slower)
rem m6 - Maximum (more aggressive algorithm)-m5 - Compression level (Method)

rem -ibck - Background mode (In Background)
rem Runs WinRAR in the background (collapses into the tray)
rem Allows you to continue using your computer while the archive is being created rem is very useful for automatic backups so as not to interfere with work