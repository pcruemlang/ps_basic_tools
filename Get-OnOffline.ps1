function get-OnOffline
<# 

.DESCRIPTION

this will check all pc's if they're online or offline no input needed 

.EXAMPLE

 get-OnOffline 

#>
{
$computers  = Get-ADComputer -description "*ptpres*" 
foreach ($computer in $computers) 
{
$pcdesc = $computer.description
$pcname = $computer.name
if ((test-connection -computername $computer.name -BufferSize 16 -count 1 -quiet)) 
  {
$online += @("PC Online : $pcname - $pcdesc")
   }
else 
  {
$offline += @("PC offline : $pcname - $pcdesc")
   } 
}
foreach ($pc in $offline) {
write-host $pc -background red -foreground blue
}
}
