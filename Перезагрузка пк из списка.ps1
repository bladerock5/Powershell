$a = Get-Content -Path C:\temp\111.txt
foreach ($as in $a) {
Invoke-Command -ComputerName $as -ScriptBlock {shutdown -r -f -t 00}
}