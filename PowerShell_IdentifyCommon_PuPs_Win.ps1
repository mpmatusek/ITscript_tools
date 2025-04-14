# PowerShell script to detect common PuPs and log results to Desktop
# Log file will be created as PuP_Scan_Log_<timestamp>.txt on Desktop

# Set up log file path on Desktop with timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = "$env:USERPROFILE\Desktop\PuP_Scan_Log_$timestamp.txt"

# Function to write to both console and log file
function Write-Log {
    param ($Message, $ForegroundColor = "White")
    # Write to console
    Write-Host $Message -ForegroundColor $ForegroundColor
    # Append to log file with timestamp
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $logFile -Value $logMessage
}

# Initialize log file
Write-Log "Starting PuP scan..." -ForegroundColor Green
Write-Log "Log file: $logFile"

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
    "OneStart Browser" = @{ Process = "OneStart.exe"; Path = "*OneStart*"; RegKey = "HKLM:\Software\OneStart" }
    "CCleaner" = @{ Process = "CCleaner*.exe"; Path = "*CCleaner*"; RegKey = "HKLM:\Software\Piriform" }
    "WaveBrowser" = @{ Process = "WaveBrowser.exe"; Path = "*WaveBrowser*"; RegKey = "HKLM:\Software\WaveBrowser" }
}

# Function to check for PuP processes
function Check-PuPProcesses {
    param ($PuPName, $ProcessName)
    Write-Log "Checking processes for $PuPName..."
    $processes = Get-Process | Where-Object { $_.ProcessName -like $ProcessName } | Select-Object Name, Path, Id
    if ($processes) {
        Write-Log "Found potential $PuPName processes:" -ForegroundColor Yellow
        # Format process info as a string for logging
        $processOutput = $processes | Format-Table -AutoSize | Out-String
        Write-Log $processOutput
    } else {
        Write-Log "No $PuPName processes detected." -ForegroundColor Green
    }
}

# Function to check for PuP files
function Check-PuPFiles {
    param ($PuPName, $PathPattern)
    Write-Log "Checking files for $PuPName..."
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
        Write-Log "Found potential $PuPName files:" -ForegroundColor Yellow
        # Format file info as a string for logging
        $fileOutput = $files | Select-Object Name, FullName, LastWriteTime | Format-Table -AutoSize | Out-String
        Write-Log $fileOutput
    } else {
        Write-Log "No $PuPName files detected." -ForegroundColor Green
    }
}

# Function to check for PuP registry keys
function Check-PuPRegistry {
    param ($PuPName, $RegKey)
    Write-Log "Checking registry for $PuPName..."
    if (Test-Path $RegKey) {
        Write-Log "Found potential $PuPName registry keys:" -ForegroundColor Yellow
        # Format registry info as a string for logging
        $regOutput = Get-ItemProperty -Path $RegKey -ErrorAction SilentlyContinue | Format-Table -AutoSize | Out-String
        Write-Log $regOutput
    } else {
        Write-Log "No $PuPName registry keys detected." -ForegroundColor Green
    }
}

# Iterate through each PuP and perform checks
foreach ($PuP in $PuPs.GetEnumerator()) {
    $PuPName = $PuP.Key
    $Details = $PuP.Value
    Write-Log "`n--- Scanning for $PuPName ---" -ForegroundColor Cyan
    Check-PuPProcesses -PuPName $PuPName -ProcessName $Details.Process
    Check-PuPFiles -PuPName $PuPName -PathPattern $Details.Path
    Check-PuPRegistry -PuPName $PuPName -RegKey $Details.RegKey
}

# Check for suspicious browser extensions
Write-Log "`nChecking for suspicious browser extensions..." -ForegroundColor Green
$extensionPaths = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\extensions",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Extensions"
)
$extensionsFound = $false
foreach ($path in $extensionPaths) {
    $extensions = Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | 
    Where-Object { $_.Name -match "toolbar|adware|optimizer|honey|shopper|onestart|ccleaner|wavebrowser" } |
    Select-Object Name, FullName
    if ($extensions) {
        if (-not $extensionsFound) {
            Write-Log "Found potential suspicious browser extensions:" -ForegroundColor Yellow
            $extensionsFound = $true
        }
        # Format extension info as a string for logging
        $extOutput = $extensions | Format-Table -AutoSize | Out-String
        Write-Log $extOutput
    }
}
if (-not $extensionsFound) {
    Write-Log "No suspicious browser extensions detected." -ForegroundColor Green
}

Write-Log "Scan complete. Results saved to $logFile." -ForegroundColor Green
