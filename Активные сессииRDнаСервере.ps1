$i=0
$b = "msk02hostdaas22"
(get-terminalsession -computername $b).State |% 
{ 
 if ($_ -eq "Active") 
    {
        $i++
    }
}
Write-Host $i