#New folder and group for DFS
Import-Module activedirectory
$NameServer = "TestDFS" #File server Name
New-ADOrganizationalUnit -Name "$NameServer" -Path "OU=HOSTSHARE,OU=GROUPS,DC=office,DC=softline,DC=ru" -ProtectedFromAccidentalDeletion $False
$names = @("Education","HR","IMS","Management","Marketing","Office","Public","Softline","Study") #Folder list
foreach ($name in $names){
    New-ADGroup -Name "Sec.$NameServer.$name" -SamAccountName Sec.$NameServer.$name -GroupCategory Security -GroupScope DomainLocal -Path "OU=$NameServer,OU=HOSTSHARE,OU=GROUPS,DC=office,DC=softline,DC=ru" -Description "Access to the folder :\\dfs\files\Softline\$NameServer\$name"
}