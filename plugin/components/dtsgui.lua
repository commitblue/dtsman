local packages = script.Parent.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local component = roact.Component:extend("dtsgui")
function component:render()
    return roact.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(4, 21, 144)
    }, {
        
    })
end