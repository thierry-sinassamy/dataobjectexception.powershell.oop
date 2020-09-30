using module ./Rules/RuleInterface.psm1
using module ./Utility/EnumJob.psm1

class SuspendJobRule:RuleInterface{

    SuspendJobRule(){}

    [System.Collections.Specialized.OrderedDictionary]ValidateExecutionRule([string]$JobName, [string]$Id){

        if($null -eq $JobName){return $null}
        if(([EnumJobToExecute]::SuspendJob -as [string]).ToLower() -eq $JobName.ToLower())
        {
            $ResultValidationRule = [ordered]@{
                                        JobName = $Jobname;
                                        Validated = $true;
                                        JobToExecute = (([EnumJobToExecute]::SuspendJob -as [string]).ToLower()).ToLower();
                                        Id = $Id
                                    }
            return $ResultValidationRule
        }
        return $null
    }
}