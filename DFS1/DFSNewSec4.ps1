#For Public
    Param (
[string]$path03,
[string]$grname03
) 
        $acl = get-acl -Path "$path03"
            $Rule1=new-object System.Security.AccessControl.FileSystemAccessRule ($grname03,"Read","None", "None","Allow")
            $Rule2=new-object System.Security.AccessControl.FileSystemAccessRule ($grname03,"Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
            $Rule3=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read","None", "None","Allow")
            $Rule4=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
            $acl.AddAccessRule($Rule1)
            $acl.AddAccessRule($Rule2)
            $acl.AddAccessRule($Rule3)
            $acl.AddAccessRule($Rule4)    
            Set-Acl -Path "$path03" -AclObject $acl
        CACLS "$path03" /E /R BUILTIN\Users