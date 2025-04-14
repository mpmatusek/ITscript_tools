# PowerShell script to detect common PuPs
Write-Host "Scanning for Potentially Unwanted Programs (PuPs)..." -ForegroundColor Green

# List of PuPs and their known identifiers (processes, files, registry keys)
$PuPs = @{
    "Conduit Search" = @{ Process = "Conduit.exe"; Path = "*Conduit*"; RegKey = "HKCU:\Software\Conduit" }
    "Superfish" = @{ Process = "Superfish.exe"; Path = "*Superfish*"; RegKey = "HKLM:\Software\Superfish" }
    "Crossrider" = @{ Process = "Crossrider.exe"; Path = "*Crossrider*"; RegKey = "HKCU:\Software\Crossrider" }
    "Ask Toolbar" = @{ Process = "AskTb*.exe"; Path = "*Ask Toolbar*"; RegKey = "HKLM:\Software\AskToolbar" }
    "Yahoo Search Redirects" = @{ Process = "YSearch*.exe"; Path = "*Yahoo Search*"; RegKey = "HKCU:\Software\Yahoo" }
    "MyWebSearch" = @{ Process = "MyWebSearch*.exe"; Path = "*MyWebSearch*"; RegKey = "HKLM:\Software\MyWebSearch" }
    "PC Optimizer Pro" = @{ Process = "PCOptimizerPro.exe"; Path = "*PC Optimizer Pro*"; RegKey = "HKCU:\Software\PC Optimizer Pro" }
    "Advanced SystemCare" = @{ Process = "ASC*.exe"; Path = "*Advanced SystemCare*"; RegKey = "HKLM:\Software\IObit" }
    "MyCleanPC" = @{ Process = "MyCleanPC.exe"; Path = "*MyCleanPC*"; RegKey = "HKCU:\Software\MyCleanPC" }
    "Babylon Toolbar" = @{ Process = "Babylon.exe"; Path = "*Babylon*"; RegKey = "HKLM:\Software\Babylon" }
    "Snap.do Toolbar" = @{ Process = "Snapdo.exe"; Path = "*Snap.do*"; RegKey = "HKCU:\Software\Snapdo" }
    "Delta Toolbar" = @{ Process = "DeltaTB.exe"; Path = "*Delta Toolbar*"; RegKey = "HKLM:\Software\Delta" }
    "Honey Variants" = @{ Process = "Honey*.exe"; Path = "*Honey*"; RegKey = "HKCU:\Software\Honey" }
    "ShopperPro" = @{ Process = "ShopperPro.exe"; Path = "*ShopperPro*"; RegKey = "HKLM:\Software\ShopperPro" }
    "PriceChop" = @{ Process = "PriceChop.exe"; Path = "*PriceChop*"; RegKey = "HKCU:\Software\PriceChop" }
    "WinFixer" = @{ Process = "WinFixer.exe"; Path = "*WinFixer*"; RegKey = "HKLM:\Software\WinFixer" }
    "Security Tool" = @{ Process = "SecurityTool.exe"; Path = "*Security Tool*"; RegKey = "HKCU:\Software\Security Tool" }
    "Antivirus 360" = @{ Process = "AV360.exe"; Path = "*Antivirus 360*"; RegKey = "HKLM:\Software\Antivirus 360" }
}

# Function to check for PuP processes
function Check-PuPProcesses {
    param ($PuPName, $ProcessName)
    Write-Host "Checking processes for $PuPName..."
    $processes = Get-Process | Where-Object { $_.ProcessName -like $ProcessName } | Select-Object Name, Path, Id
    if ($processes) {
        Write-Host "Found potential $PuPName processes:" -ForegroundColor Yellow
        $processes | Format-Table -AutoSize
    } else {
        Write-Host "No $PuPName processes detected." -ForegroundColor Green
    }
}

# Function to check for PuP files
function Check-PuPFiles {
    param ($PuPName, $PathPattern)
    Write-Host "Checking files for $PuPName..."
    $commonPaths = @(
        "$env:ProgramFiles\*",
        "$env:ProgramFiles(x86)\*",
        "$env:APPDATA\*",
        "$env:LOCALAPPDATA\*",
        "$env:TEMP\*"
    )
    $files = foreach ($path in $commonPaths) {
        Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | 
        Where-Object { $_.FullName -like $PathPattern -and $_.Extension -in @(".exe", ".dll") }
    }
    if ($files) {
        Write-Host "Found potential $PuPName files:" -ForegroundColor Yellow
        $files | Select-Object Name, FullName, LastWriteTime | Format-Table -AutoSize
    } else {
        Write-Host "No $PuPName files detected." -ForegroundColor Green
    }
}

# Function to check for PuP registry keys
function Check-PuPRegistry {
    param ($PuPName, $RegKey)
    Write-Host "Checking registry for $PuPName..."
    if (Test-Path $RegKey) {
        Write-Host "Found potential $PuPName registry keys:" -ForegroundColor Yellow
        Get-ItemProperty -Path $RegKey -ErrorAction SilentlyContinue | Format-Table -AutoSize
    } else {
        Write-Host "No $PuPName registry keys detected." -ForegroundColor Green
    }
}

# Iterate through each PuP and perform checks
foreach ($PuP in $PuPs.GetEnumerator()) {
    $PuPName = $PuP.Key
    $Details = $PuP.Value
    Write-Host "`n--- Scanning for $PuPName ---" -ForegroundColor Cyan
    Check-PuPProcesses -PuPName $PuPName -ProcessName $Details.Process
    Check-PuPFiles -PuPName $PuPName -PathPattern $Details.Path
    Check-PuPRegistry -PuPName $PuPName -RegKey $Details.RegKey
}

# Check for suspicious browser extensions (basic check)
Write-Host "`nChecking for suspicious browser extensions..." -ForegroundColor Green
$extensionPaths = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\extensions"
)
foreach ($path in $extensionPaths) {
    Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | 
    Where-Object { $_.Name -match "toolbar|adware|optimizer|honey|shopper" } |
    Select-Object Name, FullName | Format-Table -AutoSize
}

Write-Host "Scan complete. Review output for potential PuPs." -ForegroundColor Green
