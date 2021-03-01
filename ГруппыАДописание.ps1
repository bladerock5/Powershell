Get-ADGroup -filter * -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU" -Properties * |
 Format-Table Name, Description