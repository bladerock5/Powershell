
#проверяет доступность хоста который входит в RDSH и отключает его если он не пингуется
(Get-RDSessionHost -CollectionName soft).SessionHost | %
{
  if (Test-Connection $_ -Count 1 -Quiet)
    { 
      if (test-connection -computername $_ -Quiet) 
        {
          Set-RDSessionHost -SessionHost $_ -NewConnectionAllowed $False #-ConnectionBroker "rdcb.contoso.com"
          Write-host $_
        }
    }
}