#Отключение ссылок в дфс, если путь к шаре не существует
$date2 = Get-Date -UFormat %d%m%Y #Дата для имени файла лога
$as = @()
Get-DfsnFolder -Path "\\office.softline.ru\FILES\*" | % {$as += $_.Path}
foreach ($a in $as){
        $tp = (Get-DfsnFolderTarget -Path $a).TargetPath
        if (!(Test-Path $tp) -eq $true){
            Get-DfsnFolderTarget -Path $a -TargetPath $tp >> c:\temp\DFSscriptLog_$date2.txt
            Set-DfsnFolderTarget -Path $a -TargetPath $tp -State "Offline" –ErrorAction SilentlyContinue -WhatIf
            Get-DfsnFolderTarget -Path $a -TargetPath $tp >> c:\temp\DFSscriptLog_$date2.txt           
            }
    }