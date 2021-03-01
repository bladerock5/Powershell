#Очистка профиля на серверах корпорейт аппс
$cv = (Get-WmiObject Win32_UserProfile -filter "LocalPath like 'C:\\Users\\korolevavs'").Delete() 
$a = Get-Content -Path C:\temp\111.txt
foreach ($as in $a) {
Invoke-Command -ComputerName $as -ScriptBlock {(Get-WmiObject Win32_UserProfile -filter "LocalPath like 'C:\\Users\\korolevavs'").Delete()}
}