function get-unusedpcinou {
<#
.NOTES
For Powershell 2.0 ! 
.DESCRIPTION 
this checks ou for online but unlogged pc's
.EXAMPLE
get-unusedpcinou -ou bikini.bottom	
#>
[cmdletbinding()]
param( 
[parameter(mandatory=$true)]
[string]$ou
)
Import-Module Activedirectory
$ErrorActionPreference= 'silentlycontinue'
$ou = "OU=$ou,"+(Get-ADRootDSE).defaultNamingContext
$oucomputers = get-adcomputer -filter * -searchbase $ou 
$oucomputers | foreach {
$pcname = $_.name 
$pingtest = test-connection -computername $pcname -count 1 -quiet
if($pingtest){ 
$usedby = (Get-WmiObject -Class win32_computersystem -ComputerName $pcname).username
if ($usedby){  
$usedby = $usedby.split('\')[1] # splits the domain from the user
$username = (get-aduser $usedby).name  
$test = @{}
$test.add("PC Online in use [x];",$pcname+"-"+$username+"-"+$usedby)
}
else {
$test = @{}
$test.add("PC Online [o];",$pcname)
}
}
else{
$test = @{}
$test.add("PC Offline [x];",$pcname)
}
write-output $test 
}#foreach
} 
