$prof32=$sam1=$usrs1=$null #Очистка переменных перед работой скрипта
$date = Get-Date
$date2 = Get-Date -UFormat %d%m%Y
$file = "C:\temp\scriptlog_$date2.txt" #Файл в котором будем хранить перезаписываемый лог
New-Item -Path $file -ItemType "file" -Force
function AddLog ($d) { 
    Add-Content -Path $file -Value $d -Encoding Unicode
}
AddLog "$date Поехали!"
AddLog "$date Получаем список всех логинов пользователей с интересными для нас свойстваим"
Get-ADUser -filter * -Properties SamAccountName, LastLogonDate, info, DistinguishedName | Export-Csv -Path "C:\temp\123.csv"
$a = @(Import-Csv -Path "C:\temp\123.csv") #Создаем массив для вычислений из csv
function KillUsr($a,$dn){ #Функция получения уволенных сотрудников с исключением "KeyUser" и логиневшихся ранее $dn
    $sam = @()
    foreach ($as in $a){
        $c = "*OU=DISCHARGE,DC=office,DC=softline,DC=ru" #интересующая нас OU c уволенными
        if($as.DistinguishedName -like $c){
            #Отсеиваиваем VIP
            if ($as.info -notmatch "KeyUser") {
                $refdate = (Get-Date).Date.AddDays(-$dn) #дата дня назад
                #Проверяем прошло ли $dn дня с последнего логона пользователя, если прошло удаляем его профили
                if($as.LastLogonDate -lt $refdate){
                    $sam += $as.SamAccountName                    
                }
            }
        }
    } return $sam
}
AddLog "$date Вычисляем список уволенных пользователей с последнем логином позднее 92 дней"
$sam1 = KillUsr($a,92)
function PathName($pas) { #Функция получения списка папок по пути $pas с исключениями *.V2 и Scripts
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
$pas1 = "G:\backup\*"
AddLog "$date Вычисляем имена профилей для пути $pas1"
$usrs1 = PathName($pas1)
function SravArr($arr1,$arr2) { #Функция сравнения массивов с выводом массива с совпадающими значениями
    foreach ($arr1s in $arr1) {
        for ($i=0; $i -lt $arr2.count;$i++) 
            {
                if($arr2[$i] -eq $arr1s){$arr2[$i] >> c:\temp\3.txt}
            }
    }
    return $arr3 = @(gc c:\temp\3.txt)
    Remove-Item -Path c:\temp\3.txt -Force #Подчищаем за функцией
}
AddLog "$date Ищем совпадения имен профилей с SamAccountName"
$prof31 = SravArr($usrs1,$sam1)
$pas11 = "G:\backup\"
function DelProf($arr,$path) { #Функция удаления данных по заданному массиву имен папок и пути
    foreach ($arrs in $arr){
        $arrsV2 = "$arrs.V2"
        Remove-Item -Recurse -Force "$path$arrs"
        #Иногда папки *.V2 нет, поэтому делаем проверку
        if ((Test-Path "$path$arrsV2") -eq $true){
            Remove-Item -Recurse -Force "$path$arrsV2"
        }
    }
}
AddLog "$date Удаляем профили по пути $pas1 удовлетворяющие условиям"
DelProf($prof31,$pas11)
#Бакапим через robocopy
$source = "V:\Profile"
$dist = "G:\backup"
AddLog "$date Запускаем ROBOCOPY"
robocopy $source $dist /e /copyall /r:0 /dcopy:T
AddLog "$date Работа ROBOCOPY закончена"
AddLog "$date Вычисляем список уволенных пользователей с последнем логином позднее 184 дней"
$sam2 = KillUsr($a,184)
$pas2 = "\\msk02daascl\Profile\*"
AddLog "$date Вычисляем имена профилей для пути $pas2"
$usrs2 = PathName($pas2)
AddLog "$date Ищем совпадения имен профилей с SamAccountName"
$prof32 = SravArr($usrs2,$sam2)
$pas22 = "\\msk02daascl\Profile\"
AddLog "$date Удаляем профили по пути $pas2 удовлетворяющие условиям"
DelProf($prof32,$pas22)