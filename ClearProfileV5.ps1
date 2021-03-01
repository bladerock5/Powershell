Import-Module ActiveDirectory
    $prof32=$sam1=$usrs1=$null #Очистка переменных перед работой скрипта
    $date = Get-Date #Дата для лога
    $date2 = Get-Date -UFormat %d%m%Y #Дата для имени файла лога
    $file = "C:\temp\scriptlog_$date2.txt" #Файл в котором будем хранить перезаписываемый лог
    $dst = "G:\backup"
	$src = "V:\Profile"
New-Item -Path $file -ItemType "file" -Force
function AddLog ($d) { #Функция для упрощения записи в лог
    Add-Content -Path $file -Value $d -Encoding Unicode
}
AddLog "$date Поехали!"
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
function DelProf($arr,$path) { #Функция удаления данных по заданному массиву имен папок и пути
    foreach ($arrs in $arr){
            $arrsV2 = "$arrs.V2"
        Remove-Item -Path "$path$arrs" -Recurse -Force –ErrorAction SilentlyContinue -WhatIf       
        if ((Test-Path "$path$arrsV2") -eq $true){ #Иногда папки *.V2 нет, поэтому делаем проверку
            Remove-Item -Path "$path$arrsV2" -Recurse -Force  –ErrorAction SilentlyContinue -WhatIf
        }
    }
}
AddLog "$date Получаем список всех логинов пользователей с интересными для нас свойствами"
$a = @()
Get-ADUser -filter * -Properties SamAccountName, LastLogonDate, info, DistinguishedName | % {$a += $_}
if ((Test-Path $src) -eq $true){
    AddLog "$date Вычисляем список уволенных пользователей с последнем логином позднее 92 дней"
        $dn1 = (Get-Date).Date.AddDays(-92)
        $sam1 = @()
        $a | where {($_.DistinguishedName -like "*OU=DISCHARGE,DC=office,DC=softline,DC=ru") -and ($_.info -notmatch "KeyUser") -and ($_.LastLogonDate -lt ((Get-Date).Date.AddDays(-92)))} | % {$sam1 += $_.SamAccountName}
        $pas1 = "$src\*"
    AddLog "$date Вычисляем имена профилей для пути $pas1"
        $usrs1 = PathName($pas1)   
    AddLog "$date Ищем совпадения имен профилей с SamAccountName"
        $prof31 = @()
        $sam1 | ? {$_ -in $usrs1} | % {$prof31 += $_}
        $pas11 = "$src\"    
        if ($prof31 -eq $null){
            AddLog "$date Нет профилей уволенных сотрудников с последним логином позднее 92 дней"
        }else{
                AddLog "$date Удаляем профили по пути $pas1 удовлетворяющие условиям"
                DelProf($prof31,$pas11)
             }
    if ((Test-Path $dst) -eq $true){ 
        #Бакапим через robocopy        
        AddLog "$date Запускаем ROBOCOPY"
        robocopy $src $dst /e /copyall /r:0 /dcopy:T /LOG:c:\temp\robocopy_$date2.log -WhatIf
        AddLog "$date Работа ROBOCOPY закончена"
    }
}
if ((Test-Path $dst) -eq $true){ 
    AddLog "$date Вычисляем список уволенных пользователей с последнем логином позднее 184 дней"
        $dn2 = (Get-Date).Date.AddDays(-184)
        $sam2 = @()
        $a | where {($_.DistinguishedName -like "*OU=DISCHARGE,DC=office,DC=softline,DC=ru") -and ($_.info -notmatch "KeyUser") -and ($_.LastLogonDate -lt ((Get-Date).Date.AddDays(-184)))} | % {$sam2 += $_.SamAccountName}
        $pas2 = "$dst\*"
    AddLog "$date Вычисляем имена профилей для пути $pas2"
        $usrs2 = PathName($pas2)
    AddLog "$date Ищем совпадения имен профилей с SamAccountName"
        $prof32 = @()
        $sam2 | ? {$_ -in $usrs2} | % {$prof32 += $_}
        $pas22 = "$dst\"    
        if ($prof32 -eq $null){
        AddLog "$date Нет профилей уволенных сотрудников с последним логином позднее 184 дней"
        }else{
            AddLog "$date Удаляем профили по пути $pas2 удовлетворяющие условиям"
            DelProf($prof32,$pas22)
             }
}
AddLog "$date Завершена работа скрипта"