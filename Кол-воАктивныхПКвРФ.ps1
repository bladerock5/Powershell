#(Get-ADComputer -Filter  {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name > e:\111.txt
 #-Properties "Enabled eq True"
#Get-ADComputer -Filter  {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU"
#(Get-ADComputer -Filter  {(Enabled -eq "True")} -SearchBase "OU=_6700, OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").count
(Get-ADComputer -Filter {(Enabled -eq "True")} -SearchBase "OU=_6700, OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").count