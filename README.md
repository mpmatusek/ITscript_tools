# Potentially Unwanted Programs (PuPs) Removal Guide

This guide provides step-by-step instructions to remove common Potentially Unwanted Programs (PuPs) from Windows systems. Always back up important data before making changes, and consider running a trusted antivirus (e.g., Windows Defender, Malwarebytes) after removal to ensure no remnants remain.

## General Precautions
- **Run as Administrator**: Many steps require elevated privileges.
- **Use Safe Mode**: Boot into Safe Mode to prevent PuPs from interfering (Settings > System > Recovery > Advanced Startup > Restart Now > Troubleshoot > Advanced Options > Startup Settings > Restart > Press 4).
- **Backup Registry**: Export the registry before editing (regedit > File > Export).
- **Verify Sources**: Only download removal tools from official websites.

---

## Adware

### Conduit Search
- **Symptoms**: Browser redirects to Conduit search, unwanted toolbars.
- **Removal Steps**:
  1. **Uninstall**: Go to `Control Panel > Programs > Uninstall a Program`. Remove "Conduit" or "Search Protect."
  2. **Browser Cleanup**: Reset browsers (Chrome: Settings > Advanced > Reset; Firefox: Help > Troubleshooting Information > Refresh; Edge: Settings > Reset Settings).
  3. **Remove Files**: Delete `C:\Program Files\Conduit` and `C:\Users\<YourUser>\AppData\Local\Conduit`.
  4. **Registry**: Open `regedit`, navigate to `HKLM\Software\Conduit` and `HKCU\Software\Conduit`, delete these keys.
  5. **Scan**: Run Malwarebytes or AdwCleaner to remove leftovers.

### Superfish
- **Symptoms**: Ads injected into websites, browser slowdown.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "Superfish" or "VisualDiscovery" from Control Panel.
  2. **Browser Extensions**: Remove Superfish extensions (Chrome: Settings > Extensions; Firefox: Add-ons > Extensions).
  3. **Certificates**: Open `certmgr.msc`, check `Trusted Root Certification Authorities`, delete any "Superfish Inc." certificates.
  4. **Files**: Delete `C:\Program Files\Superfish` and `C:\Windows\System32\Superfish`.
  5. **Scan**: Use Windows Defender to verify removal.

### Crossrider
- **Symptoms**: Unwanted ads, browser redirects.
- **Removal Steps**:
  1. **Uninstall**: Remove "Crossrider" or related apps from Control Panel.
  2. **Browser Reset**: Reset all browsers to default settings.
  3. **Files**: Delete `C:\Program Files\Crossrider` and `C:\Users\<YourUser>\AppData\Local\Crossrider`.
  4. **Registry**: Delete `HKCU\Software\Crossrider` and `HKLM\Software\Crossrider`.
  5. **Scan**: Use AdwCleaner for residual cleanup.

---

## Browser Hijackers

### Ask Toolbar
- **Symptoms**: Homepage set to Ask.com, persistent toolbar.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "Ask Toolbar" or "Ask Search" from Control Panel.
  2. **Browser Cleanup**: Remove Ask extensions and reset browser settings.
  3. **Files**: Delete `C:\Program Files\Ask.com` and `C:\Program Files\AskToolbar`.
  4. **Registry**: Remove `HKLM\Software\AskToolbar` and `HKCU\Software\Ask.com`.
  5. **Scan**: Run Malwarebytes to ensure complete removal.

### Yahoo Search Redirects
- **Symptoms**: Browser redirects to Yahoo Search unexpectedly.
- **Removal Steps**:
  1. **Extensions**: Check Chrome/Firefox/Edge for unauthorized extensions, remove any tied to Yahoo.
  2. **Browser Reset**: Reset browser settings to defaults.
  3. **Files**: Search for `Yahoo` in `C:\Program Files` and `C:\Users\<YourUser>\AppData`, delete suspicious folders.
  4. **Registry**: Delete `HKCU\Software\Yahoo` if it contains redirect-related entries.
  5. **Scan**: Use AdwCleaner to remove malicious extensions.

