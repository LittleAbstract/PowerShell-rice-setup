# =============================================
#  UNIVERSAL RICED POWERSHELL PROFILE (ASCII)
# =============================================

# --- Detect PowerShell 7 or Windows PowerShell ---
$IsPwsh7 = $PSVersionTable.PSVersion.Major -ge 7

# --- Initialize Oh-My-Posh prompt ---
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

# --- Load optional modules quietly ---
Import-Module Terminal-Icons -ErrorAction SilentlyContinue
Import-Module PSReadLine -ErrorAction SilentlyContinue

# --- Autocomplete & History setup ---
if ($IsPwsh7) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd $true
} else {
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -EditMode Windows
}

# --- Aliases and helper functions ---
Set-Alias -Name ll -Value Get-ChildItem
function home { Set-Location ~ }
function up { Set-Location .. }
function prof { notepad $PROFILE }

# --- Random Bible verse ---
try {
    $verse = Invoke-RestMethod -Uri "https://labs.bible.org/api/?passage=random&type=json" | Select-Object -First 1
    $text  = ($verse.text -replace '<[^>]+>', '')
    Write-Host ""
    Write-Host ("BIBLE: " + $verse.bookname + " " + $verse.chapter + ":" + $verse.verse + " - " + $text) -ForegroundColor Yellow
    Write-Host ""
}
catch {
    Write-Host "BIBLE: Stay steadfast in the Word." -ForegroundColor Yellow
}

# --- System information banner ---
$timestamp = (Get-Date).ToString("dddd, MMMM dd yyyy - hh:mm tt")
Write-Host ("TIME: " + $timestamp) -ForegroundColor Cyan
Write-Host ("USER: " + $env:USERNAME + " @ " + $env:COMPUTERNAME) -ForegroundColor DarkCyan
Write-Host ("PATH: " + (Get-Location)) -ForegroundColor Gray
Write-Host ""

# --- Optional PATH additions ---
# $env:Path += ";C:\Tools\Scripts;C:\Program Files\nodejs"
