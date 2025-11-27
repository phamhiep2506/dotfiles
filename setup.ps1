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

Log-Info -msg "Reload The Path Environment Variable"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Log-Info -mgs "Clink Setup"
$origin_starship_lua_path = "$PWD\clink\starship.lua"
$target_starship_lua_path = "$HOME\AppData\Local\clink\starship.lua"
if (Test-Path $target_starship_lua_path){
  powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"Remove-Item -Path $target_starship_lua_path"'"
}
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-Command \"New-Item -ItemType SymbolicLink -Path $target_starship_lua_path -Target $origin_starship_lua_path"'"
