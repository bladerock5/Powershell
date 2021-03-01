$Template_Excel = "C:\temp\Шаблон.xlsx"
$SaveAs = "C:\temp\ЗаполненыйШаблон.xlsx"
$AllExcel = @(Get-Process [e]xcel | %{$_.Id})
$MyExcel = New-Object -ComObject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | Where {$AllExcel -notcontains $_} 
$MyExcel.Visible = $False
$WorkBook = $MyExcel.workbooks.open($Template_Excel)
$WorkSheet = $WorkBook.sheets.item("Шаблон")
$Users = Get-ADUser -Filter * -SearchBase "OU=IMS,OU=ACCOUNTS,OU=KZN01,OU=REGIONS RUSSIA,OU=OFFICES,DC=office,DC=softline,DC=ru" -Server msk02dc06 -Properties displayName, 
description, physicalDeliveryOfficeName, telephoneNumber, mail, title, department, company, manager |
Select sAMAccountName, displayName, description, physicalDeliveryOfficeName, telephoneNumber, mail, title, department, company, manager
For($x = 0; $x -le $Users.count; $x++)
{
    $WorkSheet.Rows.Item($x+2).Columns.Item(1) = $Users[$x].displayName
    $WorkSheet.Rows.Item($x+2).Columns.Item(2) = $Users[$x].description
    $WorkSheet.Rows.Item($x+2).Columns.Item(3) = $Users[$x].physicalDeliveryOfficeName
    $WorkSheet.Rows.Item($x+2).Columns.Item(4) = $Users[$x].telephoneNumber
    $WorkSheet.Rows.Item($x+2).Columns.Item(5) = $Users[$x].mail
    $WorkSheet.Rows.Item($x+2).Columns.Item(6) = $Users[$x].title
    $WorkSheet.Rows.Item($x+2).Columns.Item(7) = $Users[$x].department
    $WorkSheet.Rows.Item($x+2).Columns.Item(8) = $Users[$x].company
    $WorkSheet.Rows.Item($x+2).Columns.Item(9)= $Users[$x].manager
}

$Workbook.SaveAs($SaveAs)
$MyExcel.quit()
Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue