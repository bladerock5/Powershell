$a = (Get-ChildItem -Path '\\10.195.40.21\C$\Users').Name
$b = (Get-ADUser -Filter  {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").SamAccountName
Compare-Object $a $b
