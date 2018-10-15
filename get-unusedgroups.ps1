Import-Module Activedirectory
$dt = get-date -Format 'dd_MM_yyyy'
Get-ADGroup -filter * -Properties Name,Distinguishedname,groupcategory,groupscope, `
              whencreated,whenchanged,member,`
              memberof, SIDHistory,samaccountname, Description -SearchBase 'OU=Zurich,DC=global,DC=gam,DC=com' |
              Select-object  Name,Distinguishedname,groupcategory,groupscope,whencreated,whenchanged,member,`
              memberof,SIDHistory,samaccountname, `
              Description,@{N='memberCount';E={$_.member.count}},@{N='MemberofCount';E={$_.memberof.count}},`
              @{N='SID';E={$_.sidhistory -join ',' }},`
              @{N='DaysSinceChange';E={[math]::round((new-timespan $_.whenchanged).totaldays,0)}} | 
              sort-object Name | export-csv GroupsReport_$dt.csv -notypeinformation 
