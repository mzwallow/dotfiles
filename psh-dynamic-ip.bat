$IPType = "IPv4"
# Change '? {$_.Status -eq "up"}' to Wi-Fi
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
$interface = $adapter | Get-NetIPInterface -AddressFamily $IPType
$interface | Set-NetIPInterface -InterfaceAlias $adapter -Dhcp Enabled
$interface | Set-DnsClientServerAddress -ResetServerAddresses
