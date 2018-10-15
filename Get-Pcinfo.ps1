function get-pcinfo
{
<#

.DESCRIPTION 

This will retrieve the following Attributes from a pc using the username to search or with the "-name" switch a pc number 
see examples or if the pc is offline it will get only the description. 

.EXAMPLE

get-pc snowden 

.EXAMPLE

get-pc -sam zur000pc 

#>
[CmdletBinding()]
param(
[Parameter(Mandatory=$True)]
[string[]]$computername,
[switch]$name = $false
) 

if ($name){
$computers  = Get-Qadcomputer $computername$ 
}
else {
$computers  = Get-Qadcomputer -description *$computername*
}
if (-Not $computers){
write-warning  "No $pcname Found in the AD  " 
}
foreach ($computer in $computers) {
$pcdesc = $computer.description
$pcname = $computer.name
$connection = test-connection -computername $pcname -count 1 -quiet

if ( $connection -eq "True") {
$CBIOS = Get-WmiObject -Class Win32_Bios -ComputerName $pcname
$CHW = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $pcname 
$CCPU = Get-WmiObject win32_processor -ComputerName $pcname
$CDisks = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $pcname 
$COS = Get-WmiObject -Class win32_operatingsystem -ComputerName $pcname 
$CNET = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -filter "Index=7" -ComputerName $pcname
$DSER = "not available"
if ($laptop){
$DSER = Get-WmiObject -Class win32_systemenclosure -ComputerName $pcname
}

$datei = @{ 
            'PC Name'= $pcname;
            'User ' = $pcdesc;
            'last booted' = $COS.ConvertToDateTime($COS.LastBootUpTime);
            'Model' = $CHW.Model;
 	        'PC Serial' = $CBIOS.SerialNumber;
            'CPU Name' = $CCPU.Name;
            'RAM' = "{0:n1} GB"  -f [math]::Round($CHW.TotalPhysicalMemory/1GB);
            'Total Disk Space ' = "{0:n0} GB"  -f [math]::Round($CDisks.size/1GB);
            'Total Free Space ' = "{0:n0} GB"  -f [math]::Round($CDisks.freespace/1GB);
            'Docking station' =  $DSER.SerialNumber;
            }

$dateien = new-object -typename PSObject -property $datei
write-output $dateien
}
else {
write-warning  "$pcname / user $pcdesc is offline " 
} 
}
}
