#Скрипт проверки доступности серверов RDS
$names = (Get-ADComputer -SearchBase ‘OU=Hosts,OU=DaaS2019,OU=CTXSVR,OU=SERVERS,OU=MSK02,OU=OFFICES,DC=office,DC=softline,DC=ru’ -Filter * -Properties *).Name
foreach ($name in $names) {
    if (Test-Connection $name) {
        #Write-Output "$name доступен" | Write-ColorOutput green
        Write-Host "$name доступен" -ForegroundColor DarkGreen -BackgroundColor White
        }
        else {
            Write-Host "$name недоступен" -ForegroundColor Red -BackgroundColor White
            }
    }