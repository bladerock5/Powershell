#Для запуска сборщика логов с винды
$a = Get-Content -Path C:\temp\111.txt
foreach ($as in $a) {
Invoke-Command -ComputerName $as -ScriptBlock {
    #& 'C:\Program Files\Winlogbeat\install-service-winlogbeat.ps1'
    #'C:\Program Files\Winlogbeat\winlogbeat.exe'
    Start-Service winlogbeat
    }
}