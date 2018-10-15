Function Remove-Userlocal 
{ 
<# 

.DESCRIPTION

REMOVES users to local pc groups like remote desktop or administrator

.EXAMPLE

del-Userlocal -computer zur002pc -user u47106 -group "remote desktop users" 

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
$de.psbase.Invoke("remove",([ADSI]"WinNT://global/$user").path) 
}
