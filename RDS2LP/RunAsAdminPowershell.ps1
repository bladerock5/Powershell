$user = "softline\naumov2"
$password = Get-Content C:\temp\passfile.txt | ConvertTo-SecureString
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
$args = "C:\temp\CloseOpenFiles.ps1"
Start-Process powershell.exe -Credential $credentials -ArgumentList ("-file $args")