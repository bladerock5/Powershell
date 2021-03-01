$a = (Get-ADComputer -filter {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name
foreach ($A in $a)
{
$b = [System.Net.Dns]::GetHostaddresses("$a")[0].ipaddresstostring
   Write-Host $a $b
}