function findinarr ($array, $value) 
{
    for ($i=0; $i -lt $array.count;$i++) 
    {
        if($array[$i] -eq $value){$i}
    }
}
$a = 2,8,5,6,2,5,4,2,7
findinarr $a 2