$Trace = Trace-Script{
$bigFileName = "plc_log.txt"
$plcNames = 'PLC_A','PLC_B','PLC_C','PLC_D'
$errorTypes = @(
    'Sandextrator overload',
    'Conveyor misalignment',
    'Valve stuck',
    'Temperature warning'
)
$statusCodes = 'OK','WARN','ERR'

$Random = [Random]::new()

$logLines = foreach($i in 0..49999) {
    $timestamp = ([datetime]::Now).AddSeconds($i).ToString("yyyy-MM-dd HH:mm:ss")
    $plc = $plcNames[$Random.Next(0,$plcNames.Count-1)]
    $operator = $Random.Next(101,121)
    $batch = $Random.Next(1000,1101)
    $status = $statusCodes[$Random.Next(0,$statusCodes.Count-1)]
    $machineTemp = [math]::Round(($Random.Next(60,110)) + ($Random.Next()),2)
    $load = $Random.Next(0,101)
 
    if ($Random.Next(1,8) -eq 4) {
        $errorType = $errorTypes[$Random.Next(0,$errorTypes.Count-1)]
        if ($errorType -eq 'Sandextrator overload') {
            "ERROR; $timestamp; $plc; $errorType; $($Random.Next(1,11)); $status; $operator; $batch; $machineTemp; $load"
        } else {
            "ERROR; $timestamp; $plc; $errorType; ; $status; $operator; $batch; $machineTemp; $load"
        }
    } else {
        "INFO; $timestamp; $plc; System running normally; ; $status; $operator; $batch; $machineTemp; $load"
    }

}
 
Set-Content -Path $bigFileName -Value $logLines
Write-Output "PLC log file generated."
}