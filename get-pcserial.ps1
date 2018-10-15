function get-pcserial{
<#
.NOTES
For Powershell 2.0 ! 
.DESCRIPTION 
reads a text file with computernames checks if they are online and gets their serial number 
.EXAMPLE
get-pcserial -path c:\pathfile.txt	
#>
[cmdletbinding()]
param( 
[parameter(mandatory=$true)]
[string]$path
)
Import-Module Activedirectory
$dateien = @()
$computers = gc $path
foreach ($computer in $computers) {
$isonline = test-connection -computername $computer -count 1 -quiet
if ($isonline) {
$serial = (Get-WmiObject -Class Win32_Bios -ComputerName $computer).SerialNumber

$datei = @{ 
            'PC'= $computer;
            'Serial' = $serial;
            }

$dateien += new-object -typename PSObject -property $datei

}

else  {

$datei = @{ 
            'PC'= $computer;
            'Serial' = "pc offline";
            }

$dateien += new-object -typename PSObject -property $datei
}

}

$dateien | export-csv -Path $path_new.csv -NoTypeInformation  -encoding utf8 

}
