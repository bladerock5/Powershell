$C = (Get-ADGroupMember 6700-SG-Inet-Kass).SamAccountName 
foreach ($c in $C)
    {
        (Get-ADGroupMember $C).SamAccountName
    }