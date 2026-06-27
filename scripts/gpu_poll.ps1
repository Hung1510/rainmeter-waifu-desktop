# gpu_poll.ps1 -> writes one CSV line of GPU stats next to the skin every 2s.
# Fields: temperature.gpu(C), utilization.gpu(%), memory.used(MB), memory.total(MB)
# nvidia-smi ships with the NVIDIA driver -> no extra app to install.
#
# Run it hidden at logon via Task Scheduler (you already use Task Scheduler):
#   Action: powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "D:\...\gpu_poll.ps1"
#   Trigger: At log on
#
# Adjust $Target if your skin lives elsewhere.

$Target = "$env:USERPROFILE\Documents\Rainmeter\Skins\ShorekeeperDesktop\@Resources\gpu.txt"

while ($true) {
    try {
        $line = & nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits 2>$null
        if ($line) {
            Set-Content -Path $Target -Value ($line | Select-Object -First 1).Trim() -Encoding ASCII
        }
    } catch { }
    Start-Sleep -Seconds 2
}
