local httpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local packages = script.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local roactrodux = require(packages:WaitForChild("roact-rodux"))
local rodux = require(packages:WaitForChild("rodux"))
local components = script.Parent:WaitForChild("components")
local stores = script.Parent:WaitForChild("stores")
local dtsStore = require(stores:WaitForChild("dtsstore"))
local dtsGui = require(components:WaitForChild("dtsgui"))
local widget = plugin:CreateDockWidgetPluginGui("dtsManGui", DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Float,
    false,
    false,
    300,
    400,
    300,
    400
))
widget.Title = "dtsMan"
local started = false
dtsGui = roactrodux.connect(
    function(state)
        return state
    end,
    function(dispatch)
        return {
            startButton = function()
                local state = dtsStore:getState()
                export type state = {
                    object : string,
                    status : string
                }
                if not started then
                    dispatch({
                        type = "editState",
                        stateToEdit = "status",
                        value = "Stop"
                    })
                    started = true
                else
                    dispatch({
                        type = "editState",
                        stateToEdit = "status",
                        value = "Start"
                    })
                    started = false
                end
            end
        }
    end
)
local tree = roact.createElement(roactrodux.StoreProvider, {
    store = dtsStore
}, {
    ["gui"] = roact.createElement(dtsGui)
})
roact.mount(tree, widget)
while started do
    
    task.wait(2)
end