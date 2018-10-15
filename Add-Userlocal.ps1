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
) 
$de = [ADSI]"WinNT://$computer/$Group,group" 
$de.psbase.Invoke("add",([ADSI]"WinNT://global/$user").path) 
}
