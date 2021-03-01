#Перенос профилей - перемещаемых папок с сохранением атрибутов, используем robocopy
$as = (Get-ChildItem -Path \\msk02daascl02\Profile | Where-Object -FilterScript {($_.LastWriteTime -gt '2019-01-01') -and ($_.Name -notlike '*.V2')}).Name
foreach ($a in $as) {
    $c = "\\msk02daascl02\Profile\$a"
    $b = "\\msk02appsfs01\UserDocuments$\$a"
    robocopy $c $b /e /copyall /r:0 /dcopy:T
}