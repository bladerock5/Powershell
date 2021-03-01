#Author:NaumovAV
#Date:10.04.2019
#Ver:1.0

$user = "naumovav"
$sessn = New-CIMSession –Computername msk02daascl02
Get-SMBOpenFile -CIMSession $sessn | where {$_.ClientUserName –like $user}|Close-SMBOpenFile -CIMSession $sessn