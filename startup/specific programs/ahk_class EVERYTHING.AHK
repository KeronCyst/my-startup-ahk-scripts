#SingleInstance, Force
#NoTrayIcon

EVERYTHING := "D:\SoftWare\Everything\Everything.exe"

#z::
    If WinExist("ahk_class EVERYTHING")
        WinActivate, ahk_class EVERYTHING
    Else
        Run % EVERYTHING
    Return

#If WinActive("ahk_class EVERYTHING")
    ^l::ControlFocus, Edit1, ahk_class EVERYTHING
    !Enter::
        ControlGetText, command, Edit1
        Run, % A_ComSpec " /K cd /d " A_Desktop " && cls && " command
        Return
#If
