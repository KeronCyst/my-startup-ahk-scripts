#SingleInstance, Force
#NoTrayIcon

DetectHiddenWindows, On

#If WinExist("ahk_exe snipaste.exe")
    ^!a::Send, {PrintScreen}
#IF
