#В профилях пользователей добавляем ACL для папки Flavers
$ChildPath = @()
$ChildPath = (Get-Childitem -Path \\msk02daascl02\Profile).Name
foreach ($Child in $ChildPath){
    if ($Child -like "*.*"){
        continue
    }
    else{
            $PathFavorite = '\\msk02daascl02\Profile\' + $Child + '\Favorites'
            if((Test-Path $PathFavorite) -eq "True"){
            $PathFavorite
            $acl = Get-Acl $PathFavorite
            $Rule = new-object System.Security.AccessControl.FileSystemAccessRule ("softline\Servers Admins MSK02", "FullControl", "Allow") #Для папки
            $Rule2 = new-object System.Security.AccessControl.FileSystemAccessRule ("softline\Servers Admins MSK02","FullControl","ContainerInherit,ObjectInherit", "InheritOnly","Allow") #Для вложенных папок и файлов
            $acl.AddAccessRule($Rule)
            $acl.AddAccessRule($Rule2)
            $acl | Set-Acl $PathFavorite
            }
    }
}