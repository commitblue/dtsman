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
            end,
            textChanged = function(text)
                dispatch({
                    type = "editState",
                    stateToEdit = "portText",
                    value = text
                })
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
local function generateDtsCode(obj : Instance)
    local generated = string.format("type %s = %s & {\n   ", obj.Name, obj.ClassName)
    local function subFunction_dump(obj)
        local children = obj:GetChildren()
        generated = generated..""
    end
    for _,v in obj:GetChildren() do
        generated = generated..obj.Name.." : "..obj.ClassName
        if #v:GetChildren < 1 then
            generated ..= ";\n   "
        else
            generated = generated.." & {\n"
            subFunction_dump(v)
            generated = generated.."\n};"
        end
    end
    generated = generated + "\n};"
    return generated
end
while true do
    if started then
        local state = dtsStore:getState()
        export type state = {
            object : string,
            status : string,
            portText : string
        }
        local refToObject = getGlobalFromString(state.object)
        local success, result = pcall(httpService.GetAsync, string.format("https://localhost:%s/", state.portText))
        if success and result == "dtsman" then
            success, result = pcall(httpService.RequestAsync, {
                Url = string.format("https://localhost:%s/dts/", state.portText),
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    dtsFile = generateDtsCode(refToObject)
                }
            })
            if not success then
                warn(string.format("Dts POST request had an error, %s", result))
            end
        else
            warn("Dts server not detected or isnt running")
        end
    end
    task.wait(2)
end