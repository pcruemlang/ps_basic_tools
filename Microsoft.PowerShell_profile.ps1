
#help 
#help about_profiles

# set location & Modules 
set-location C:\

Import-Module Activedirectory

Cls

#help & about 
$cmdlet = (get-command -module Microsoft*,PS* | get-random).name
$about = (get-random -input (get-help about*)).name
write-host ""
write-host "## -----------------------------------------------## " -foregroundcolor green 
write-host "random cmdlet :  $cmdlet " -foregroundcolor green 
write-host "random about  :  $about " -foregroundcolor green 
write-host "## -----------------------------------------------## " -foregroundcolor green 
function prompt{
$Colors = @("Black","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Green","Cyan","Red","Magenta","Yellow","White")
$fg = get-random $colors
Write-Host "[$((Get-Date).timeofday.tostring().substring(0,8))] " -NoNewline -foregroundcolor $fg
Write-Host "PS " -nonewline -ForegroundColor green
Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -foregroundcolor cyan -nonewline
Write-Output "$('>' * ($nestedPromptLevel + 1)) "  
}
prompt
function set-remote{
$computer = read-host "enter PC "
.\psexec \\$computer -u $computer\admin  reg add "hklm\system\currentcontrolset\control\terminal server" /f /v fDenyTSConnections /t REG_DWORD /d 0
}
function serach-groups{
$target = read-host "Enter search term "
get-adgroup -filter {name -like "*$target*"} -properties * | select name,@{N="Owner";E={$_.ManagedBy.split("="",")[1]}},@{N="ID";E={$_.SamAccountName}} 
}
