$FTPServer = "192.168.43.10"
$FTPPort = "515"

$tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort)
$tcpStream = $tcpConnection.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true

while ($tcpConnection.Connected)
{
    while ($tcpStream.DataAvailable)
    {
        $reader.ReadLine()
    }

    if ($tcpConnection.Connected)
    {
        Write-Host -NoNewline "test string"
        $command = Read-Host

        if ($command -eq "escape")
        {
            break
        }

        $writer.WriteLine($command) | Out-Null
    }
}

$reader.Close()
$writer.Close()
$tcpConnection.Close()