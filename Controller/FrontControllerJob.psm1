using module ./Controller/DispatcherJob.psm1 
using module ./Utility/EnumJob.psm1

class FrontControllerJob{

    #Properties
    [DispatcherJob]
    $DispatcherOfJobs

    #Constructor
    FrontControllerJob()
    {
        $this.DispatcherOfJobs = [DispatcherJob]::new()
    }

    #Validator - Make sure all the list of jobs available in the framework
    [Boolean]ValidateDispatcherJob([string]$JobName)
    {
        $IsValidated = $false
        If(([EnumJobToExecute]::DebugJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::FailedJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::GetJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::ReceivedJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::RemoveJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::ResumeJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::StartJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::StartJobByScriptBlock -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::StopJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::SuspendJob -as [string]).ToLower() -eq $JobName.ToLower() -Or
            ([EnumJobToExecute]::WaitJob -as [string]).ToLower() -eq $JobName.ToLower())
        {
            $IsValidated = $true
            return $IsValidated
        }
        return $IsValidated        
    }

    #Dispatch Jobs
    [System.Collections.Specialized.OrderedDictionary]DispatchJobsRequest([string]$JobName, [string]$Id)
    {
        if($null -eq $JobName){ throw "[JobName] parameter is empty in the Method : " -f  $MyInvocation.MyCommand }
        [Boolean]$CanProceed = $this.ValidateDispatcherJob([string]$JobName)
        if($false-eq $CanProceed){ throw "Dispatch cannot proceed in the Method : " -f $MyInvocation.MyCommand }

        [System.Collections.Specialized.OrderedDictionary]$Hashtable = [System.Collections.Specialized.OrderedDictionary]::new()
        $Hashtable = $this.DispatcherOfJobs.DispatchJob([string]$JobName, [string]$Id)
        return $Hashtable
    }
}