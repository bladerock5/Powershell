#Почта
$EmailFrom = “msk02daas01@domain.com”
$EmailTo = “notice.software@softliengroup.com”

$SmtpServer = “192.168.0.60”
#Лог 
$log = "$($env:WINDIR)\Logs\ErrorRDSH.log"
$curd = Get-Date -UFormat "%Y.%m.%d - %H:%M"
import-module NetTcpIP
#Поиск RDSH
#$v = Get-RDServer | Where-Object {$_.Roles -eq "RDS-RD-SERVER"} 
#$bs = $v.Server 
$bs = "msk02tdaas01.office.softline.ru"
foreach ($b in $bs) {
$c = (Test-NetConnection -ComputerName $b).PingSucceeded
        if ($c -eq "False") {
        Set-RDSessionHost -SessionHost $b -NewConnectionAllowed No -ConnectionBroker msk02daas01.office.softline.ru
        #Лог
    Add-Content -Path $log -Value "$curd --------------------------------------------"
    Add-Content -Path $log -Value "Stopping RDSH $b"
    Add-Content -Path $log -Value "No Ping"
    #Почта
    $Body = “Stopping RDSH $b `n`nNo Ping”
    $Subject = “RDSH $b NewConnection Disallowed”
    Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop
      }
      else {
$a = (Test-NetConnection -ComputerName $b -CommonTCPPort RDP).TcpTestSucceeded
       if ($a -eq "False") {
      Set-RDSessionHost -SessionHost $b -NewConnectionAllowed No -ConnectionBroker msk02daas01.office.softline.ru
      #Лог
    Add-Content -Path $log -Value "$curd --------------------------------------------"
    Add-Content -Path $log -Value "Stopping RDSH $b"
    Add-Content -Path $log -Value "No Ping, No RPD connect"
    #Почта
    $Body = “Stopping RDSH $b `n`nNo Ping, No RPD connect”
    $Subject = “RDSH $b NewConnection Disallowed”
    Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop
         }
#         else {
#         Set-RDSessionHost -SessionHost $b -NewConnectionAllowed Yes -ConnectionBroker msk02daas01.office.softline.ru
#         #Лог
#            Add-Content -Path $log -Value "$curd --------------------------------------------"
#            Add-Content -Path $log -Value "Start RDSH $b"
#            Add-Content -Path $log -Value "Yes Ping, Yes RPD connect"
#            #Почта
#    $Body = “Start RDSH $b Yes Ping, Yes RPD connect”
#    Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop
#         }
       }
    }