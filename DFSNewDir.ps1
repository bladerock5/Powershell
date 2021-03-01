#Рабочий скрипт
$dname0 = "Kazan"
New-Item -Path $pname -Name $dname0 -ItemType Directory
$dname = @("Education", "HR", "IMS", "Management", "Marketing", "Office", "Public", "Softline", "study")
$pname = "\\KZN01IT01\C$\tmp\"
    foreach ($dnam in $dname){
        New-Item -Path "$pname$dname0" -Name $dnam -ItemType Directory
    }
function NewINOUT ($pname){
    New-Item -Path $pname -Name "IN" -ItemType Directory
    New-Item -Path $pname -Name "OUT" -ItemType Directory
}
NewINOUT ("$pname$dname0\Education")
NewINOUT ("$pname$dname0\HR")
NewINOUT ("$pname$dname0\IMS")
NewINOUT ("$pname$dname0\Management")
NewINOUT ("$pname$dname0\Marketing")
NewINOUT ("$pname$dname0\Office")
NewINOUT ("$pname$dname0\Softline")