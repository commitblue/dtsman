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
local toolbar = plugin:CreateToolbar("dtsman")
local selection = game:GetService("Selection")
local button = toolbar:CreateButton("Toggle widget", "toggles widget", "")
--TODO : Generate .d.ts code and post it to the dtsserver
local widget = plugin:CreateDockWidgetPluginGui("dtsManGui", DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Float,
    false,
    false,
    100,
    200,
    100,
    200
))
widget.Title = "dtsMan"
button.Click:Connect(function()
    widget.Enabled = not widget.Enabled
    button:SetActive(widget.Enabled)
end)
widget:GetPropertyChangedSignal("Enabled"):Connect(function()
    button:SetActive(widget.Enabled)
end)
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
                    dtsStore:dispatch({
                        type = "editState",
                        stateToEdit = "status",
                        value = "Stop"
                    })
                    started = true
                else
                    dtsStore:dispatch({
                        type = "editState",
                        stateToEdit = "status",
                        value = "Start"
                    })
                    started = false
                end
            end,
            textChanged = function(text)
                dtsStore:dispatch({
                    type = "editState",
                    stateToEdit = "portText",
                    value = text.Text
                })
            end,
            objectSelect = function()
                print("works")
                local objects = selection:Get()[1]
                if objects then
                    dtsStore:dispatch({
                        type = "editState",
                        stateToEdit = "object",
                        value = objects:GetFullName()
                    })
                else
                    dtsStore:dispatch({
                        type = "editState",
                        stateToEdit = "object",
                        value = "Invalid object"
                    })
                end
            end
        }
    end
)(dtsGui)
local tree = roact.createElement(roactrodux.StoreProvider, {
    store = dtsStore
}, {
    ["gui"] = roact.createElement(dtsGui)
})
roact.mount(tree, widget, "main")
function getGlobalFromString(fullName)
	local segments = fullName:split(".")
	local current = game

	for _,location in pairs(segments) do
		current = current[location]
	end

	return current
end
local function escape(str)
    return str:gsub("\"", "\\\"")
end
local function generateDtsCode(obj : Instance)
    local generated = string.format("type %s = %s & {\n   ", obj.Name, obj.ClassName)
    local function subFunction_dump(obj, intents)
        local children = obj:GetChildren()
        for _, v in children do
            generated = generated..intents.."[\""..escape(v.Name).."\"] : "..v.ClassName
            if #v:GetChildren() > 0 then
                generated = generated .. " & {\n"
                subFunction_dump(v, intents .. "   ")
                generated = generated .. "\n};"
            else
                generated = generated .. ";\n   "
            end
        end
    end
    for _,v in obj:GetChildren() do
        generated = generated.."   [\""..escape(obj.Name).."\"] : "..obj.ClassName
        if #v:GetChildren() <= 0 then
            generated ..= ";\n   "
        else
            generated = generated.." & {\n"
            subFunction_dump(v, "      ")
            generated = generated.."\n};"
        end
    end
    generated = generated .. "\n};"
    return generated
end
print(generateDtsCode(game.Workspace.Baseplate))
while true do
    if started then
        local success, result = pcall(function()
            local state = dtsStore:getState()
            export type state = {
                object : string,
                status : string,
                portText : string
            }
            print(state.portText)
            local refToObject = getGlobalFromString(state.object)
            local success, result = pcall(httpService.GetAsync, httpService, string.format("https://localhost:%s/", state.portText))
            print(result)
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
        end)
        if not success then
            warn(string.format("Unusual error. %s", result))
        end
    end
    task.wait(2)
end