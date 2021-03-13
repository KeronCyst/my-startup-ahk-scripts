#SingleInstance, Force
#NoTrayIcon

^Space::WinSet, AlwaysOnTop, Toggle, A
;-------------------------------------------------------------------------------
^#p::Run, % A_ComSpec " /K cd /d D:\ && Powershell"
^+#p::Run, % "*Runas " A_ComSpec " /K cd /d D:\ && Powershell"
^#c::Run, % A_ComSpec " /K cd /d D:\"
^+#c::Run, % "*Runas " A_ComSpec " /K cd /d D:\"
;-------------------------------------------------------------------------------
^+#z::Run Explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C} ; all tasks
^+#Left::Send {Media_Prev}
^+#Right::Send {Media_Next}
^+#Space::Send {Media_Play_Pause}
^+#Enter::Send {Media_Stop}
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
    return
;-------------------------------------------------------------------------------
~+;::
    hits := KeyHits()
    If (hits = 2)
    {
        KeyWait, Space, T0.3
        If Not ErrorLevel And (A_PriorKey = "Space")
            SendInput, {BS 3}{asc 58}{asc 58}
        ;SendInput, {Shift}
    }
    return
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
    Return
