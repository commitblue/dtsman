local httpService : HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local packages = script.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local roactrodux = require(packages:WaitForChild("roact-rodux"))
local rodux = require(packages:WaitForChild("rodux"))
local components = script.Parent:WaitForChild("components")
local stores = script.Parent:WaitForChild("stores")
local dtsStore = require(stores:WaitForChild("dtsstore"))
local dtsGui = require(components:WaitForChild("dtsgui"))
--TODO : Generate .d.ts code and post it to the dtsserver
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
local function getGlobalFromString(str)
    local got = _G
    local pathSplit = str:split(".")
    for _,v in pathSplit do
        got = got[v]
    end
    return got
end
while true do
    if started then
        local state = dtsStore:getState()
        export type state = {
            object : string,
            status : string
        }
        local refToObject = getGlobalFromString(state.object)
        local success, result = pcall(httpService.GetAsync, "https://localhost:")
        if success then
            
        else
            warn("Dts server not detected or isnt running")
        end
    end
    task.wait(2)
end