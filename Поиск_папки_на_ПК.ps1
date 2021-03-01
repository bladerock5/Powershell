# Поиск по имени папки 111 на активных пк по АД ветке
$Comps = (Get-ADComputer -Filter  {(Enabled -eq "True")} -SearchBase "OU=_6700, OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name
foreach ($comp in $Comps)
{
	if (Test-Connection -Count 2 -ComputerName $comp -Quiet)
	    {
        Get-ChildItem -Path "\\$comp\c$\" -Recurse |
         %{
            if ($_.name -like "4410 Фото.docx") 
                { 
                    Write-Host "$comp"
                }
            }
        Get-ChildItem -Path "\\$comp\d$\" -Recurse |
         %{
            if ($_.name -like "4410 Фото.docx") 
                { 
                    Write-Host "$comp"
                }
            }
	    }
}