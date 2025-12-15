' Скрипт запуска игры и бэкапов/Game launch and backup script
	Option Explicit

' Создание лога/Creating a log
	Dim shell, fso, logPath
	Set shell = CreateObject("WScript.Shell")
	Set fso   = CreateObject("Scripting.FileSystemObject")

' Путь к логам . Указывай путь к папке в которой лежит данная "прога" шепотом - убожество на скиптах к которому я по сути написал только комменты ибо сам нихрена не умею и писал через нейронку но кст задолбался ибо они были тогда тупые 2025г./The path to the logs. Indicate the path to the folder in which this "program" lies in a whisper - the squalor on the skips to which I essentially wrote only comments because I don't know how to do shit myself and wrote through a neural network, but the kst got fucked up because they were stupid then in 2025.
	logPath = "C:\Users\Scane\Desktop\BackUper v2.0\launch_log.txt"

	Sub Log(msg)
  	Dim f: Set f = fso.OpenTextFile(logPath, 8, True)
  	f.WriteLine Now() & " - " & msg
 	 f.Close
	End Sub

	On Error Resume Next

' Путь к папке в которой лежит игра(именно папка где лежит .exe его самого не надо указывать)/The path to the folder where the game is located (exactly the folder where it is located .the exe itself does not need to be specified)
	shell.CurrentDirectory = "H:\Games\7 Days To Die"
	If Err.Number <> 0 Then Log "Ошибка CurrentDirectory: " & Err.Description: WScript.Quit
	Err.Clear

' Путь к игре и ее запуск нужно (обязательно указывать с расширением .exe)/The path to the game and its launch must be specified with the .exe extension.
	shell.Run """H:\Games\7 Days To Die\7DaysToDie.exe""", 1, False
	If Err.Number <> 0 Then Log "Ошибка запуска игры: " & Err.Description: WScript.Quit
	Err.Clear
	Log "Игра запущена"

' Ожидание 40 секунд (если не надо удали строчку под комментом b сам коммент но не советую (время в мили секундах 1с - 		1000мс(хочешь изменить меняй но не в 0)))/Waiting 40 seconds (if not necessary, delete the line under comment b, the comment itself, but I do not recommend it (time in miles seconds 1s - 1000ms (if you want to change it, change it but not at 0)))
	WScript.Sleep 40000 

' Путь к бат-файлу единоразового резервного копирования - BackUp everyone.bat и его зауск/The path to the one-time backup bat file is BackUp everyone.bat and its launch
	shell.Run """C:\Users\Scane\Desktop\BackUper v2.0\BackUp everyone.bat""", 0, False
	If Err.Number <> 0 Then Log "Ошибка BackUp everyone.bat: " & Err.Description: WScript.Quit
	Err.Clear
	Log "BackUp everyone.bat запущен"

' Ожидание 15 секунд (если не надо удали строчку под комментом b сам коммент но не советую (время в мили секундах 1с - 1000мс(хочешь изменить меняй но не в 0)))/Waiting 15 seconds (if not necessary, delete the line under comment b, the comment itself, but I do not recommend it (time in miles seconds 1s - 1000ms (if you want to change, change it, but not at 0)))
	WScript.Sleep 15000  

' Путь к бат-файлу цикличного резервного копирования - BackUp with cycle.bat и его зауск/The path to the cyclic backup bat file is BackUp with cycle.bat and its launch
	shell.Run """C:\Users\Scane\Desktop\BackUper v2.0\BackUp with cycle.bat""", 0, False

	If Err.Number <> 0 Then Log "Ошибка BackUp with cycle.bat: " & Err.Description: WScript.Quit
	Err.Clear
	Log "BackUp with cycle.bat запущен"

	Log "Скрипт завершён"
	Set shell = Nothing

	Set fso   = Nothing
