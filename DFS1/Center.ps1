#Run Scripts
$fs = "TestDFS"
.\DFSADNewOUGroup.ps1 -NameServer $fs

$pathserver = "C:\tmp\"
$directoryname = "Kazan"
.\DFSNewDir.ps1 -dname0 $directoryname -pname $pathserver

$arr = @(
@("C:\tmp\Kazan\HR","softline\Sec.TestDFS.HR","TestDFS_HR$"),
@("C:\tmp\Kazan\Education","softline\Sec.TestDFS.Education","TestDFS_Education$"),
@("C:\tmp\Kazan\IMS","softline\Sec.TestDFS.IMS","TestDFS_IMS$"),
@("C:\tmp\Kazan\Management","softline\Sec.TestDFS.Management","TestDFS_Management$"),
@("C:\tmp\Kazan\Marketing","softline\Sec.TestDFS.Marketing","TestDFS_Marketing$"),
@("C:\tmp\Kazan\Office","softline\Sec.TestDFS.Office","TestDFS_Office$"),
@("C:\tmp\Kazan\Public","softline\Sec.TestDFS.Public","TestDFS_Public$"),
@("C:\tmp\Kazan\Softline","softline\Sec.TestDFS.Softline","TestDFS_Softline$"),
@("C:\tmp\Kazan\study","softline\Sec.TestDFS.study","TestDFS_study$")
)
foreach ($ar in $arr){
    $path0A = $ar[0]
    $grnameA = $ar[1]
    $shnameA = $ar[2]
    .\DFSNewShareDir.ps1 -shname $shnameA -path01 $path0A -grname $grnameA
}

.\DFSNewSec.ps1 -path01 $arr[0][0] -grname $arr[0][1]
.\DFSNewSec.ps1 -path01 $arr[1][0] -grname $arr[1][1]
.\DFSNewSec.ps1 -path01 $arr[2][0] -grname $arr[2][1]
.\DFSNewSec.ps1 -path01 $arr[3][0] -grname $arr[3][1]
.\DFSNewSec.ps1 -path01 $arr[4][0] -grname $arr[4][1]
.\DFSNewSec.ps1 -path01 $arr[5][0] -grname $arr[5][1]
.\DFSNewSec.ps1 -path01 $arr[7][0] -grname $arr[7][1]

.\DFSNewSec2.ps1 -path02 $arr[8][0] -grname02 $arr[8][1]

.\DFSNewSec4.ps1 -path03 $arr[6][0] -grname03 $arr[6][1]

$grname01 = "softline\scanlan"
.\DFSNewSec3.ps1 -path09 "C:\tmp\Kazan\Public\Scan" -grname08 $grname01