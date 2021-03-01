$username = "naumovav"
#Get-Item -Path "\\msk02appsfs01\UserDocuments$\*" | %{$_.Name}

foreach ($u in $username) {
    $FilePath1  = "\\msk02appsfs01\UserDocuments$\$u\AppData\Roaming\1C\1CEStart\1CEStart.cfg"
    $b1 = Test-Path $FilePath1
    If ($b1 -eq $true) {
    $ChangeKey=Get-Content $FilePath1 | ForEach-Object {$_ -replace '\\\\msk02web1c\\spisokbaz','\\dfs\files\SyncFiles\1C_Lists'} 
	Set-Content $FilePath $ChangeKey -Encoding Unicode
    $FilePath1
    }
    $FilePath2  = "\\msk02appsfs01\UserDocuments$\$u\Application Data\1C\1CEStart\1CEStart.cfg"
    $b2 = Test-Path $FilePath2
    If ($b2 -eq $true) {
    $ChangeKey=Get-Content $FilePath2 | ForEach-Object {$_ -replace '\\\\msk02web1c\\spisokbaz','\\dfs\files\SyncFiles\1C_Lists'} 
	Set-Content $FilePath $ChangeKey -Encoding Unicode
    $FilePath2
    }
}