#Рабочий скрипт/Определяем несуществующие акаунты.
$usrnames = (Get-Item "\\msk02daascl\Profile\*").Name #Имена папок профилей
foreach ($usrname in $usrnames) {
#Сначала отсеиваем имена с '.V2'
if (!($usrname -match ".V2")){
#Проверяем есть ли такой логин в АД
    $usrexist = Get-ADUser -filter {(SamAccountName -eq $usrname)} | Select-Object -ExpandProperty SamAccountName
        if ($usrexist -eq $null) {
        #Записываем в файл, необходимо отредактировать
        $usrnameV2 = "$usrname.V2"
        $usrname >> c:\temp\DaasProfile.txt
        $usrnameV2 >> c:\temp\DaasProfile.txt
        }
    }
}