# Для корректного отображения русской кодировки в консоли
[Console]::outputEncoding = [System.Text.Encoding]::GetEncoding('cp866') 

Function RDP_Resetfailure($server){
	$ts = qwinsta /server:$server
	$td = ($ts | where { ($_ -like "*Disc*" -or $_ -like "*Диск*" -or $_ -like "*ЁбЄ*" ) -and $_ -notlike "*services*"})
    $tdselect = $td # Для отладки или внесения в лог: Login Id State
	$td = $td -ireplace ("[^0-9]","") # оставляем только id сессий
    Clear-Host
    Write-Host "
    Список зависших сессий:
    "
	for($i=0; $i -lt $td.Count; $i++){
		Write-Host Reset RDP Failture session ID: $td[$i] $tdselect[$i]      #отладка просмотр id сессий
	}

    Write-Host
    if($td[0]){
        Write-Host "
        - Для сброса всех сесcий введите 0 
        - Или введите ID сбрасывемой сессии
        ====================================
        "
        $r = Read-Host -Prompt "Ваш выбор"
        Write-Host =============================
        # ==== Сброс всех сессий! =====
        if($r -eq 0 ){
            Write-Host
            Write-Host ==== Сброс всех сессий! =====
            for($i=0; $i -lt $td.Count; $i++){
		        Write-Host Reset RDP Failture session ID: $td[$i] $tdselect[$i]      #отладка просмотр id сессий
		        #rwinsta $td[$i] /server:$server            # сброс зависших сессий, раскомментируйте эту строку
                Write-Host
	        }
        }

        # Сброс сессии ID
        if($r -gt 0 ){
            $tdu = $tdselect | where { $_ -match ' '+$r  }
            Write-Host Reset RDP Failture session ID: $r $tdu
            #rwinsta $r /server:$server # сброс зависшей сессии, раскомментируйте эту строку
        }
    }
}

$server = "Msk02TDaaS01"
RDP_Resetfailure($server)