#!/usr/bin/env python3
"""
Generate safe educational test samples for REMnux static analysis exercises.
These files simulate typical macro and binary structures without containing harmful payloads.
"""

import os

VBA_SAMPLE = '''
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
'''

def main():
    os.makedirs("samples", exist_ok=True)
    with open("samples/sample_macro.vba", "w") as f:
        f.write(VBA_SAMPLE.strip())
    print("[+] Generated samples/sample_macro.vba for olevba static analysis testing.")

if __name__ == "__main__":
    main()
