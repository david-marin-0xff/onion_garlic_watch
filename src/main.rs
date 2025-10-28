use std::process::Command;
use std::env;
use std::fs;
use std::path::PathBuf;
use std::io::Write;

fn main() {
    // Embed the PowerShell script source at compile time
    const SCRIPT: &str = include_str!("../onion_garlic_watch.ps1");

    // Write script to a temporary file
    let mut temp_path = std::env::temp_dir();
    temp_path.push("onion_garlic_watch.ps1");

    if let Err(e) = fs::write(&temp_path, SCRIPT) {
        eprintln!("Error writing temp script: {}", e);
        std::process::exit(1);
    }

    // Execute PowerShell with the embedded script
    let status = Command::new("powershell")
        .args([
            "-NoProfile",
            "-ExecutionPolicy", "Bypass",
            "-File", temp_path.to_str().unwrap()
        ])
        .status();

    match status {
        Ok(s) if s.success() => println!("[OK] Script finished successfully."),
        Ok(_) => eprintln!("[WARN] Script exited with a nonzero code."),
        Err(e) => eprintln!("[ERR] Failed to launch PowerShell: {}", e),
    }

    // Clean up (optional)
    let _ = fs::remove_file(&temp_path);
}
