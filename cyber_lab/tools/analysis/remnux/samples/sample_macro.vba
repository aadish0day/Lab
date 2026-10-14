Attribute VB_Name = "AutoExec"

Sub AutoOpen()
    ExecutePayload
End Sub

Sub Document_Open()
    ExecutePayload
End Sub

Sub ExecutePayload()
    Dim wsh As Object
    Dim cmdStr As String
    Dim b64Cmd As String

    ' Obfuscated command string simulation
    b64Cmd = "cG93ZXJzaGVsbC5leGUgLW5vcCAtZSAgZWNobyAnQ3liZXJMYWIgVGVzdCc="

    ' Shell execution and network download API calls flagged by olevba
    Set wsh = CreateObject("WScript.Shell")
    cmdStr = "cmd.exe /c powershell -Command Write-Host 'Simulation Run'"

    ' Suspicious API calls: URLDownloadToFile, Shell, Environ
    wsh.Run cmdStr, 0, False
End Sub