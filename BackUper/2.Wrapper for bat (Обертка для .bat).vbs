' Скрипт запуска игры и бэкапов (launch.vbs)
	Option Explicit

' Создание лога ошибок
	Dim shell, fso, logPath
	Set shell = CreateObject("WScript.Shell")
	Set fso   = CreateObject("Scripting.FileSystemObject")

' путь к логам ошибок. Указывай путь к папке в которой лежит данная "прога" шепотом - убожество на скиптах к которому я по сути написал только комменты ибо сам нихрена не умею и писал через нейронку но кст задолбался ибо они были тогда тупые 2025г.
	logPath = "C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\BackUp\launch_log.txt"

	Sub Log(msg)
  	Dim f: Set f = fso.OpenTextFile(logPath, 8, True)
  	f.WriteLine Now() & " - " & msg
 	 f.Close
	End Sub

	On Error Resume Next

' Путь к папке в которой лежит игра(именно папка где лежит .exe его самого не надо указывать)
	shell.CurrentDirectory = "H:\Games\7 Days To Die"
	If Err.Number <> 0 Then Log "Ошибка CurrentDirectory: " & Err.Description: WScript.Quit
	Err.Clear

' Путь к игре и ее запуск нужно (обязательно указывать с расширением .exe)
	shell.Run """H:\Games\7 Days To Die\7DaysToDie.exe""", 1, False
	If Err.Number <> 0 Then Log "Ошибка запуска игры: " & Err.Description: WScript.Quit
	Err.Clear
	Log "Игра запущена"

' Ожидание 40 секунд (если не надо удали строчку под комментом b сам коммент но не советую (время в мили секундах 1с - 		1000мс(хочешь изменить меняй но не в 0)))
	WScript.Sleep 40000 

' Путь к бат-файлу единоразового резервного копирования - BackUp everyone.bat и его зауск
	shell.Run """C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\BackUp\BackUp everyone.bat""", 0, False
	If Err.Number <> 0 Then Log "Ошибка BackUp everyone.bat: " & Err.Description: WScript.Quit
	Err.Clear
	Log "BackUp everyone.bat запущен"

' Ожидание 15 секунд (если не надо удали строчку под комментом b сам коммент но не советую (время в мили секундах 1с - 1000мс(хочешь изменить меняй но не в 0)))
	WScript.Sleep 15000  

' Путь к бат-файлу цикличного резервного копирования - BackUp with cycle.bat и его зауск
	shell.Run """C:\Users\Scane\AppData\Roaming\7DaysToDie\Saves\BackUp\BackUp with cycle.bat""", 0, False

	If Err.Number <> 0 Then Log "Ошибка BackUp with cycle.bat: " & Err.Description: WScript.Quit
	Err.Clear
	Log "BackUp with cycle.bat запущен"

	Log "Скрипт завершён"
	Set shell = Nothing
	Set fso   = Nothing