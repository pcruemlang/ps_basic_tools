function get-usergroups
{
[cmdletbinding()]
param( 
[parameter(mandatory=$true)]
[string]$user
)
$path = read-host "Enter the Path"
$start_time = get-date
 Get-ADPrincipalGroupMembership $user  | select name,GroupScope,GroupCategory | 
sort-object -property name | export-csv -NoTypeInformation -encoding utf8 -path $path\$user.csv
Write-Output "Time taken: $((Get-Date).Subtract($start_time).milliSeconds) millisecond(s)"
}
