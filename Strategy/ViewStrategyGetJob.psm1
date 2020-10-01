using module ./Utility/EnumJobStateInfo.psm1
using module ./Factory/ViewGeneration.psm1

class ViewStrategyGetJob:ViewGeneration{

    ViewStrategyGetJob(){}

    #Override ExecuteJob
    [System.Collections.Specialized.OrderedDictionary]ExecuteJob([string]$ActionName, [string]$JobName, [string]$Id)
    {
        Write-Host "In the Methods [ExecuteJob] of the class [ViewStrategyGetJob] for the action : " $ActionName
        $JobFromGetJob = Get-Job
        $HashOfJobs = [ordered]@{}

        if($null -ne $JobFromGetJob -And $JobFromGetJob.Count -gt 0 -And $JobFromGetJob -is [System.Array])
        {
            for($i = 0; $i -le $JobFromGetJob.Count; $i++)
            {
                if(($JobFromGetJob[$i].State.ToLower() -eq ([EnumJobStateInfo]::Failed -as [string]).ToLower()) -Or
                ($JobFromGetJob[$i].State.ToLower() -eq ([EnumJobStateInfo]::Completed -as [string]).ToLower()))
                {
                    Get-Job -Name $JobFromGetJob[$i]
                    Write-Host $ActionName " As Action : " $JobFromGetJob[$i].Id.ToLower() + " - " + $JobFromGetJob[$i].Name.ToLower() + " - " + $JobFromGetJob[$i].Command.ToLower()
                }
            }
        }
        $HashOfJobs.add('Success', 1)
        return $HashOfJobs
    }
}