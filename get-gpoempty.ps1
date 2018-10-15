function get-gpoempty {
[cmdletbinding()]
Param(
[Parameter(Mandatory=$True)] 
[string]$displayname
)
import-module GroupPolicy
$User = $False 
$Computer = $False

[xml]$report = get-gporeport  -name $displayname -reporttype xml 


if ( $report.gpo.user.extensiondata) {
$User = $True
}

if ( $report.gpo.computer.extensiondata) {
$Computer = $True
}

New-object -Typename PSObject -Property @{
Displayname = $report.gpo.name 
UserGpo = $User 
PCGpo = $computer
}

}
