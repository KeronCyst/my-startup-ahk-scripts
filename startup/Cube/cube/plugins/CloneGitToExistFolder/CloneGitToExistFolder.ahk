#Include, .\cube\settings.ahk

ListOfExplorer := {}
WinGet, IDS, List, ahk_class CabinetWClass
If (IDS == 0)
    Return
Loop % IDS
{
    loop_id := IDS%A_Index%
    WinGetTitle, title, % "ahk_id " loop_id
    If title
    {
        ListOfExplorer[title] := loop_id
        Menu, % A_ScriptName, Add, % title, Label_Clone
        Menu, % A_ScriptName, Icon, % title, imageres.dll,4
    }
}
Menu, % A_ScriptName, Show
Return

Label_Clone:
    WinActivate % "ahk_id " ListOfExplorer[A_ThisMenuItem]
    ControlGetText, Folder, ToolbarWindow323, % "ahk_id " ListOfExplorer[A_ThisMenuItem]
    RegExMatch(Folder, "(\w:.*$)", Folder)
    Run % "cmd /K cd /d """ Folder """ && git clone " Clipboard
Return
