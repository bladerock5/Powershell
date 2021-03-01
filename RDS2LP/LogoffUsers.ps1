$ldap = ([adsi]'LDAP://OU=OFFICES,DC=office,DC=softline,DC=ru','objectCategory=computer')
$searcher = new-object System.DirectoryServices.DirectorySearcher($ldap)
$searcher.filter = "(&(objectCategory=computer)(|(cn=*hostdaas*)(cn=*deskdaas*)))"
$computers = $searcher.findall()
$Servers = ($computers | foreach {$_.properties.name})

$user = "kokorkinamv"
Foreach ($server in $Servers) {

[array]$arr = QUERY USER $user /SERVER:$server
if ($arr -ne $null){  
        $id = [string]$arr[1] -match "\s\d+"|%{$matches[0]}
        $id
reset session $id /server:$server /v }
$arr = $null
}