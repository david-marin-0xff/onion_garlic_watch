while ($true) {
    Clear-Host
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Write-Host "================================================================" -ForegroundColor Gray
    Write-Host "                     Onion & Garlic Watch                       " -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Gray
    Write-Host "Timestamp: $timestamp" -ForegroundColor White
    Write-Host ""

    # ------------------ I2P Monitoring ------------------
    $i2pPorts = 7657, 4444
    $javaI2P = Get-Process java -ErrorAction SilentlyContinue | Where-Object {$_.Path -like "*i2p*"}
    $portI2P = Get-NetTCPConnection -LocalPort $i2pPorts -ErrorAction SilentlyContinue

    if ($javaI2P -or $portI2P) {
        $pidListI2P = if ($javaI2P) { ($javaI2P | Select-Object -ExpandProperty Id) -join ", " } else { "N/A" }
        $connCountI2P = if ($portI2P) { $portI2P.Count } else { 0 }
        Write-Host "[OK] I2P is running" -ForegroundColor Green
        Write-Host "     PID(s): $pidListI2P" -ForegroundColor Gray
        Write-Host "     Active connections: $connCountI2P" -ForegroundColor Gray
    } else {
        Write-Host "[X] I2P is not running" -ForegroundColor Red
    }
    Write-Host ""

    # ------------------ Tor Monitoring ------------------
    $torPorts = 9050, 9051, 9150, 9151
    $torProcess = Get-Process tor -ErrorAction SilentlyContinue
    $portTor = Get-NetTCPConnection -LocalPort $torPorts -ErrorAction SilentlyContinue

    if ($torProcess -or $portTor) {
        $pidListTor = if ($torProcess) { ($torProcess | Select-Object -ExpandProperty Id) -join ", " } else { "N/A" }
        $connCountTor = if ($portTor) { $portTor.Count } else { 0 }
        Write-Host "[OK] Tor is running" -ForegroundColor Green
        Write-Host "     PID(s): $pidListTor" -ForegroundColor Gray
        Write-Host "     Active connections: $connCountTor" -ForegroundColor Gray
    } else {
        Write-Host "[X] Tor is not running" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Gray
    Write-Host "                Encrypt, Anonymize, Repeat                      " -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Gray
    Start-Sleep -Seconds 5
}
