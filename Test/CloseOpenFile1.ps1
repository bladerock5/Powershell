$sessn = New-CIMSession -Computername msk02appsfs01
$username = "*alexandrovaoa*"
Get-SMBOpenFile -CIMSession $sessn | where {$_.ClientUserName -like $username}|Close-SMBOpenFile -CIMSession $sessn -Force