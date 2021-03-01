cls

$ScriptLocation = Get-Location
$IPList = Get-Content $ScriptLocation\WSLIST.txt
$IPListCount = $IPList.Count

If (Test-Path $ScriptLocation\Result.txt) {
    Remove-Item $ScriptLocation\Result.txt 
}

$FileExist = @()
$FileNotExist = @()
$OnLine = @()
$OffLine = @()
$PermissionDenied = @()
$UserName = @()


foreach ($IP in $IPList) { 
$IPListCount --
Write-Host "Осталось:" $IPListCount "| Проверяем " $IP

$UserName = Get-ChildItem "\\$IP\C$\Users" | %{$_.name}

    if (Test-Connection $IP -Quiet -Count 1) {
     $OnLine += $IP
         try {
          foreach ($user in $username) {
           if ((Test-Path "\\$IP\C$\Users\$user\AppData\Roaming\pool.drv" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Users\$user\AppData\Roaming\4433.dat" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Users\$user\AppData\Roaming\sta.dll" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Users\$user\AppData\Roaming\qq34.dat" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Intel\8.exe" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Temp\8.exe" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Windows\8.exe" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Temp\Mimikatz.exe" -ErrorAction Stop) -or (Test-Path "\\$IP\C$\Temp\Netscan.exe" -ErrorAction Stop))
           {
            $FileExist += $IP            
           }
           else {
            $FileNotExist += $IP            
           }    
          }
         }
        catch [System.UnauthorizedAccessException] {
         $PermissionDenied += $IP
        }
    }
    else {
     $OffLine += $IP
    }
}

$IPListCount = $IPList.Count
$OnLineCount = $OnLine.Count
$OffLineCount = $OffLine.Count
$PermissionDeniedCount = $PermissionDenied.Count

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#-----------------------------------------------------------------------------------------------------------------
"Компьютеров всего   : " + $IPListCount >> $ScriptLocation\Result.txt
"Компьютеров онлайн  : " + $OnLineCount >> $ScriptLocation\Result.txt
"Компьютеров оффлайн : " + $OffLineCount >> $ScriptLocation\Result.txt
" " >> $ScriptLocation\Result.txt
"Отказано в доступе на " + $PermissionDeniedCount + " компьютерах." >> $ScriptLocation\Result.txt 
" " >> $ScriptLocation\Result.txt
"Отказано в доступе:" >> $ScriptLocation\Result.txt
$PermissionDenied >> $ScriptLocation\Result.txt
"---" >> $ScriptLocation\Result.txt
" " >> $ScriptLocation\Result.txt
#-----------------------------------------------------------------------------------------------------------------
"Компьютеры оффлайн: " >> $ScriptLocation\Result.txt
$OffLine >> $ScriptLocation\Result.txt
"---" >> $ScriptLocation\Result.txt
" " >> $ScriptLocation\Result.txt
#-----------------------------------------------------------------------------------------------------------------
"Компьютеры онлайн: " >> $ScriptLocation\Result.txt
$OnLine >> $ScriptLocation\Result.txt
"---" >> $ScriptLocation\Result.txt
" " >> $ScriptLocation\Result.txt
#-----------------------------------------------------------------------------------------------------------------
"Файл(ы) обнаружены на :" >> $ScriptLocation\Result.txt
$FileExist | Select-Object -Unique >> $ScriptLocation\Result.txt
"---" >> $ScriptLocation\Result.txt
" " >> $ScriptLocation\Result.txt