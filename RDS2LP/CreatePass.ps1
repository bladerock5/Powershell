
$Cred = Get-Credential
$Cred
$Cred.Password| ConvertFrom-SecureString | Set-Content c:\temp\passfile.txt