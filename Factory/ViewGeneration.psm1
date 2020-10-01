class ViewGeneration{

    ViewGeneration(){}

    [System.Collections.Specialized.OrderedDictionary]ExecuteJob([string]$ActionName, [string]$JobName, [string]$Id){
        throw("Method to override in the Parent class/Interface [IViewGeneration]!")
    }
}