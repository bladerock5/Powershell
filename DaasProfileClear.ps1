#Имена папок профилей
$usrnames = (Get-Item "G:\backup\*").Name
$file = "C:\temp\scriptlog.txt" #Файл в котором будем хранить перезаписываемый лог
New-Item -Path $file -ItemType "file" -Force
$date = Get-Date
Add-Content -Path $file -Value "$date - Запуск очистки G:\backup\" -Encoding Unicode
foreach ($usrname in $usrnames) {
    #Сначала отсеиваем имена с '.V2'
    if (!($usrname -match ".V2")){
        #Отсеиваем с именем 'Scripts'
        if ($usrname -notlike "Scripts"){
        #Проверяем есть ли такой логин в АД
        $usrexist = Get-ADUser -filter {(SamAccountName -eq $usrname)} | Select-Object -ExpandProperty SamAccountName
            if ($usrexist -eq $null) {                            
                $usrnameV2 = "$usrname.V2"
                    #Проверка на время + действие
                    $refdate = (Get-Date).Date.AddDays(-92) #время 92 дня назад, переспросить и поменять
                    $timeprof = (gi "\\msk02daascl\Profile\$usrname").LastWriteTime #Время последнего изменения
                        If($timeprof -lt $refdate){
                            Remove-Item -Recurse -Force "G:\backup\$usrnameV2"
                            Add-Content -Path $file -Value "$date $usrnameV2 - Удален" -Encoding Unicode
                            Remove-Item -Recurse -Force "G:\backup\$usrname"
                            Add-Content -Path $file -Value "$date $usrname - Удален" -Encoding Unicode
                        }
            }
        }
    }
}
Add-Content -Path $file -Value "$date Работа в G:\backup\ закончена" -Encoding Unicode
#Бакапим через robocopy
$source = "V:\Profile"
$dist = "G:\backup"
Add-Content -Path $file -Value "$date Запускаем ROBOCOPY" -Encoding Unicode
robocopy $source $dist /e /copyall /r:0 /dcopy:T
Add-Content -Path $file -Value "$date Работа ROBOCOPY закончена" -Encoding Unicode
Add-Content -Path $file -Value "$date - Запуск очистки V:\Profile\" -Encoding Unicode
#Имена папок профилей
$usrnames = (Get-Item "V:\Profile\*").Name
foreach ($usrname in $usrnames) {
    #Сначала отсеиваем имена с '.V2'
    if (!($usrname -match ".V2")){
        #Отсеиваем с именем 'Scripts'
        if ($usrname -notlike "Scripts"){
        #Проверяем есть ли такой логин в АД
        $usrexist = Get-ADUser -filter {(SamAccountName -eq $usrname)} | Select-Object -ExpandProperty SamAccountName
            if ($usrexist -eq $null) {                            
                $usrnameV2 = "$usrname.V2"
                    #Удаляем $usrnameV2 и $usrname в папке Profile
                        Remove-Item -Recurse -Force "V:\Profile\$usrnameV2"
                        Add-Content -Path $file -Value "$date $usrnameV2 - Удален" -Encoding Unicode
                        Remove-Item -Recurse -Force "V:\Profile\$usrname"
                        Add-Content -Path $file -Value "$date $usrname - Удален" -Encoding Unicode
            }
        }
    }
}