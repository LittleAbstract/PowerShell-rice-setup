# Restore profile
Copy-Item ".\PowerShell_profile_backup.ps1" $PROFILE -Force

# Reinstall modules
Import-Csv ".\ModulesBackup.csv" | ForEach-Object {
    Install-Module -Name $_.Name -RequiredVersion $_.Version -Force
}

# Restore starship
Copy-Item ".\starship.toml" "$env:APPDATA\starship.toml" -Force

# Restore Terminal settings
Copy-Item ".\WT_Settings_Backup.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
