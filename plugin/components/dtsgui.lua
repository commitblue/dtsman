local packages = script.Parent.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local component = roact.Component:extend("dtsgui")
function component:render()
    return roact.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(4, 21, 144)
    }, {
        objectToConvert = roact.createElement("TextButton", {
            Text = self.props.object,
            Size = UDim2.fromScale(0.7, 0.1),
            Position = UDim2.fromScale(0.04, 0.3),
            BackgroundColor3 = Color3.fromRGB(67, 26, 204),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.Arial,
            [roact.Event.Activated] = self.props.objectSelect
        }, {
            ["$uicorner"] = roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.2, 0)
            })
        }),
        portText = roact.createElement("TextBox", {
            PlaceholderText = "port e.g. 8080",
            Text = self.props.portText,
            Font = Enum.Font.Arial,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(0.9, 0.1),
            BackgroundColor3 = Color3.fromRGB(67, 26, 204),
            Position = UDim2.fromScale(0.04, 0.25),
            [roact.Change.Text] = self.props.textChanged
        }, {
            ["$uicorner"] = roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.2, 0)
            })
        }),
        startButton = roact.createElement("TextButton", {
            Text = self.props.status,
            Font = Enum.Font.Arial,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(67, 26, 204),
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