### MyWebSearch
- **Symptoms**: MyWebSearch toolbar, altered search engine.
- **Removal Steps**:
  1. **Uninstall**: Remove "MyWebSearch" or "FunWebProducts" from Control Panel.
  2. **Browser Cleanup**: Delete MyWebSearch extensions and reset browsers.
  3. **Files**: Delete `C:\Program Files\MyWebSearch` and `C:\Program Files\FunWebProducts`.
  4. **Registry**: Remove `HKLM\Software\MyWebSearch` and `HKCU\Software\MyWebSearch`.
  5. **Scan**: Run Malwarebytes for thorough cleanup.

---

## Fake System Optimizers/Cleaners

### PC Optimizer Pro
- **Symptoms**: Fake scan alerts, performance claims.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "PC Optimizer Pro" from Control Panel.
  2. **Task Scheduler**: Open `taskschd.msc`, delete any PC Optimizer Pro tasks.
  3. **Files**: Delete `C:\Program Files\PC Optimizer Pro` and `C:\Users\<YourUser>\AppData\Roaming\PC Optimizer Pro`.
  4. **Registry**: Remove `HKCU\Software\PC Optimizer Pro` and `HKLM\Software\PC Optimizer Pro`.
  5. **Scan**: Use Windows Defender to check for remnants.

### Advanced SystemCare
- **Symptoms**: Aggressive optimization prompts, bundled extras.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "Advanced SystemCare" via Control Panel.
  2. **Browser Cleanup**: Remove any IObit extensions from browsers.
  3. **Files**: Delete `C:\Program Files\IObit` and `C:\Users\<YourUser>\AppData\Roaming\IObit`.
  4. **Registry**: Remove `HKLM\Software\IObit` and `HKCU\Software\IObit`.
  5. **Scan**: Run AdwCleaner to remove bundled PuPs.

### MyCleanPC
- **Symptoms**: Exaggerated PC issue alerts, subscription prompts.
- **Removal Steps**:
  1. **Uninstall**: Remove "MyCleanPC" from Control Panel.
  2. **Services**: Open `services.msc`, stop and disable MyCleanPC services.
  3. **Files**: Delete `C:\Program Files\MyCleanPC` and `C:\Users\<YourUser>\AppData\Local\MyCleanPC`.
  4. **Registry**: Remove `HKCU\Software\MyCleanPC` and `HKLM\Software\MyCleanPC`.
  5. **Scan**: Use Malwarebytes for verification.

---

## Toolbars

### Babylon Toolbar
- **Symptoms**: Changed homepage, translation toolbar.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "Babylon Toolbar" from Control Panel.
  2. **Browser Cleanup**: Remove Babylon extensions and reset browsers.
  3. **Files**: Delete `C:\Program Files\Babylon` and `C:\Users\<YourUser>\AppData\Local\Babylon`.
  4. **Registry**: Remove `HKLM\Software\Babylon` and `HKCU\Software\Babylon`.
  5. **Scan**: Run AdwCleaner to remove traces.

### Snap.do Toolbar
- **Symptoms**: Snap.do search redirects, toolbar clutter.
- **Removal Steps**:
  1. **Uninstall**: Remove "Snap.do" or "Smartbar" from Control Panel.
  2. **Browser Reset**: Clear Snap.do extensions and reset browser settings.
  3. **Files**: Delete `C:\Program Files\Snap.do` and `C:\Users\<YourUser>\AppData\Local\Snapdo`.
  4. **Registry**: Remove `HKCU\Software\Snapdo` and `HKLM\Software\Snapdo`.
  5. **Scan**: Use Malwarebytes for cleanup.

### Delta Toolbar
- **Symptoms**: Delta Search homepage, unwanted ads.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "Delta Toolbar" from Control Panel.
  2. **Browser Cleanup**: Remove Delta extensions and reset browsers.
  3. **Files**: Delete `C:\Program Files\Delta` and `C:\Users\<YourUser>\AppData\Local\Delta`.
  4. **Registry**: Remove `HKLM\Software\Delta` and `HKCU\Software\Delta`.
  5. **Scan**: Run AdwCleaner to ensure removal.

---

## Coupon/Shopping Assistants

