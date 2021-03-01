#Creat Share folder
Param (
[string]$path01,
[string]$grname,
[string]$shname
)
New-SmbShare -Name $shname -Path $path01 -ChangeAccess $grname -ReadAccess "softline\domain users"