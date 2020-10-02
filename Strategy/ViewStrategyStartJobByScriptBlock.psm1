using module ./Utility/EnumJobStateInfo.psm1
using module ./Factory/ViewGeneration.psm1

class ViewStrategyStartJobByScriptBlock:ViewGeneration{

    ViewStrategyStartJobByScriptBlock(){}

    #Override ExecuteJob
    [System.Collections.Specialized.OrderedDictionary]ExecuteJob([string]$ActionName, [string]$JobName, [string]$Id)
    {    
        Write-Host "In the Methods [ExecuteJob] of the class [ViewStrategyStartJobByScriptBlock] for the action : " $ActionName
        $parameter1 = ""
        $parameter2 = ""
        $HashOfJobs = [ordered]@{}
        $ScriptPath = split-path $MyInvocation.MyCommand.Path
        Write-Host $ScriptPath

        #Use the parameter [$Id] to get the complete of the path related to the job to trigger in background
        $FilePath = Get-ChildItem $ScriptPath -Recurse | Where-Object {$_.Name -eq $Id+".ps1"}
        Write-Host $FilePath

        if($null -eq $FilePath)
        {
            throw "[Id] parameter is empty in the Method : " -f  $MyInvocation.MyCommand 
        }

        #Use the parameter $Id to get the filename of the ps1 file to execute in background as a background job
        $ScriptText = Get-Content -Raw -Encoding Default -Path $FilePath.FullName;
        $ScriptBlock = [scriptblock]::Create($ScriptText);
        Start-Job -Name $JobName -ScriptBlock $ScriptBlock -ArgumentList $parameter1, $parameter2 #etc.

        Write-Host $ActionName " As Action with : " $JobName.ToLower() + " - " + $Id.ToLower()

        $HashOfJobs.add('Success', 1)
        return $HashOfJobs
    }
}