### Honey Variants (Unofficial)
- **Symptoms**: Intrusive ads, tracking beyond legitimate Honey.
- **Removal Steps**:
  1. **Extensions**: Remove suspicious Honey extensions from Chrome/Firefox/Edge.
  2. **Uninstall**: Check Control Panel for unauthorized "Honey" programs, uninstall them.
  3. **Files**: Delete `C:\Program Files\Honey` or `C:\Users\<YourUser>\AppData\Local\Honey` if unofficial.
  4. **Registry**: Remove `HKCU\Software\Honey` if tied to PuP behavior.
  5. **Scan**: Run Malwarebytes to detect malicious variants.

### ShopperPro
- **Symptoms**: Coupon pop-ups, browser slowdown.
- **Removal Steps**:
  1. **Uninstall**: Remove "ShopperPro" from Control Panel.
  2. **Browser Cleanup**: Delete ShopperPro extensions and reset browsers.
  3. **Files**: Delete `C:\Program Files\ShopperPro` and `C:\Users\<YourUser>\AppData\Local\ShopperPro`.
  4. **Registry**: Remove `HKLM\Software\ShopperPro` and `HKCU\Software\ShopperPro`.
  5. **Scan**: Use AdwCleaner for residuals.

### PriceChop
- **Symptoms**: Aggressive coupon ads, tracking.
- **Removal Steps**:
  1. **Uninstall**: Uninstall "PriceChop" from Control Panel.
  2. **Browser Reset**: Remove PriceChop extensions and reset browser settings.
  3. **Files**: Delete `C:\Program Files\PriceChop` and `C:\Users\<YourUser>\AppData\Local\PriceChop`.
  4. **Registry**: Remove `HKCU\Software\PriceChop` and `HKLM\Software\PriceChop`.
  5. **Scan**: Run Malwarebytes to verify removal.

---

## Fake Antivirus/Scareware

### WinFixer
- **Symptoms**: Fake virus alerts, payment demands.
- **Removal Steps**:
  1. **Safe Mode**: Boot into Safe Mode to prevent interference.
  2. **Uninstall**: Remove "WinFixer" from Control Panel.
  3. **Files**: Delete `C:\Program Files\WinFixer` and `C:\Users\<YourUser>\AppData\Local\WinFixer`.
  4. **Registry**: Remove `HKLM\Software\WinFixer` and `HKCU\Software\WinFixer`.
  5. **Scan**: Use Malwarebytes in Safe Mode for thorough cleanup.

### Security Tool
- **Symptoms**: Locked desktop, fake infection warnings.
- **Removal Steps**:
  1. **Safe Mode**: Boot into Safe Mode with Networking.
  2. **Uninstall**: Remove "Security Tool" from Control Panel.
  3. **Files**: Delete `C:\Program Files\Security Tool` and `C:\Users\<YourUser>\AppData\Local\Security Tool`.
  4. **Registry**: Remove `HKCU\Software\Security Tool` and `HKLM\Software\Security Tool`.
  5. **Scan**: Run Windows Defender and Malwarebytes.

### Antivirus 360
- **Symptoms**: Mimics antivirus, demands payment.
- **Removal Steps**:
  1. **Safe Mode**: Boot into Safe Mode.
  2. **Uninstall**: Uninstall "Antivirus 360" from Control Panel.
  3. **Files**: Delete `C:\Program Files\Antivirus 360` and `C:\Users\<YourUser>\AppData\Local\Antivirus 360`.
  4. **Registry**: Remove `HKLM\Software\Antivirus 360` and `HKCU\Software\Antivirus 360`.
  5. **Scan**: Use AdwCleaner and Malwarebytes for cleanup.

---

## Additional Tools
- **Malwarebytes**: Free download from `https://www.malwarebytes.com`. Run a full scan post-removal.
- **AdwCleaner**: Free from `https://www.malwarebytes.com/adwcleaner`. Targets browser-based PuPs.
- **Windows Defender**: Built-in; update and run a full scan (Settings > Update & Security > Windows Security > Virus & Threat Protection).

## Prevention Tips
- Download software only from official websites.
- Use "Custom" installation to avoid bundled PuPs.
- Keep Windows and browsers updated.
- Enable real-time protection in Windows Defender.

---

*Last Updated: April 14, 2025*
