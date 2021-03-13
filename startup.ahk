#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Loop, Files, % A_ScripDir . "startup/**.ahk", DFR
{
    SplitPath, A_LoopFileLongPath, , ScriptDir
    SplitPath, ScriptDir, , ScriptDirDir
    If Not (StrReplace(ScriptDir, ScriptDirDir) == "\lib")
        Run % A_LoopFileLongPath, % ScriptDir
}
