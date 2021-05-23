$syslogServer = "192.168.43.10"
$syslogPort = "514"

function Get-TimeStamp {
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
}

$syslogMessage = "$(Get-TimeStamp) WRITE SYSLOG MESSAGE HERE"

# tcp connection
$tcpConnection = New-Object System.Net.Sockets.TcpClient($syslogServer, $syslogPort)
$tcpStream = $tcpConnection.GetStream()

# write message
$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true
if ($tcpConnection.Connected)
{
    $writer.WriteLine($syslogMessage) | Out-Null
}

# close the session
$writer.Close()
$tcpConnection.Close()
