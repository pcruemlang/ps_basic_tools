function convert-groups 
{
param(
[Parameter(mandatory=$True)]
[String]$grouptoremove,
[Parameter(mandatory=$True)]
[String]$grouptoadd
)
$ErrorActionPreference= 'stop'
trap { write-host  " [+] Action cancelled : $_ " -foregroundcolor Cyan}#trap
$domain = (Get-ADDomain).DistinguishedName
$userlist = Get-ADGroupmember "$grouptoremove" | select name,SamAccountName,distinguishedName
write-warning "this will remove all Users from : `n $grouptoremove and add them in $grouptoadd " -WarningAction Inquire 
$userList | 
foreach-object {
write-host  "Adding : "  -foregroundcolor green 
$_.Name +" - " +$_.samaccountname + "  to " + $grouptoadd
# add-ADGroupMember $grouptoadd -member $_.samaccountname # uncomment to make it work 
Start-Sleep –Seconds 1 # this is just for cosmetics 
write-host  "Removing : " -foregroundcolor red  
$_.Name +" - " + $_.samaccountname  + " from " + $grouptoremove 
#Remove-ADGroupMember $grouptoremove -member $_.samaccountname  # uncomment to make it work 
Start-Sleep –Seconds 1 # this is just for cosmetics 
 }#foreach
 
 }#function
convert-groups
