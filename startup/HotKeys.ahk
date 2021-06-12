#SingleInstance, Force
#NoTrayIcon

;-------------------------------------------------------------------------------
^Space::WinSet, AlwaysOnTop, Toggle, A
;-------------------------------------------------------------------------------
^#c::Run, % A_ComSpec " /K cd /d " CurrentFolder()
^+#c::Run, % "*Runas " A_ComSpec " /K cd /d " CurrentFolder()
^#p::Run, % A_ComSpec " /K cd /d " CurrentFolder() " && Powershell"
^+#p::Run, % "*Runas " A_ComSpec " /K cd /d " CurrentFolder() " && Powershell"
;-------------------------------------------------------------------------------
^+#z::Run Explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C} ; all tasks
;-------------------------------------------------------------------------------
; ^#Left::Send, {Media_Prev} ; conflict with switching virtual desktop
; ^#Right::Send, {Media_Next} ; conflict with switching virtual desktop
;-------------------------------------------------------------------------------
^#!Up::Send, {Volume_Up}
^#!Down::Send, {Volume_Down}
^#!Left::Send, {Media_Prev}
^#!Right::Send, {Media_Next}
^#!Space::Send, {Media_Play_Pause}
^#!Enter::Send, {Media_Stop}
;-------------------------------------------------------------------------------
^+#Up::system_SetScreenBrightness(5)
^+#Down::system_SetScreenBrightness(-5)
;===============================================================================
CurrentFolder(hWnd=0) {
    If hWnd||(hWnd:=WinExist("ahk_class CabinetWClass"))||(hWnd:=WinExist("ahk_class ExploreWClass"))
    {
        shell := ComObjCreate("Shell.Application")
        Loop, % shell.Windows.Count
            If ( (win := shell.Windows.Item(A_Index-1)).hWnd = hWnd )
            Break
        Return win.Document.Folder.Self.Path
    }
    Return "D:\"
}
