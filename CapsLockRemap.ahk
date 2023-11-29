#Requires AutoHotkey v2.0
#UseHook

; We don't send any letters and this prevents Send "{CapsLock}" from toggling capslock when true
SetStoreCapsLockMode False


global iniFilePath := A_ScriptDir . "/capsLockMap.ini"

if not (FileExist(iniFilePath)) {
    IniWrite 0, iniFilePath, "state", "CapsOption"
}

global CapsOption := IniRead(iniFilePath, "state", "CapsOption")

NextOption()
{
    global CapsOption
    CapsOption += 1
    if (CapsOption > 3) {
        CapsOption := 1
    }

    if (CapsOption == 1) {
        MsgBox "CapsLock bound to Esc"
    } else if (CapsOption == 2) {
        MsgBox "CapsLock bound to Ctrl"
    } else if (CapsOption == 3) {
        MsgBox "CapsLock bound to CapsLock"
    }

    IniWrite CapsOption, iniFilePath, "state", "CapsOption"
}

Esc & CapsLock::NextOption()
Esc::Esc

*CapsLock::
{
    global CapsOption
    if (CapsOption == 1) {
        Send "{Esc down}"
        KeyWait "CapsLock"
        Send "{Esc up}"
    } else if (CapsOption == 2) {
        Send "{Ctrl down}"
        KeyWait "CapsLock"
        Send "{Ctrl up}"
    } else if (CapsOption == 3) {
        Send "{CapsLock}"
    }
}

CapsMenuSelect(Name, Item, *) {
    global CapsOption
    CapsMenu.Uncheck(CapsOption . "&")
    CapsOption := Item
    CapsMenu.Check(Item . "&")
}

CapsMenu := Menu()
CapsMenu.Add("Esc", CapsMenuSelect, "+Radio")
CapsMenu.Add("Ctrl", CapsMenuSelect, "+Radio")
CapsMenu.Add("Caps", CapsMenuSelect, "+Radio")
CapsMenu.Check(CapsOption . "&")


A_TrayMenu.Insert("2&", "Caps Remap", CapsMenu)
TraySetIcon "capslock_dark.png"