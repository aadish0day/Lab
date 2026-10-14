rule Detect_Reflective_DLL_Injection {
    meta:
        description = "Detects indicators of Reflective DLL Injection in process memory"
        author = "CyberLab DFIR Suite"
        date = "2024-10-14"
        reference = "MITRE ATT&CK T1055.001"
    strings:
        $mz = "MZ"
        $dos_stub = "This program cannot be run in DOS mode"
        $reflective_export = "ReflectiveLoader" ascii wide
        $kernel32 = "LoadLibraryA" ascii
        $getproc = "GetProcAddress" ascii
        $virtualalloc = "VirtualAlloc" ascii
    condition:
        $mz at 0 and ($reflective_export or ($dos_stub and ($kernel32 or $virtualalloc)))
}

rule Detect_Suspicious_PowerShell_Obfuscation {
    meta:
        description = "Detects base64 encoded and hidden PowerShell execution"
        author = "CyberLab DFIR Suite"
    strings:
        $enc1 = "-EncodedCommand" nocase
        $enc2 = "-e " nocase
        $enc3 = "-enc" nocase
        $hidden = "-WindowStyle Hidden" nocase
        $noprofile = "-NoProfile" nocase
        $download = "DownloadString" nocase
        $iex = "IEX" nocase
    condition:
        any of ($enc*) and ($hidden or $noprofile or $download or $iex)
}
