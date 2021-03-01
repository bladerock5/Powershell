 #$server="192.168.0.28"
$EmailFrom = “msk02daas01@domain.com”
$EmailTo = “notice.software@softliengroup.com”
$Subject = “Check service Test”
$Body = “Monitoring service Test!!”
$SmtpServer = “192.168.0.60”
Send-MailMessage -From $EmailFrom -to $EmailTo -Subject $Subject -Body $Body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $SmtpServer -erroraction Stop