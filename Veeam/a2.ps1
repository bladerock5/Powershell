Add-PSSnapin VeeamPSSnapin
$Jobs = Get-VBRJob
$hostname = "$env:COMPUTERNAME"
$source = "C:\temp\123\$hostname.csv"
New-Item $source -ItemType File -Force
#Set-Content $source 'BackUpServer,JobName,JobTargetType,JobObject,JobDays,RestorePoints,BackupRepositoryName,LastBackup,NextBackup'

Foreach($Job in $Jobs)
{ 
    $JobName = $Job.Name
    $Objects = $Job.GetObjectsInJob()
    $VM = $Objects.Name
    $Day = $Job.ScheduleOptions.OptionsDaily.DaysSrv
    $Freq = $Job.ScheduleOptions.OptionsDaily.kind
        If($Freq -eq "Everyday")
            {
                $Day = "Everyday"
            }
    $JT = $Job.JobTargetType
    $RP = $Job.GetOptions().backupstorageoptions.retainCycles
        #Get Backup Repository Name
    $RepoTarget = $Job.FindTargetRepository()
    $e = $RepoTarget.Name
        #Get Next Last Backup
    $b = get-vbrjob -name $Job.Name | Get-VBRJobScheduleOptions
    $c = $b.LatestRunLocal
    $d = $b.NextRun
        if(!$d)
        {
        $d = 'No'
        }  
     $mass += @(
        "$hostname,$JobName,$JT,$VM,$Day,$RP,$e,$c,$d"
               )
}
$mass | foreach {Add-Content -Path  $source -Value $_}
$mass = $NULL

$distination = "\\msk02daascl.office.softline.ru\Profile\Scripts\Veeam\"

Copy-Item -Path $source -Destination $distination -Force