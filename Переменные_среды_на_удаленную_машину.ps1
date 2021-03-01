#Добавляет переменные среды на удаленную машину
Invoke-Command -ComputerName msk02tdaas01 -ScriptBlock 
{
    New-Item -Path variable:\MyNewVariable -Value MyNewValue -Force 
    gci variable: |
     ? {$_.Name -eq 'MyNewVariable'}
}