#Поиск рдп сессии пользователя по логину на серверах из списка в файле
$bs = Get-Content "c:\temp\222.txt"
foreach ($b in $bs) { 
$c = (get-terminalsession -computername $b).UserName

 if ($c -eq "SOFTLINE\danshinaoa") {

Write-host $b
 }
}