$user="$env:USERNAME"
$as = get-content C:\temp\1.txt
foreach ($a in $as) 
{
    switch -regex (qwinsta /server:$a) 
    {
        "[^\s]+\s+([^\s]+)\s+([\d]+)" 
        {
            if ($matches[1] -eq $user) 
                {
                    logoff $matches[2] /server:$a
                }
        }
    }
}