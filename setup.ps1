function Log-Info {
  param (
    [string]$msg
  )
  Write-Host "$msg" -ForegroundColor Green
}

$PWD = Get-Location

Log-Info -msg "Install Web Browser"
winget install Brave.Brave

Log-Info -msg "Install Windows Terminal"
winget install Microsoft.WindowsTerminal

Log-Info -msg "Install Git"
winget install Git.Git

Log-Info -msg "Install Python"
winget install Python.Python.3.14

Log-Info -mgs "Install NodeJS"
winget install OpenJS.NodeJS.LTS

Log-Info -msg "Install Zig"
winget install zig.zig

Log-Info -msg "Install Clink"
winget install chrisant996.Clink

Log-Info -msg "Install Starship"
winget install Starship.Starship

Log-Info -msg "Install Neovim"
winget install Neovim.Neovim

Log-Info -msg "install Neovide"
winget install neovide.neovide

Log-Info -msg "install UniKey"
winget install UniKey.UniKey

Log-Info -msg "install Mpv"
winget install mpv.net

Log-Info -msg "install Google PlatformTools"
winget install Google.PlatformTools

Log-Info -msg "Install Aria2"
winget install aria2.aria2

Log-Info -msg "Install yt-dlp"
winget install yt-dlp.yt-dlp

Log-Info -msg "Install JetBrains Mono Nerd Font"
winget install DEVCOM.JetBrainsMonoNerdFont

Log-Info -msg "Reload The Path Environment Variable"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Log-Info -mgs "Clink Setup"
$origin_starship_lua_path = "$PWD\clink\starship.lua"
$target_starship_lua_path = "$HOME\AppData\Local\clink\starship.lua"

$origin_clink_start_path = "$PWD\clink\clink_start.cmd"
$target_clink_start_path = "$HOME\AppData\Local\clink\clink_start.cmd"

$origin_inputrc_path = "$PWD\clink\inputrc"
$target_inputrc_path = "$HOME\.inputrc"

if (Test-Path $target_starship_lua_path) {
  powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"Remove-Item -Path $target_starship_lua_path"'"
}
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"New-Item -ItemType SymbolicLink -Path $target_starship_lua_path -Target $origin_starship_lua_path"'"

if (Test-Path $target_clink_start_path) {
  powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"Remove-Item -Path $target_clink_start_path"'"
}
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"New-Item -ItemType SymbolicLink -Path $target_clink_start_path -Target $origin_clink_start_path"'"

if (Test-Path $target_inputrc_path) {
  powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"Remove-Item -Path $target_inputrc_path"'"
}
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"New-Item -ItemType SymbolicLink -Path $target_inputrc_path -Target $origin_inputrc_path"'"

cmd.exe /c "C:\Program Files (x86)\clink\clink.bat" autorun install

Log-Info -msg "Neovim Setup"
$origin_neovim_config_path = "$PWD\nvim"
$target_neovim_config_path = "$HOME\AppData\Local\nvim"

if (Test-Path $target_neovim_config_path) {
  powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"Remove-Item -Path $target_neovim_config_path -Recurse -Force"'"
}
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"New-Item -ItemType SymbolicLink -Path $target_neovim_config_path -Target $origin_neovim_config_path"'"

Log-Info -msg "Python Setup ENV"
$python_env_path = "$HOME\.python"
python -m venv $python_env_path
