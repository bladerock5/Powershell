$a = Get-ChildItem -Path \\msk02daascl02\Profile | Where-Object -FilterScript {($_.LastWriteTime -gt '2020-01-01') -and ($_.Name -notlike '*.V2')}
$b = "\\msk02appsfs01\userdocuments$\"
robocopy $a $b /e /copyall /r:0 /dcopy:T