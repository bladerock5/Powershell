#Поиск компьютера по части имени
(Get-ADComputer -Filter {SamAccountName -like "*vsmon*$"}).Name