using module ./Utility/EnumJobStatus.psm1
using module ./Controller/FrontControllerJob.psm1

class ControlJobs{

    #Properties
    [string]$JobToProcess
    [string]$Id
    [string]$JobName

    ControlJobs([string]$JobToProcess, [string]$JobName, [string]$Id)
    {
        $this.JobToProcess = $JobToProcess
        $this.JobName = $JobName
        $this.Id = $Id
    }

    [string]ProcessJobName()
    {
        [string]$MessageToCaller = ""
        try {
            Write-Host "Method " -f $MyInvocation.MyCommand " of the class [ControlJobs] is started !"
            [System.Collections.Specialized.OrderedDictionary]$Hashtable = [System.Collections.Specialized.OrderedDictionary]::new()
            [FrontControllerJob]$FrontController = [FrontControllerJob]::new()
            $Hashtable = $FrontController.DispatchJobsRequest($this.JobToProcess, $this.JobName, $this.Id)

            if($null -eq $Hashtable){
                $MessageToCaller = ([EnumJobStatusAfterExecution]::ExecutionFailedStatus -as [string]).ToLower()
            }
            Write-Host "Method " -f $MyInvocation.MyCommand " of the class [ControlJobs] is over  : " ([EnumJobStatusAfterExecution]::ExecutionCompletedStatus -as [string]).ToLower()
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Host $ErrorMessage
            $MessageToCaller = ([EnumJobStatusAfterExecution]::ExecutionFailedStatus -as [string]).ToLower()
        }
        finally{
            $MessageToCaller = ([EnumJobStatusAfterExecution]::ExecutionSucceededStatus -as [string]).ToLower()
        }
        return $MessageToCaller
    }
}

function InstanciateControlJobs{
    param($JobProcess, $Jobname, $Id)
    return [ControlJobs]::new([string]$JobToProcess, [string]$JobName, [string]$Id)
}
Export-ModuleMember -Function InstanciateControlJobs
