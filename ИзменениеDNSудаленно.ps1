# Set DNS remote
$as="kzn01vsbkp01"
Invoke-Command -ComputerName $as -ScriptBlock {
$NetAdapter = Get-NetAdapter -Name 'Ethernet*'
$NetAdapter | Set-DnsClientServerAddress -ServerAddresses 10.2.2.2,10.2.2.3
}