class RuleInterface{

    RuleInterface(){}

    [System.Collections.Specialized.OrderedDictionary]ValidateExecutionRule([string]$JobName, [string]$Id){
        throw("Must Override Method")
    }

}