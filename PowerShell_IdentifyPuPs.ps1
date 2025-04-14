# Check for suspicious processes
Write-Host "Checking for suspicious processes..."
Get-Process | Where-Object { $_.Path -like "*AppData*" -or $_.Path -like "*Temp*" } | Select-Object Name, Path, Id | Format-Table -AutoSize

# Check for suspicious files in common PuP locations
Write-Host "Checking common PuP directories..."
$paths = @(
    "$env:APPDATA\*",
    "$env:LOCALAPPDATA\*",
    "$env:TEMP\*"
)
foreach ($path in $paths) {
    Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | 
    Where-Object { $_.Extension -in @(".exe", ".dll") -and $_.LastWriteTime -gt (Get-Date).AddDays(-7) } |
    Select-Object Name, Directory, LastWriteTime | Format-Table -AutoSize
}

# Check for suspicious registry keys
Write-Host "Checking registry for suspicious keys..."
$regPaths = @(
    "HKCU:\Software",
    "HKLM:\Software"
)
foreach ($regPath in $regPaths) {
    Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue | 
    Where-Object { $_ -match "toolbar|adware|optimizer" } | 
    Select-Object PSChildName | Format-Table -AutoSize
}
