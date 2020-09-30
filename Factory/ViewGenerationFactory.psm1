using module ./Factory/ViewGeneration.psm1
using module ./Utility/EnumJob.psm1
using module ./Strategy/ViewStrategyDebugJob.psm1
using module ./Strategy/ViewStrategyFailedJob.psm1
using module ./Strategy/ViewStrategyGetJob.psm1
using module ./Strategy/ViewStrategyReceivedJob.psm1
using module ./Strategy/ViewStrategyRemoveJob.psm1
using module ./Strategy/ViewStrategyResumeJob.psm1
using module ./Strategy/ViewStrategyStartJob.psm1
using module ./Strategy/ViewStrategyStopJob.psm1
using module ./Strategy/ViewStrategySuspendJob.psm1
using module ./Strategy/ViewStrategyWaitJob.psm1


class ViewGenerationFactory{

    ViewGenerationFactory(){}

    [ViewGeneration]GetViewGenerationFactory([string]$ViewValidated)
    {
        [ViewGeneration]$Strategy = $null
        switch ($ViewValidated) {
            ([EnumJobToExecute]::DebugJob -as [string]).ToLower() { $Strategy = [ViewStrategyDebugJob]::new() }
            ([EnumJobToExecute]::FailedJob -as [string]).ToLower() { $Strategy = [ViewStrategyFailedJob]::new() }
            ([EnumJobToExecute]::GetJob -as [string]).ToLower() { $Strategy = [ViewStrategyGetJob]::new() }
            ([EnumJobToExecute]::ReceivedJob -as [string]).ToLower() { $Strategy = [ViewStrategyReceivedJob]::new() }
            ([EnumJobToExecute]::RemoveJob -as [string]).ToLower() { $Strategy = [ViewStrategyRemoveJob]::new() }
            ([EnumJobToExecute]::ResumeJob -as [string]).ToLower() { $Strategy = [ViewStrategyResumeJob]::new() }
            ([EnumJobToExecute]::StartJob -as [string]).ToLower() { $Strategy = [ViewStrategyStartJob]::new() }
            ([EnumJobToExecute]::StopJob -as [string]).ToLower() { $Strategy = [ViewStrategyStopJob]::new() }
            ([EnumJobToExecute]::SuspendJob -as [string]).ToLower() { $Strategy = [ViewStrategySuspendJob]::new() }
            ([EnumJobToExecute]::WaitJob -as [string]).ToLower() { $Strategy = [ViewStrategyWaitJob]::new() }
            Default {}
        }
        return $Strategy
    }
}