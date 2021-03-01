$proc = "bispc.exe"
$Comps = (Get-ADComputer -Filter  {(Enabled -eq "True")} -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU").Name
foreach ($comp in $Comps)
{
	if (Test-Connection -Count 2 -ComputerName $comp -Quiet)
	{
			$ps = Get-WmiObject Win32_Process -Filter "Name='$proc'" -ComputerName $comp
			foreach ($i in $ps)
		{
			$result = $i.Terminate()
			Copy-Item -Path "e:\bispc\*" -Destination "\\$comp\c$\Program Files\BIS\BisPC" -Force
			if ($result.ReturnValue -eq 0) 
				{
				 "Success $comp"
				}
			else 
				{
					"Error $comp"
				}
		}
	}
}
