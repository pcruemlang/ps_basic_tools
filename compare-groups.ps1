function compare-groups{
$GroupA = Read-host "Enter First Group " 
$GroupB = Read-host "Enter Second Group " 
$a =  Get-ADGroupMember $GroupA | ft name | out-file -encoding utf8a1.txt 
$a = gc a1.txt | Foreach {$_.TrimEnd()} | Set-Content a.txt 
$b =  Get-ADGroupMember $GroupB | ft name | out-file -encoding utf8 b1.txt 
$b = gc b1.txt | Foreach {$_.TrimEnd()} | Set-Content b.txt
$date = get-date -UFormat %d%m%y
remove-item a1.txt 
remove-item b1.txt 
write-host "Comparing members from $groupa to $groupb  .." 
Compare-Object $a $b -IncludeEqual | ft inputobject, @{n="file";e={if($_.SideIndicator -eq '=>') { "$GroupA" } if ($_.SideIdincator -eq '<=') {"$GroupB"} else { "Found in Both groups" } }} | Out-File -encoding utf8 $GroupA_compared_$GroupB_$date.txt 
}
