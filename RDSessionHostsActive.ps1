$EmailFrom = “msk02daas01@domain.com”
$EmailTo = “notice.software@softliengroup.com”
$Subject = “Attention!!!”
$SmtpServer = “192.168.0.60”
$bs = (Get-RDSessionHost -CollectionName soft).SessionHost 
$log = "$($env:WINDIR)\Logs\ErrorRDSH.log"
$curd = Get-Date -UFormat "%Y.%m.%d - %H:%M"
import-module NetTcpIP
foreach ($b in $bs) {
$c = (Test-NetConnection -ComputerName $b).PingSucceeded
        if ($c -eq "False") {
        Set-RDSessionHost -SessionHost $b -NewConnectionAllowed No -ConnectionBroker "msk02daas01.office.softline.ru"
    Add-Content -Path $log -Value "$curd --------------------------------------------"
    Add-Content -Path $log -Value "Stopping RDSH $b"
    Add-Content -Path $log -Value "No Ping"
    $Body = “Stopping RDSH $b No Ping”
    Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop
      }
      else {
$a = (Test-NetConnection -ComputerName $b -CommonTCPPort RDP).TcpTestSucceeded
       if ($a -eq "False") {
      Set-RDSessionHost -SessionHost $b -NewConnectionAllowed No -ConnectionBroker "msk02daas01.office.softline.ru"
    Add-Content -Path $log -Value "$curd --------------------------------------------"
    Add-Content -Path $log -Value "Stopping RDSH $b"
    Add-Content -Path $log -Value "No Ping, No RPD connect"
    $Body = “Stopping RDSH $b No Ping, No RPD connect”
    Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop
         }
       }
    } 