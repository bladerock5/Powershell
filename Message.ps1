$from = "Andrey.Naumov@softlinegroup.com"
$to = (([adsisearcher]"(&(objectClass=person)(objectClass=user)(SamAccountName=$env:username))").FindAll().properties).mail
$message = New-Object System.Net.Mail.MailMessage $from, $to
$message.Subject = $subject
$message.IsBodyHTML = $true
$message.Body = $TextMail
$TextMail = "Test mail"
$serverSMTP = "192.168.0.28"
$smtp = new-object Net.Mail.SmtpClient($serverSMTP)
$smtp.Send($message) 