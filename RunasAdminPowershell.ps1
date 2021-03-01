$user = "domain\service.account" 
$pwd1 = "big long huge string of characters"
$pwd = ($pwd1 | ConvertTo-SecureString)
$Credential = New-Object System.Management.Automation.PSCredential $user, $pwd
$args = "\\domain.local\location\location\location\Script\script.ps1"
Start-Process powershell.exe -Credential $Credential -ArgumentList ("-file $args")