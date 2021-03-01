#(Get-ADComputer -Filter {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name > c:\Temp\2\111.txt
gc 'c:\Temp\2\111.txt'|%
{
    if (Test-Connection $_ -Count 1 -Quiet)
        {
            Copy-Item -Path "c:\Temp\1\*" -Destination "\\$_\c$\Users\Public\Desktop\" -Force
        }
}