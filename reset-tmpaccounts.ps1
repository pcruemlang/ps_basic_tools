function reset-tmpaccounts 
{
Import-Module Activedirectory
<#
.DESCRIPTION 
sets a password for temp accounts and sends an email to the helpdesk
.EXAMPLE
get-pwdinfo -username <squidward>
#>
[CmdletBinding()]
param(
[Parameter(Mandatory=$True)]
[string[]]$tmp = @("tmp","tmpX") # insert the temp account name 
)
$pwd = read-host "Enter New Password" 
$woche = (get-date).addDays(8)
$heute = get-date
$securepwd = ConvertTo-SecureString $pwd -AsPlainText -Force
$body = @"

Dear IT Service Desk ,

Automatic AD Account password change ran at:$($heute)

for the accounts: $($tmp)

Passwords were changed to:  $($pwd) and 
account Expiry date was set to  $($woche)

Note:This is an automated mail, do not attempt to reply!

This email should not be printed or forwarded as it contains confidential password information !

Regards
Your Signature

"@
write-warning "Are you sure you want to change the password for $tmp ? " -WarningAction Inquire 
$tmp | 
foreach {
set-adaccountpassword $_ -Reset -Newpassword $securepwd;
Set-ADAccountExpiration $_ -timespan "8" ;
set-aduser $_ -description "Password Expires:$woche"
 } 
Send-MailMessage –From "sender@mail.com" –To "recipient@mail.com" –Subject "AD Account Password Change - SUCCESS" –Body $body –SmtpServer your.exchange.server.com
}
