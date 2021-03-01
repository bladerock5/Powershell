#if (!(Test-Path $env:ProgramFiles\1)) {ping ya.ru -n 1} - (!(***)) восклицательный знак с ковычками превращает в булевое выражение

#if (!(ping ya.gru -n 1)) {Write-host Yes}
#else {Write-host No}



$as = (Get-ADComputer -Filter {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name
ForEach ($a in $as) {
if (Test-Path -Path "\\$a\c$\Program Files\FreeCommander\FreeCommander.exe") {
Copy-Item -Path "\\10.195.40.25\f$\SoftInstall\FTP\FreeCommander.ftp" -Destination "\\$a\c$\Program Files\FreeCommander\FreeCommander.ftp" -Force
                                                                             }
else {
Write-Host "$a Облом"
     }
               }     