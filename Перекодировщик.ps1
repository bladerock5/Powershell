Get-Childitem d:\1\*.csv -File |
 foreach 
    {
        $a=Get-Item $_ ; $b="d:\2\"+$a.Name ; Get-Content $a |
        Out-File -Encoding OEM -FilePath $b
    }