$username = Get-Item -Path "\\msk02appsfs01\UserDocuments$\*" | %{$_.Name}

foreach ($u in $username) {
    $FilePath1  = "\\msk02appsfs01\UserDocuments$\$u\AppData\Roaming\1C\1CEStart\1CEStart.cfg"
    If ($FilePath1 -eq $True) {
    $ChangeKey=Get-Content $FilePath1 | ForEach-Object {$_ -replace '\\\\msk02web1c\\spisokbaz','\\dfs\files\SyncFiles\1C_Lists'} 
	Set-Content $FilePath $ChangeKey -Encoding Unicode
    Write-host "$FilePath1 - Исправил" -ForegroundColor DarkGreen
    }
    $FilePath2  = "\\msk02appsfs01\UserDocuments$\$u\Application Data\1C\1CEStart\1CEStart.cfg"
    If ($FilePath2 -eq $True) {
    $ChangeKey=Get-Content $FilePath2 | ForEach-Object {$_ -replace '\\\\msk02web1c\\spisokbaz','\\dfs\files\SyncFiles\1C_Lists'} 
	Set-Content $FilePath $ChangeKey -Encoding Unicode
    Write-host "$FilePath2 - Исправил" -ForegroundColor Green
    }
}