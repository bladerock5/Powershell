#рабочий
$cn1 = "KZN01IT01"
Invoke-Command -ComputerName $cn1 -ScriptBlock {New-SmbShare -Name "TestDFS_Education$" -Path "C:\tmp\Kazan\Education" -ChangeAccess "softline\Sec.TestDFS.Education" -ReadAccess "softline\domain users"}
#Invoke-Command -ComputerName $cn1 -ScriptBlock {Remove-SmbShare -Name "TestDFS_Education$"}