#функция довольно крутая и быстро вычисляет размер папки, но она не всегда работает (особенно когда есть проблема с разрешением или слишком длинный путь к папке)
Function sizeFolder($path) # Return the size in MB.
{
    $objFSO = New-Object -com  Scripting.FileSystemObject
    ("{0:N2}" -f (($objFSO.GetFolder($path).Size) / 1MB))
}
$a = "\\msk02vsork01\G$\DaasProfileOLDBackup\"
sizeFolder($a)