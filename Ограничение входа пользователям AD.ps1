#Ограничение времени входа пользователям с пн-пт с 7-00 до 23-00 и в сб с 7-00 до 18-00, в заданном ДО
$a = (Get-ADUser -Filter *  -SearchBase 'OU=Users,OU=_6754,OU=6700,OU=RF,DC=rf,DC=rshbank,DC=ru').SamAccountName
foreach ($A in $a) {
# create a byte array for the M-F 8:00 am to 5 pm logon hours
# 1=1,2=2,3=4,4=8,5=16,6=32,7=64,8=128 (час в блоке = значение)
$hours = New-Object byte[] 21 
$hours[1] = 0; $hours[2] = 0; $hours[3] = 240;
$hours[4] = 255; $hours[5] = 15; $hours[6] = 240;
$hours[7] = 255; $hours[8] = 15; $hours[9] = 240; 
$hours[10] = 255; $hours[11] = 15; $hours[12] = 240;
$hours[13] = 255; $hours[14] = 15; $hours[15] = 240;
$hours[16] = 255; $hours[17] = 15; $hours[18] = 240;
$hours[19] = 127; $hours[20] = 0; $hours[0] = 0;

# create a hashtable to update the logon hours and a description 
$replaceHashTable = New-Object HashTable 
$replaceHashTable.Add("logonHours", $hours) 
#$replaceHashTable.Add("description", "Sarah Davis can only logon from Monday through Friday from 8:00 AM to 5:00 PM") 
 
# set the value of the logonHours and description attributes 
Set-ADUser "$A" -Replace $replaceHashTable 
} 
