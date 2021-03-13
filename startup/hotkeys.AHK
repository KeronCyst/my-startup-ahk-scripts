#SingleInstance, Force
#NoTrayIcon
#MaxHotkeysPerInterval, 1000

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
^#Up::Send, {Volume_Up}
^#Down::Send, {Volume_Down}
^#Left::Send, {Media_Prev}
^#Right::Send, {Media_Next}
^#Space::Send, {Media_Play_Pause}
^#Enter::Send, {Media_Stop}
;-------------------------------------------------------------------------------
^+#Up::system_SetScreenBrightness(5)
^+#Down::system_SetScreenBrightness(-5)
;-------------------------------------------------------------------------------
RWin::AppsKey
;-------------------------------------------------------------------------------
~;::
    hits := KeyHits()
    If (hits = 1)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 2}{asc 59}{Space}
    }
    Else If (hits = 2)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 3}{asc 59}{asc 59}
    }
Return
;-------------------------------------------------------------------------------
~+;::
    hits := KeyHits()
    If (hits = 1)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 2}{asc 58}{Space}
    }
    Else If (hits = 2)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 3}{asc 58}{asc 58}
    }
Return
;-------------------------------------------------------------------------------
~'::
    hits := KeyHits()
    If (hits = 2)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 3}{Asc 39}{Asc 39}
    }
    Else If (hits = 3)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 4}{Asc 34}{Asc 34}{Asc 34}{Enter}{Asc 34}{Asc 34}{Asc 34}
    }
Return
~+'::
    hits := KeyHits()
    If (hits = 2)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 3}{Asc 34}{Asc 34}
    }
    Else If (hits = 3)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 4}{Asc 34}{Asc 34}{Asc 34}{Enter}{Asc 34}{Asc 34}{Asc 34}
    }
Return
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
