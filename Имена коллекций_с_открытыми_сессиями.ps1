$a = (Get-RDSessionCollection).CollectionName #Имена коллекций с открытыми сессиями
foreach ($as in $a)
{
    $bs = (Get-RDSessionHost -CollectionName $as).SessionHost
    $bs
}
