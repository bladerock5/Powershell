#Создание массива из CSV с известными именами столбцов и их колличеством, не должно быть пробелов
$a = "C:\temp\123\MSK02VSORK01.csv" #Расположение csv в переменную
$temp = gc "$a" #выввод содержимого csv в переменную
$array = @() #пустой массив
$temp | foreach {
    $elements=$_.split(",")
    $array+= ,@($elements[0],$elements[1],$elements[2],$elements[3],$elements[4],$elements[5],$elements[6])
}
#Проверка
foreach($value in $array)
{
    write-host $value[0] "`n" $value[1] "`n" $value[2] "`n" $value[3] "`n" $elements[4] "`n" $elements[5] "`n" $elements[6] "`n"
"`n"
}
$array = $NULL