$name = (Get-WmiObject win32_product -ComputerName W6711-KASS00004).Name
$names = "DeviceLock Service"
if ($name -like $names)
{
Write-Host "Installed"
}
else
{
Write-Host "Not Installed"
}