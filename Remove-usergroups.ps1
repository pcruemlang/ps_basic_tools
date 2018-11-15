function Remove-usergroups 
{
$ErrorActionPreference= 'silentlycontinue'
trap { write-host  " [-] Action cancelled : $_ " -foregroundcolor Cyan}#trap
$grouptoremove = read-host "Type group to Remove"
$grouptoadd = read-host "Type group to Add"
$Ou = read-host "Type OU name to use" 
$domain = (get-addomain).DistinguishedName
$userList = Get-ADUser -Filter * -SearchBase "OU=$Ou,$domain" | select name,samaccountname
write-warning "this will remove all $Ou Users from $grouptoremove and add them in $grouptoadd " -WarningAction Inquire 
$userList | 
foreach-object {
 "Removing " + $_.Name + " from " +$grouptoremove 
 Remove-ADGroupMember $grouptoremove -member $_.samaccountname 
Start-Sleep –Seconds 1 #just added for show 
 "Adding " +$_.Name+"  from " + $grouptoadd
 add-ADGroupMember $grouptoadd -member $_.samaccountname 
Start-Sleep –Seconds 1
 }#foreach
 
 }#function
 Remove-usergroups
