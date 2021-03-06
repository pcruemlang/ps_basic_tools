Function Add-Userlocal 
{ 
<# 
.DESCRIPTION
add users to local pc groups like "remote desktop users"  or "administrator" whitout the using the GUI 
.EXAMPLE
add-Userlocal -computer zur002pc -user u47106 -group "remote desktop users" 
#>
[cmdletBinding()] 
Param( 
[Parameter(Mandatory=$True)] 
[string]$computer,
[Parameter(Mandatory=$True)] 
[string]$group, 
[Parameter(Mandatory=$True)] 
[string]$user 
$domain = $env:userdomain
) 
$ErrorActionPreference= 'silentlycontinue'
trap { write-host  " [-] Action cancelled : $_ " -foregroundcolor Cyan}  
$de = [ADSI]"WinNT://$computer/$Group,group" 
$de.psbase.Invoke("add",([ADSI]"WinNT://$domain/$user").path) 
}
