# Созадём объект Excel
$Excel = New-Object -ComObject Excel.Application

# Делаем его видимым
$Excel.Visible = $true

# Добавляем рабочую книгу
$WorkBook = $Excel.Workbooks.Add()

#Переменная для работы с первым листом
$List1 = $WorkBook.Worksheets.Item(1)

# Переименовываем лист
$List1.Name = "$env:COMPUTERNAME"

# Заполняем ячейки - шапку таблицы
$List1.Cells.Item(1,1) = 'Job Name'
$List1.Cells.Item(1,2) = 'Job Object'
$List1.Cells.Item(1,3) = 'Job Days'
$List1.Cells.Item(1,4) = 'Restore Points'
$List1.Cells.Item(1,5) = 'Backup Repository Name'
$List1.Cells.Item(1,5) = 'Last BackUp'
$List1.Cells.Item(1,5) = 'Next BackUp'

# Переходим на следующую строку...
$Row = 2
$Column = 1

Add-PSSnapin VeeamPSSnapin
$Jobs = Get-VBRJob
Foreach($Job in $Jobs)
{ 
    $JobName = $Job.Name
    $Objects = $Job.GetObjectsInJob()
    $Day = $Job.ScheduleOptions.OptionsDaily.DaysSrv
    $Freq = $Job.ScheduleOptions.OptionsDaily.kind
        If($Freq -eq "Everyday")
            {
                $Day = "Everyday"
            }

    $RP = $Job.GetOptions().backupstorageoptions.retainCycles
    $VM = $Objects.Name
        #Get Backup Repository Name
    $RepoTarget = $Job.FindTargetRepository()
    $RepoTarget = $RepoTarget.Name
        #Get Next Last Backup
    $b = get-vbrjob -name $Job.Name | Get-VBRJobScheduleOptions

 #Заполняем ячейки
 $List1.Cells.Item($Row, $Column) = $JobName
 #Шагаем
 $Column++

 $List1.Cells.Item($Row, $Column) = $VM
 $Column++
 $List1.Cells.Item($Row, $Column) = $Day
 $Column++
 $List1.Cells.Item($Row, $Column) = $RP
 $Column++
 $List1.Cells.Item($Row, $Column) = $RepoTarget
 $Column++
 $List1.Cells.Item($Row, $Column) = $b.LatestRunLocal
 $Column++
 $List1.Cells.Item($Row, $Column) = $b.NextRun

     # Переходим на следующую строку и возвращаемся в первую колонку
 $Row++
 $Column = 1

}