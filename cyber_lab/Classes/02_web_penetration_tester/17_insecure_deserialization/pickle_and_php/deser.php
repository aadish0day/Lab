<?php
/**
 * PHP Object Injection Target Helper
 */

class UserProfile {
    public $username = "guest";
    public $role = "user";

    public function getInfo() {
        if ($this->role === 'admin') {
            return "Welcome Administrator ({$this->username})! Privilege Escalation Successful! Flag: FLAG{PHP_DESERIALIZATION_ADMIN_ROLE_BYPASS}";
        }
        return "Welcome {$this->username} (Role: {$this->role}).";
    }
}

class CommandExec {
    public $command = "id";

    public function __destruct() {
        if (!empty($this->command)) {
            echo "[+] CommandExec::__destruct() executing command: " . $this->command . "\n";
            passthru($this->command);
        }
    }
}

class FileViewer {
    public $filepath = "/etc/hosts";

    public function __wakeup() {
        if (!empty($this->filepath) && file_exists($this->filepath)) {
            echo "[+] FileViewer::__wakeup() reading file: " . $this->filepath . "\n";
            readfile($this->filepath);
            echo "\n";
        }
    }
}

// Receive payload from argv or stdin
$raw = $argv[1] ?? file_get_contents("php://stdin");
if (empty($raw)) {
    echo "[-] Error: No payload provided.\n";
    exit(1);
}

// Detect and decode base64 if applicable
$trimmed = trim($raw);
$decoded = base64_decode($trimmed, true);
if ($decoded !== false && preg_match('/^[a-zA-Z0-9\/+]+={0,2}$/', $trimmed)) {
    $payload = $decoded;
} else {
    $payload = $raw;
}

echo "[*] Processing PHP serialized payload...\n";
try {
    $obj = @unserialize($payload);
    if ($obj === false && $payload !== 'b:0;') {
        echo "[-] unserialize() failed or returned false. Check payload syntax.\n";
    } else {
        $type = is_object($obj) ? get_class($obj) : gettype($obj);
        echo "[+] Successfully unserialized data of type: {$type}\n";
        if (is_object($obj) && method_exists($obj, 'getInfo')) {
            echo "[+] " . $obj->getInfo() . "\n";
        }
    }
} catch (Throwable $e) {
    echo "[-] Exception during unserialize: " . $e->getMessage() . "\n";
}
