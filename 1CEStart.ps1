New-Item -Path ‘C:\ProgramData\1C\1CEStart\1CEStart.cfg’ -ItemType "file" -Force
$file = "c:\temp\test1C.txt"
Add-Content -Path $file -Value "CommonInfoBases=\\msk02web1c\spisokbaz\Softline\SL Moscow.v8i
CommonInfoBases=\\msk02web1c\spisokbaz\Softline\Education.v8i
CommonInfoBases=\\msk02web1c\spisokbaz\HelpDesk.v8i
CommonInfoBases=\\msk02web1c\spisokbaz\УРВ.v8i
CommonInfoBases=\\msk02web1c\spisokbaz\Softline\Axoft.v8i
CommonInfoBases=\\msk02web1c\spisokbaz\Softline\Стримлайн.v8i
UseHWLicenses=1" -Encoding Unicode