using module ./Rules/RuleInterface.psm1
using module ./Rules/DebugJobRule.psm1
using module ./Rules/FailedJobRule.psm1
using module ./Rules/GetJobRule.psm1
using module ./Rules/ReceivedJobRule.psm1
using module ./Rules/RemoveJobRule.psm1
using module ./Rules/ResumeJobRule.psm1
using module ./Rules/StartJobRule.psm1
using module ./Rules/StartJobByScriptBlockRule.psm1
using module ./Rules/StopJobRule.psm1 
using module ./Rules/SuspendJobRule.psm1
using module ./Rules/WaitJobRule.psm1
using module ./Factory/ViewGenerationFactory.psm1
using module ./Factory/ViewGeneration.psm1

class DispatcherJob{

    #Properties
    [System.Collections.Generic.List[RuleInterface]]$ExecutionRules
    [DebugJobRule]$DebugJobValidation
    [FailedJobRule]$FailedJobValidation
    [GetJobRule]$GetJobValidation
    [ReceivedJobRule]$ReceivedJobValidation
    [RemoveJobRule]$RemoveJobValidation
    [ResumeJobRule]$ResumeJobValidation
    [StartJobRule]$StartJobValidation
    [StopJobRule]$StopJobValidation
    [SuspendJobRule]$SuspendJobValidation
    [WaitJobRule]$WaitJobValidation
    [StartJobByScriptBlockRule]$StartJobByScriptBlockValidation

    #Constructor
    DispatcherJob()
    {
        $this.DebugJobValidation = [DebugJobRule]::new()
        $this.FailedJobValidation = [FailedJobRule]::new()
        $this.GetJobValidation = [GetJobRule]::new()
        $this.ReceivedJobValidation = [ReceivedJobRule]::new()
        $this.RemoveJobValidation = [RemoveJobRule]::new()
        $this.ResumeJobValidation = [ResumeJobRule]::new()
        $this.StartJobValidation = [StartJobRule]::new()
        $this.StartJobByScriptBlockValidation = [StartJobByScriptBlockRule]::new()
        $this.StopJobValidation = [StopJobRule]::new()
        $this.SuspendJobValidation = [SuspendJobRule]::new()
        $this.WaitJobValidation = [WaitJobRule]::new()
        
        $this.ExecutionRules.Add($this.DebugJobValidation)
        $this.ExecutionRules.Add($this.FailedJobValidation)
        $this.ExecutionRules.Add($this.GetJobValidation)
        $this.ExecutionRules.Add($this.ReceivedJobValidation)
        $this.ExecutionRules.Add($this.RemoveJobValidation)
        $this.ExecutionRules.Add($this.ResumeJobValidation)
        $this.ExecutionRules.Add($this.StartJobValidation)
        $this.ExecutionRules.Add($this.StartJobByScriptBlockValidation)
        $this.ExecutionRules.Add($this.StopJobValidation)
        $this.ExecutionRules.Add($this.SuspendJobValidation)
        $this.ExecutionRules.Add($this.WaitJobRule)        
    }

    #DispatchJob
    [System.Collections.Specialized.OrderedDictionary]DispatchJob([string]$JobName, [string]$Id)
    {
        if($null -eq $JobName){throw("[List of JobNames] is empty.")}
        [System.Collections.Specialized.OrderedDictionary]$ResultValidationRule = [System.Collections.Specialized.OrderedDictionary]::new()

        foreach($rule in $this.ExecutionRules)
        {
            $ResultValidationRule = $rule.ValidateExecutionRule($JobName, $Id)
            if($true -eq $ResultValidationRule.Validated){break}
        }
        [ViewGenerationFactory]$Factory = [ViewGenerationFactory]::new()
        [ViewGeneration]$Strategy = $Factory.GetViewGenerationFactory([string]$ResultValidationRule.JobToExecute)
        [System.Collections.Specialized.OrderedDictionary]$ResultStrategy = [System.Collections.Specialized.OrderedDictionary]::new()
        $ResultStrategy = $Strategy.ExecuteJob([string]$ResultValidationRule.JobToExecute,[string]$JobName, [string]$Id)

        return $ResultStrategy
    }
}