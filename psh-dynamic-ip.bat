$IPType = "IPv4"
# Change '? {$_.Status -eq "up"}' to Wi-Fi
$adapter = Get-NetAdapter | ? {$_.Name -eq "Wi-Fi"}
$interface = $adapter | Get-NetIPInterface -AddressFamily $IPType
$interface | Set-NetIPInterface -Dhcp Enabled
$interface | Set-DnsClientServerAddress -ResetServerAddresses
