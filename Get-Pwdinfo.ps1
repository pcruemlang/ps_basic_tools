function get-Pwdinfo
{
<#
.DESCRIPTION 

Get Password status infos by typing first or last name.  

.EXAMPLE

get-pwdinfo -username <squidward>

#>
[CmdletBinding()]
param(
 [Parameter(Mandatory=$True)]
 [string]$UserName)
 $target = Get-ADuser $UserName  -properties *
 if ($target)  { 
   foreach ($line in $target)
   { 
          $newobj = @{
            'user enabled'=$line.enabled;
            'user name '= $line.name;
            'user id ' = $line.SamAccountName;
            'Password last set ' = $line.PasswordLastSet;
            'Password expired ' = $line.PasswordExpired;
            'User Phone ' = $line.OfficePhone;        
            'Password locked ' = $line.LockedOut;
            'Expiry date ' = $line.PasswordLastSet.addDays(90);
            'Homedrive' = $line.ProfilePath;
              }
        $data = new-object -typename PSObject -property $newobj
     write-output $data
     }
   }
  else
    {
    write-warning "No users found ! " 
    }
 }
