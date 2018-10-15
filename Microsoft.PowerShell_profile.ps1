
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

