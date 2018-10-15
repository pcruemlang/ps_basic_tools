function get-gpostring{
Import-Module grouppolicy
$string = Read-Host -Prompt "GPO Search String" 
$DomainName = $env:USERDNSDOMAIN 
write-warning "Finding all the GPOs in $DomainName..." 
$allGposInDomain = Get-GPO -All -Domain $DomainName 
 
# Look through each GPO's XML for the string 
write-warning  "Starting search...." 
foreach ($gpos in $allGposInDomain) { 
    $report = Get-GPOReport -Name $gpos.DisplayName -ReportType Xml 
    if ($report -match $string) { 
       write-host "Mach Found  : $($gpos.DisplayName)" -foreground red
        } # end if 
    else { 
       write-host "No Match Found : $($gpos.DisplayName)" -foreground green
    } # end else 
} # end foreach 
}
