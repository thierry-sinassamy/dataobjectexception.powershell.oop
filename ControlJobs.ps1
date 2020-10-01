using module ./ControlJobs.psm1

param(
    [Parameter(Mandatory=$true)]
    [string]$JobProcess,
    [Parameter(Mandatory=$true)]
    [string]$JobName,
    [Parameter(Mandatory=$true)]
    [string]$IdJob
)

$ControlJobs = InstanciateControlJobs -JobProcess $JobProcess -JobName $JobName -Id $IdJob
Write-Output $ControlJobs
Write-Host "Starting the process : " (Get-Date -Format "dddd MM/dd/yyyy HH:mm K")
$ResultProcess = $ControlJobs.ProcessJobName()
Write-Host "From the caller [ControlsJobs] : " $ResultProcess 
Write-Host "End of the process : " (Get-Date -Format "dddd MM/dd/yyyy HH:mm K")