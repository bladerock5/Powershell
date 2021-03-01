# Сброс зависших сессий, добавьте в расписание на своем скрипт сервере
Function RDP_Resetfailure($server){
	$ts = qwinsta /server:$server
	$td = ($ts | where { ($_ -like "*Disc*" -or $_ -like "*Диск*" -or $_ -like "*ЁбЄ*" ) -and $_ -notlike "*services*"})
	$tdselect = $td # Для отладки или внесения в лог: Login Id State
	$td = $td -ireplace ("[^0-9]","") # оставляем только id сессий
	for($i=0; $i -lt $td.Count; $i++){
		Write-Host Reset RDP Failture session ID: $td[$i] $tdselect[$i]      #отладка просмотр id сессий
		#rwinsta $td[$i] /server:$server            # сброс зависших сессий, раскомментируйте эту строку
	}
}

$server = "MyRDPServer"
RDP_Resetfailure($server)