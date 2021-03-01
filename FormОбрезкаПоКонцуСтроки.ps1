#Вывод имен серверов по роли RDS с обрезкой имени FQDN по последним символам
$v = Get-RDServer | Where-Object {$_.Roles -eq "RDS-RD-SERVER"}
$xs = $v.Server 
foreach ($x in $xs) {
$bs = $x.TrimEnd("office.softline.ru")
$bs
}