#Расшаренные папки DFS
(Get-DfsnFolder -Path "\\office.softline.ru\FILES\*").Path > C:\temp\12345.txt
$as = gc "c:\temp\12345.txt"
foreach ($a in $as){
    (Get-DfsnFolderTarget -Path $a).TargetPath >> C:\temp\54321.txt
}