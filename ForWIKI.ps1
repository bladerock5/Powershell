#Кодировка в UTF-8 без BOM, иначе не добавит
$a = "Div.Engineers", "div.coordinators", "div.sysadmins"
$b = @()
"login,password,email,groups,default_group" >> C:\temp\111.csv
foreach ($a1 in $a) {
$b += (Get-ADGroupMember $a1).SamAccountName
}
foreach ($b1 in $b) {
$b1+",,"+((Get-ADUser $b1 -Properties *).mail)+",writers01,Registered" >> C:\temp\111.csv
}