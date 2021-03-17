#NoTrayIcon
#Persistent
#SingleInstance, force
; Changes how long the script keeps trying to access the clipboard when the first attempt fails.
#ClipboardTimeout 500
#KeyHistory 0
ListLines, Off
Process, Priority, , High
SetWorkingDir % A_ScriptDir

; set icon
Menu, Tray, UseErrorLevel
Menu, Tray, Icon, ClipboardMonitor.ico

CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
;-------------------------------------------------------------------------------
; will only show the top %CharacterCount% characters
Global CharacterCount := 300
Global TEXTS_dir := A_WorkingDir "\cache\texts\"
Global THUMBS_dir := A_WorkingDir "\cache\thumbs\"

;-------------------------------------------------------------------------------
; Background transparent mask Gui, GuiName:1
Gui 1:Destroy
Gui 1:+Owner -Caption +Disabled -DPIScale
Gui 1:Margin, 0, 0
Gui 1:Color, 000000
Gui 1:+LastFound
WinSet, Transparent, 70
;-------------------------------------------------------------------------------

OnClipboardChange("ClipChanged")
Return

ClipChanged(Type) {
    ; Contains one of the following values:
    ; 0 if the clipboard is now empty;
    ; 1 if it contains something that can be expressed as text (this includes files copied from an Explorer window);
    ; 2 if it contains something entirely non-text such as a picture.
    show(Type)
    If GetKeyState("c", "P")
    {
        KeyWait, c, T3 ; TODO: while key "c" is pressed, moving Gui:2 will bring a warning sound.
        Gosub, Label_init
    }
    Else
        SetTimer, Label_wait_to_init, -800 ; show a ToolTip for at least 800ms
}
show(Type) {
    If (Type = 0)
    {
        ToolTip % "Clipboard emptied!"
    }
    Else If (Type = 1)
    {
        ; when there are much more characters in Clipboard
        String := SubStr(Clipboard, 1, CharacterCount)
        ToolTip % StrLen(ClipBoard) " characters copied!`n" String
        If FileExist(TEXTS_dir)
            FileAppend % Clipboard, % TEXTS_dir . A_Now . ".txt"
    }
    Else If (Type = 2)
    {
        ; mostly picture, may other types(not sure)
        If FileExist(THUMBS_dir)
        {
            Gui 2:Destroy
            Gui 2:+AlwaysOnTop +Owner -Caption -DPIScale
            Gui 2:Margin, 0, 0
            Gui 2:Add, Picture, Center , % thumbGenerator()

            Gui 1:Show, H%A_ScreenHeight% W%A_ScreenWidth% X0 Y0 NoActivate
            MouseGetPos, X, Y
            Gui 2:Show, X%X% Y%Y%
        }
    }
    Else
    {
        ToolTip % "Unknown clipboard data type: " Type
    }
}
thumbGenerator() {
    Critical
    thumb := THUMBS_dir . A_Now . ".jpg"
    Gdip_CaptureClipboard(thumb, 90)
    Return thumb
}
Gdip_CaptureClipboard(file, quality) {
    PToken := Gdip_Startup()
    pBitmap := Gdip_CreateBitmapFromClipboard()
    Gdip_SaveBitmaptoFile(pBitmap, file, quality)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(PToken)
}
Move() {
    static WM_LBUTTONDOWN := 0x201
    static _______ := OnMessage(WM_LBUTTONDOWN, "Move")
    SendMessage, 0xA1, 2
}

Label_wait_to_init:
    loop
    {
        ; check system idle every 200ms, if keyboard or mouse acted in 100ms, break loop
        if (A_TimeIdle < 100)
            Break
        Sleep, 200
    }
    Gosub, Label_init
Return
Label_init:
    ToolTip
    Gui 1:Hide
    Gui 2:Destroy
Return
