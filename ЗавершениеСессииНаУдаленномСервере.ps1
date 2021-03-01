$server="msk23hostdaas04"
$user="naumov2"
switch -regex (qwinsta /server:$server) 
{
    "[^\s]+\s+([^\s]+)\s+([\d]+)" 
    {
        if ($matches[1] -eq $user) 
        {
            logoff $matches[2] /server:$server
        }
    }
}