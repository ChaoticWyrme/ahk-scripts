#Requires AutoHotkey v2.0

Running := False

Controls := Gui()
StatusText := Controls.Add("Text",, "Not Running")
Button := Controls.AddButton("Default w80", "Start")
Button.OnEvent("Click", ToggleState)
Controls.OnEvent("Close", OnClose)

OnClose(*) {
    ExitApp(0)
}
Controls.Show()

SendMode "Event"

Loop {
    if (Running) {
        MouseMove(500, 500, 50, "R")
        Sleep 5000
        MouseMove(-500, -500, 50, "R")
    }
    Sleep 5000
}

ToggleState(*) {
    global Running
    global Button
    global StatusText
    Running := !Running

    if (Running) {
        Button.Text := "Stop"
        StatusText.Text := "Running"
    } else {
        Button.Text := "Start"
        StatusText.Text := "Not Running"
    }
}

F5::ToggleState()