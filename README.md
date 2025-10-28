# Onion & Garlic Watch

Onion & Garlic Watch is a Rust-based utility that embeds and executes a PowerShell script to monitor Tor and I2P services on Windows.

## Technical Overview

- Implemented in Rust (edition 2024)
- Uses `include_str!()` to embed the PowerShell script at compile time
- Writes the embedded script to a temporary `.ps1` file during execution
- Executes it with PowerShell using:
  - `-NoProfile`
  - `-ExecutionPolicy Bypass`
  - `-File <temp_script>`
- Removes the temporary script file after execution
- PowerShell script monitors:
  - Tor ports: 9050, 9051, 9150, 9151
  - I2P ports: 7657, 4444
  - Related processes (`tor.exe`, `java.exe` containing "i2p" in path)
- Displays colorized output refreshed every 5 seconds

## Build

cargo build --release

Output binary: target\release\onion_garlic_watch.exe

## Next Steps

- Replace PowerShell backend with pure Rust for full portability
- Add optional logging or GUI mode
