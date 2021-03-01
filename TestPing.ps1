$servers = "msk02mail20","msk02dag03"
#Лог
$log = "c:\install\ErrorPING.log"
$curd = Get-Date -UFormat "%Y.%m.%d - %H:%M"

Foreach($s in $servers) {

if(!(Test-Connection -Cn $s -BufferSize 16 -Count 1 -ea 0 -quiet))

  {        
  #Лог
    Add-Content -Path $log -Value "$curd --------------------------------------------"
    Add-Content -Path $log -Value "Problem connecting to $s"
    Add-Content -Path $log -Value "No Ping"

        }
    }