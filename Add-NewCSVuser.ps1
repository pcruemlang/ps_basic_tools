# creates user with a pre formatted CSV file 
# works with powershell PSVersion  2.0
# from goateepfe 
$p = import-csv "$path\users.csv" -Delimiter ";" # needs to be changed 
$p | select-object Title, Department,City, state, office, EmployeeID,`
@{n='name';e={($_.'First Name'.substring(0,3)+$_.'last Name').substring(0,7)}}, `
@{n='samaccountname';e={($_.'First Name'.substring(0,3)+$_.'last Name').substring(0,6)}},`
@{n='Displayname';e={($_.'First Name'+' , '+$_.'last Name')}},`
@{n='GivenName';e={($_.'First Name')}},`
@{n='SurName';e={($_.'Last Name')}},`
@{n='HomeDirectory';e={('\\homedrive$\'+$_.'EmployeeID')}},`
@{n='Description';e={($_.'last name' +' - '+$_.'EmployeeID'+' Dept.: '+$_.'department')}}, `
@{n='Path';e={('OU='+$_.'City'+','+(Get-ADRootDSE).defaultNamingContext)}} | 
New-AdUser `
-changepasswordatlogon $true `
-enabled $true  `
-accountpassword $(convertTo-securestring $pwd -asplaintext -force ) # not secure change method 
