$ips = Get-Content ./ips.txt
$ports = (1..1000)


foreach (${ip} in ${ips}) {
    $resultado = @{}
    foreach (${port} in ${ports}) {
        if (Test-Connection $ip -TcpPort $port) {
            #Write-Host($ip+":"+$port) -ForegroundColor Green
            $resultado[$port] = "Abierto"
        }else{
            #Write-Host($ip+":"+$port) -ForegroundColor Red
            $resultado[$port] = "Cerrado"

        }
    }
    $resultado.GetEnumerator() | Select-Object -Property @{N='Puerto';E={$_.Key}},@{N='Status';E={$_.Value}} | Export-Csv -Path /tmp/$ip.csv -Append -Encoding ASCII -NoTypeInformation -Delimiter ";" -Force 
}
