#Set Security Rule 
   Param (
[string]$path01,
[string]$grname
)
        $acl = get-acl -Path "$path01"
            $Rule=new-object System.Security.AccessControl.FileSystemAccessRule ("$grname","Read","ContainerInherit", "None","Allow")
            $Rule3=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read","None", "None","Allow")
            $acl.AddAccessRule($Rule)
            $acl.AddAccessRule($Rule3)    
            Set-Acl -Path "$path01" -AclObject $acl
        $acl1 = get-acl -Path "$path01\IN"
            $Rule1=new-object System.Security.AccessControl.FileSystemAccessRule ("$grname","Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
            $acl1.AddAccessRule($Rule1)
            Set-Acl -Path "$path01\IN" -AclObject $acl1
        $acl2 = get-acl -Path "$path01\OUT"
            $Rule4=new-object System.Security.AccessControl.FileSystemAccessRule ("Softline\Domain Users","Read,Write,Modify","ContainerInherit,ObjectInherit", "InheritOnly","Allow")
            $acl2.AddAccessRule($Rule1)       
            $acl2.AddAccessRule($Rule3)
            $acl2.AddAccessRule($Rule4)
            Set-Acl -Path "$path01\OUT" -AclObject $acl2
        CACLS "$path01\IN" /E /R BUILTIN\Users
        CACLS "$path01\OUT" /E /R BUILTIN\Users
        CACLS "$path01" /E /R BUILTIN\Users