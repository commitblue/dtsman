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
local tree = roact.createElement(roactrodux.StoreProvider, {
    store = dtsStore
}, {
    ["gui"] = roact.createElement(dtsGui)
})
roact.mount(tree, widget)