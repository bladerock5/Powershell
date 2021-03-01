$a = Get-ADComputer -Filter {SamAccountName -like "*vsbkp*"}
$a.name > c:\temp\222.txt