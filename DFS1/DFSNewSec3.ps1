#For Scan
    Param (
[string]$path09,
[string]$grname08
)
CACLS "$path09" /E /R BUILTIN\Users
$acl9 = get-acl -Path $path09
$acl9.SetAccessRuleProtection($true,$true)
Set-Acl -Path "$path09" -AclObject $acl9
CACLS "$path09" /E /R "Softline\Domain Users"
CACLS "$path09" /E /R "Softline\Sec.TestDFS.Public"
        
        $Rule1=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read","None", "None","Allow")
        $Rule2=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
        $Rule3=new-object System.Security.AccessControl.FileSystemAccessRule ($grname08,"Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
        $acl9.AddAccessRule($Rule1)
        $acl9.AddAccessRule($Rule2)
        $acl9.AddAccessRule($Rule3)
        Set-Acl -Path "$path09" -AclObject $acl9