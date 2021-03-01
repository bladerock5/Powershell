function VSS1 {
    $HDDs = GET-WMIOBJECT –query "SELECT * from win32_logicaldisk where DriveType = 3"
    foreach ($HDD in $HDDs) {
        $Drive = $HDD.DeviceID
        $vssadminEnable ="vssadmin add shadowstorage /For=$Drive /On=$Drive /MaxSize=10%"
        $vsscreatess = "vssadmin create shadow /for=$Drive"
        cmd /c  $vssadminEnable
        cmd /c  $vsscreatess
    }
}
$as = Get-Content "C:\temp\111.txt" 
foreach ($a in $as){
    $a
    Invoke-Command -ComputerName $a -ScriptBlock ${function:VSS1}
}