
$usrs1=$usrs2=$null
$pas1 = "\\msk02daascl\Profile\*"
$pas11 = "\\msk02daascl\Profile\"
$pas2 = "G:\backup\*"
$pas22 = "G:\backup\"
$date = Get-Date
$date2 = Get-Date -UFormat %d%m%Y
$file = "C:\temp\scriptlog_$date2.txt" #Файл в котором будем хранить перезаписываемый лог
New-Item -Path $file -ItemType "file" -Force
function AddLog ($d) {
    Add-Content -Path $file -Value $d -Encoding Unicode
}
AddLog "$date Поехали!"
AddLog "$date Создаем таблицу с нужными нам свойствами пользователей"
Get-ADUser -filter * -Properties SamAccountName, LastLogonDate, info, DistinguishedName | Export-Csv -Path "C:\temp\123.csv"
AddLog "$date Закончили создавать таблицу с нужными нам свойствами пользователей"
$a = @(Import-Csv -Path "C:\temp\123.csv") #Создаем массив для вычислений из csv
function PathName($pas) {
    $usrnames = (Get-Item $pas).Name #Создаем список папок
    $usrs = @() #Массив названия папок, содержащий имена вида SamAccountName
    #Вычисляем Имена форма, которых соответствует SamAccountName
    foreach ($usrname in $usrnames) {
        #Сначала отсеиваем имена с '.V2'
        if (!($usrname -match ".V2")){
            #Отсеиваем с именем 'Scripts'
            if ($usrname -notlike "Scripts"){
                $usrs += $usrname
            }
        }
    } return $usrs
}
function ClearProf($a,$usrs,$dn,$pas) {
    foreach ($as in $a){
        $c = "*OU=DISCHARGE,DC=office,DC=softline,DC=ru" #интересующая нас OU c уволенными
       if($as.DistinguishedName -like $c){
            #Отсеиваиваем VIP
            if ($as.info -notmatch "KeyUser") {
                $refdate = (Get-Date).Date.AddDays(-$dn) #дата дня назад
                #Проверяем прошло ли $dn дня с последнего логона пользователя, если прошло удаляем его профили
                if($as.LastLogonDate -lt $refdate){
                    foreach ($usr in $usrs){
                        #Проверяем есть ли папки уволенных сотрудников
                        if ($as.SamAccountName -eq $usr) {
                            $usrV2 = "$usr.V2"
                            Remove-Item -Recurse -Force "$pas$usr"
                            #Иногда папки *.V2 нет, поэтому делаем проверку
                            if ((Test-Path "$pas$usrV2") -eq $true){
                                Remove-Item -Recurse -Force "$pas$usrV2"
                            }
                        }
                    }
                }
            }
        }
    }
}
AddLog "$date Создаем массив названия папок $pas1, содержащий имена вида SamAccountName"
$usrs1 = PathName($pas1)
AddLog "$date Закончили создавать массив названия папок $pas1, содержащий имена вида SamAccountName"
AddLog "$date Создаем массив названия папок $pas2, содержащий имена вида SamAccountName"
$usrs2 = PathName($pas2)
AddLog "$date Закончили создавать массив названия папок $pas2, содержащий имена вида SamAccountName"
AddLog "$date Запуск очистки $pas2"
ClearProf($a,$usrs2,184,$pas22)
AddLog "$date Окончание очистки $pas2"
    #Бакапим через robocopy
    $source = "V:\Profile"
    $dist = "G:\backup"
    AddLog "$date Запускаем ROBOCOPY"
    robocopy $source $dist /e /copyall /r:0 /dcopy:T
    AddLog "$date Работа ROBOCOPY закончена"
AddLog "$date Запуск очистки $pas1"
ClearProf($a,$usrs1,32,$pas11)
AddLog "$date Окончание очистки $pas1"
Remove-Item -Path "C:\temp\123.csv"