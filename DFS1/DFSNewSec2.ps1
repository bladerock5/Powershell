#For Study
    Param (
[string]$path02,
[string]$grname02
)    
$acl3 = get-acl -Path $path02
    $Rule5=new-object System.Security.AccessControl.FileSystemAccessRule ("$grname02","Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
    $acl3.AddAccessRule($Rule5)
    Set-Acl -Path "$path02" -AclObject $acl3    
CACLS "$path02" /E /R BUILTIN\Users    