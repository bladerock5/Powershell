$dists = '6700-SG-GPF-DL_FL_SHADOW_COPY', '6700-SG-GPF-DL_PRN_SHADOW_COPY'
$sources = '6700-sg-org-ur', '6700-sg-org-oaommb', 
'6700-sg-org-orkmmb', '6700-sg-org-rasch', 
'6700-sg-org-kass', '6700-sg-org-dolgi', 
'6700-sg-org-oper', '6700-sg-org-contr', 
'6700-sg-org-buh', '6700-sg-org-orksb', 
'6700-sg-org-gaokb', '6700-sg-org-orkkb'
foreach ($dist in $dists)
{
    foreach ($source in $sources)
    { 
    Get-ADGroup $source | Get-ADGroupMember | ForEach-Object 
        {
         Add-ADGroupMember $dist $_ 
        } 
    }
}