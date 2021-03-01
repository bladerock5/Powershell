#Имена папок профилей
$usrnames = (Get-Item "G:\backup\*").Name
$date2 = Get-Date -UFormat %d%m%Y
$date = Get-Date
$file = "C:\temp\scriptlog_$date2.txt" #Файл в котором будем хранить перезаписываемый лог
New-Item -Path $file -ItemType "file" -Force
#Вычисляем SamAccountName пользователей OU=DISCHARGE
$sam = (Get-ADUser -Filter {SamAccountName -ne "*"} -SearchBase "OU=DISCHARGE,DC=office,DC=softline,DC=ru").SamAccountName
function AddLog ($d) {
    Add-Content -Path $file -Value $d -Encoding Unicode
}
AddLog "$date - Запуск очистки G:\backup\"
foreach ($usrname in $usrnames) {
    #Сначала отсеиваем имена с '.V2'
    if (!($usrname -match ".V2")){
        #Отсеиваем с именем 'Scripts'
        if ($usrname -notlike "Scripts"){
            $usrnameV2 = "$usrname.V2"
            #Проверяем есть ли такой логин в АД
            $usrexist = Get-ADUser -filter {(SamAccountName -eq $usrname)} | Select-Object -ExpandProperty SamAccountName
            if ($usrexist -eq $null) {
                            Remove-Item -Recurse -Force "G:\backup\$usrname"
                            AddLog "$date $usrname - Удален нет в AD"
                                if ((Test-Path "G:\backup\$usrnameV2") -eq $true){
                                    Remove-Item -Recurse -Force "G:\backup\$usrnameV2"
                                    }
                            AddLog "$date $usrnameV2 - Удален нет в AD"
            } else {
                foreach ($sams in $sam){
                    #Проверяем есть ли профили в списке уволенных
                    if ($sams -eq $usrname) {
                        #Проверка на время + действие
                        $refdate = (Get-Date).Date.AddDays(-184) #время 184 дня назад
                        $timeprof = (Get-ADUser $sams -Properties *).LastLogonDate #Время последнего логона пользователя
                        if($timeprof -lt $refdate){
                            Remove-Item -Recurse -Force "G:\backup\$usrname"
                            AddLog "$date $usrname - Удален, старше 184 дней"
                                if ((Test-Path "G:\backup\$usrnameV2") -eq $true){
                                    Remove-Item -Recurse -Force "G:\backup\$usrnameV2"
                                    }
                            AddLog "$date $usrnameV2 - Удален, старше 184 дней"
                        }
                    }
                }
            }
        }
    }
}
AddLog "$date Очистка переменных/массивов"
#Обнуляем массивы/переменные
$usrnames = $sams = $usrname = $usrnames = $usrnameV2 = $usrexist = $refdate = $timeprof = $null
AddLog "$date Работа в G:\backup\ закончена"
    #Бакапим через robocopy
    $source = "V:\Profile"
    $dist = "G:\backup"
    AddLog "$date Запускаем ROBOCOPY"
    robocopy $source $dist /e /copyall /r:0 /dcopy:T
    AddLog "$date Работа ROBOCOPY закончена"
AddLog "$date - Запуск очистки V:\Profile\"
#Имена папок профилей
$usrnames = (Get-Item "V:\Profile*").Name
AddLog "$date - Запуск очистки V:\Profile"
foreach ($usrname in $usrnames) {
    #Сначала отсеиваем имена с '.V2'
    if (!($usrname -match ".V2")){
        #Отсеиваем с именем 'Scripts'
        if ($usrname -notlike "Scripts"){
            $usrnameV2 = "$usrname.V2"
            #Проверяем есть ли такой логин в АД
            $usrexist = Get-ADUser -filter {(SamAccountName -eq $usrname)} | Select-Object -ExpandProperty SamAccountName
            if ($usrexist -eq $null) {
                            Remove-Item -Recurse -Force "V:\Profile\$usrname"
                            AddLog "$date $usrname - Удален нет в AD"
                                if ((Test-Path "V:\Profile$usrnameV2") -eq $true){
                                    Remove-Item -Recurse -Force "V:\Profile$usrnameV2"
                                    }
                            AddLog "$date $usrnameV2 - Удален нет в AD"
            } else {
                foreach ($sams in $sam){
                    #Проверяем есть ли профили в списке уволенных
                    if ($sams -eq $usrname) {
                        #Проверка на время + действие
                        $refdate = (Get-Date).Date.AddDays(-92) #время 92 дня назад
                        $timeprof = (Get-ADUser $sams -Properties *).LastLogonDate #Время последнего логона пользователя
                        if($timeprof -lt $refdate){
                            Remove-Item -Recurse -Force "V:\Profile$usrname"
                            AddLog "$date $usrname - Удален, старше 92 дней"
                                if ((Test-Path "V:\Profile$usrnameV2") -eq $true){
                                Remove-Item -Recurse -Force "V:\Profile$usrnameV2"
                                }
                            AddLog "$date $usrnameV2 - Удален, старше 92 дней"
                        }
                    }
                }
            }
        }
    }
}
AddLog "$date Очистка переменных/массивов"
#Обнуляем массивы/переменные
$usrnames = $date = $date2 = $sam = $sams = $usrname = $usrnames = $usrnameV2 = $usrexist = $refdate = $timeprof = $file = $null
AddLog "$date Работа в V:\Profile закончена"