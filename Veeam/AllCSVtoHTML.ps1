$a = "\\msk02daascl\Profile\Scripts\Veeam\*.csv"
$filea = gc $a
$cm = "\\msk02daascl\Profile\Scripts\Veeam\combined.csv"
$ch = "C:\inetpub\wwwroot\combined.html"
New-Item $cm -ItemType File -Force
Set-Content $cm 'BackUpServer,JobName,JobTargetType,JobObject,JobDays,RestorePoints,BackupRepositoryName,LastBackup,NextBackup'
$filea | foreach {Add-Content -Path $cm -Value $_}
import-csv $cm | convertTo-HTML | Out-File $ch