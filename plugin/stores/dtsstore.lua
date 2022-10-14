local packages = script.Parent.Parent:WaitForChild("packages")
local rodux = require(packages:WaitForChild("rodux"))
return rodux.Store.new(function(state, action)
    state = state or {
        object = "Select an object",
        status = "Start"
    }

    return state
end)