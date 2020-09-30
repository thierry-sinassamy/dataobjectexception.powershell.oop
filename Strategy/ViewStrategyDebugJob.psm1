using module ./Factory/ViewGeneration.psm1
using module ./Utility/EnumJobStateInfo.psm1

class ViewStrategyDebugJob:ViewGeneration{

    ViewStrategyDebugJob(){}

    #Override ExecuteJob
    [System.Collections.Specialized.OrderedDictionary]ExecuteJob([string]$JobName, [string]$Id){
        
        Write-Host "In the Methods [ExecuteJob] of the class [ViewStrategyGetJob] for the action [GetJob]."
        $JobFromGetJob = Get-Job
        $HashOfJobs = [ordered]@{}

        if($null -ne $JobFromGetJob -And $JobFromGetJob.Count -gt 0 -And $JobFromGetJob -is [System.Array])
        {
            for($i = 0; $i -le $JobFromGetJob.Count; $i++)
            {
                if(($JobFromGetJob[$i].State.ToLower() -eq ([EnumJobStateInfo]::Running -as [string]).ToLower()))
                {
                    Debug-Job -Id $JobFromGetJob[$i].Id
                    Write-Host "[Get-Job] : " $JobFromGetJob[$i].Id.ToLower() + " - " + $JobFromGetJob[$i].Name.ToLower() + " - " + $JobFromGetJob[$i].Command.ToLower()
                }
            }
        }
        $HashOfJobs.add('Success', 1)
        return $HashOfJobs
    }
}