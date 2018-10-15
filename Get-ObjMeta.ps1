function get-objmeta
{
[cmdletbinding()]
param( 
[parameter(mandatory=$true)]
[string]$obj)
write-warning "the object must be in DN form like so CN=Someone,OU=Users,OU=Zurich,DC=global,DC=gam,DC=com"  -WarningAction Inquire 
write-information "this script uses the DC dcname1.yourserver.com " 
repadmin /showobjmeta dcname1.yourserver.com "$obj"
}
