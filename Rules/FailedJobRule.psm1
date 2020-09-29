using module ./Rules/RuleInterface.psm1
using module ./Utility/EnumJob.psm1

class FailedJobRule:RuleInterface{

    FailedJobRule(){}

    [System.Collections.Specialized.OrderedDictionary]ValidateExecutionRule([string]$JobName, [string]$Id){

        if($null -eq $JobName){return $null}
        if(([EnumJobToExecute]::FailedJob -as [string]).ToLower() -eq $JobName.ToLower())
        {
            $ResultValidationRule = [ordered]@{
                                        JobName = $Jobname;
                                        Validated = $true;
                                        JobToExecute = (([EnumJobToExecute]::FailedJob -as [string]).ToLower()).ToLower();
                                        Id = $Id
                                    }
            return $ResultValidationRule
        }
        return $null
    }
}