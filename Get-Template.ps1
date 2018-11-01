function get-template
{
<#
.DESCRIPTION 

this script will set the given user a new password 
and send $whoever an email with the text template filled up and  ready to forward  

.EXAMPLE

get-newjoinertemplate -user $whoever 	

#>
[cmdletbinding()]
param( 
[parameter(mandatory=$true)]
[string]$user
)
Write-Warning "Attention this script will reset the users password ! " -WarningAction Inquire 
$abfrage = get-aduser $user -Properties * 
$data = @{}
$data.add("aName",$abfrage.Name)
$data.add("Name",$abfrage.GivenName)
$data.add("unumber",$abfrage.SamAccountName)
$data.add("pw",("{0:1}" -f ($abfrage.physicalDeliveryOfficeName+$abfrage.SamAccountName.substring(1,5))))
$data.add("email",$abfrage.EmailAddress)
$data.add("ext",$abfrage.telephoneNumber)
$data.add("Manager",$abfrage.Manager)
$data.manager = $data.manager.split('='',')[1]
$usermail = get-aduser $env:username -properties mail
write-warning "password will be now set to $($data.pw) for $($data.Name)" -WarningAction Inquire 
Set-ADAccountPassword $user -Reset -NewPassword (ConvertTo-SecureString $($data.pw) -AsPlainText -Force ) 
$body = @"
Dear [$($data.Name)]

 manager : $($data.Manager) 


Personnel information :
login : 	[$($data.unumber)]
Password = 	[$($data.pw)]
Email : 		[$($data.email)]
Initials : 	              [$($data.unumber)]
Tel. Ext. : 	[$($data.ext)]

"@

Send-MailMessage -From "someone@company.com" -to $usermail.mail -Subject "your text $($data.aName)"  -body $body  -SmtpServer "exchange.com"
}

