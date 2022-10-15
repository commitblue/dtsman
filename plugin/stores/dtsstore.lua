local packages = script.Parent.Parent:WaitForChild("packages")
local rodux = require(packages:WaitForChild("rodux"))
return rodux.Store.new(function(state, action)
    state = state or {
        object = "Select an object",
        status = "Start",
        portText = ""
    }
    if action.type == "editState" then
        local newstate = state
        newstate[action.stateToEdit] = action.value
        return newstate
    elseif action.type == "overwriteState" then
        return action.state
    end
    return state
end)