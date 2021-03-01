#$a = Get-Content "C:\temp\123.txt"
$a = (Get-ADComputer -SearchBase ‘OU=RDSH,OU=Hosts,OU=DaaS2012r2,OU=CTXSVR,OU=SERVERS,OU=MSK02,OU=OFFICES,DC=office,DC=softline,DC=ru’ -Filter *).Name
foreach ($a1 in $a)
{
Invoke-Command -ComputerName $a1 -ScriptBlock {gpupdate /force}
}