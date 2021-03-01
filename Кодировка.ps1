$b = (Get-ChildItem -Path C:\111 | Where {$_.extension -eq ".csv"}).Name
foreach ($b in $B) {
$c = get-content -Encoding OEM c:\111\$b
Set-Content -Encoding UTF8 -value $c -Path c:\111\$b
}