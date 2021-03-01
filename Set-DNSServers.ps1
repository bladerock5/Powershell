[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$false,Position=1)]
    [string[]]$arrDNSServers,
    
    [Parameter(Mandatory=$false,Position=2)]
    [string]$strLogFilePath
)
$Error.Clear()
if ($arrDNSServers.Count -eq 0)
{
	$colDCs = ([System.DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite()).Servers | select -ExpandProperty name |`
	 Where-Object {$_.replace(($_.split('.')[0]+'.'),'') -eq (Get-WmiObject -Class win32_computersystem).Domain}

	foreach ($strDC in $colDCs)
	{
	    [string[]]$arrDNSServers +=(([net.dns]::GetHostAddresses($strDC) | select -Property IPAddressToString).IPAddressToString)
	}

	$arrDNSServers += '10.26.200.15'
	$arrDNSServers += '10.26.200.16'
	$arrDNSServers += '10.26.200.17'
}
$colAdapters = Get-WmiObject -Class win32_networkadapterconfiguration -Property * | Where-Object {$_.IPEnabled} | select -Property * 
foreach ($objAdapter in $colAdapters)
{
    (Get-WmiObject -Class win32_networkadapterconfiguration -Property * | Where-Object {$_.Index -eq $objAdapter.Index}).SetDNSServerSearchOrder($arrDNSServers) | Out-Null
}
if ($strLogFilePath)
{
    $strResult = $env:COMPUTERNAME + "`t`t" + (get-date).tostring()
	if ($Error.Count -gt 0)
	{
	    $strResult += "`t Completed with error: " + $Error[0].Exception
	}
	$strResult | Out-File -FilePath $strLogFilePath -Append
}