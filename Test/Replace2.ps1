$username = Get-Item -Path "\\msk02appsfs01\UserDocuments$\*" | %{$_.Name}

foreach ($u in $username) {
    $FilePath  = "\\msk02appsfs01\UserDocuments$\$u\Application Data\1C\1CEStart\1CEStart.cfg"
    $ChangeKey=Get-Content $FilePath | ForEach-Object {$_ -replace '\\\\msk02web1c\\spisokbaz','\\dfs\files\SyncFiles\1C_Lists'} 
	Set-Content $FilePath $ChangeKey -Encoding Unicode
}