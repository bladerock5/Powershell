﻿Get-ADUser -Filter * -SearchBase "OU=6700, OU=RF, DC=RF, DC=RSHBANK, DC=RU" -Properties * | sort Name | Select-Object EmployeeID, Name, Description, EmailAddress, SamAccountName | Format-Table -AutoSize > c:\temp\111.txt