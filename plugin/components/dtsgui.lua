local packages = script.Parent.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local component = roact.Component:extend("dtsgui")
function component:render()
    return roact.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    }, {
        icon = roact.createElement("ImageLabel", {
            Image = "rbxassetid://11319125399",
            Size = UDim2.fromOffset(30, 30),
            BackgroundTransparency = 1
        }, {
            ["$uiaspectratioconstraint"] = roact.createElement("UIAspectRatioConstraint", {
                AspectType = Enum.AspectType.ScaleWithParentSize
            })
        }),
        objectToConvert = roact.createElement("TextButton", {
            Text = self.props.object,
            Size = UDim2.fromScale(0.7, 0.1),
            Position = UDim2.fromScale(0.07, 0.1),
            BackgroundColor3 = Color3.fromRGB(27, 27, 27),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.GothamBlack,
            [roact.Event.Activated] = self.props.objectSelect
        }, {
            ["$uicorner"] = roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.2, 0)
            })
        }),
        portText = roact.createElement("TextBox", {
            PlaceholderText = "port e.g. 8080",
            Text = self.props.portText,
            Font = Enum.Font.GothamBlack,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(0.9, 0.1),
            BackgroundColor3 = Color3.fromRGB(27, 27, 27),
            Position = UDim2.fromScale(0.04, 0.25),
            [roact.Change.Text] = self.props.textChanged
        }, {
            ["$uicorner"] = roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.2, 0)
            })
        }),
        startButton = roact.createElement("TextButton", {
            Text = self.props.status,
            Font = Enum.Font.GothamBlack,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(27, 27, 27),
            Size = UDim2.fromScale(0.9, 0.1),
            Position = UDim2.fromScale(0.04, 0.4),
            [roact.Event.Activated] = self.props.startButton,
        }, {
            ["$uicorner"] = roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.2, 0)
            })
        })
    })
end
return component