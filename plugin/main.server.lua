local httpService = game:GetService("HttpService")
local packages = script.Parent:WaitForChild("packages")
local roact = require(packages:WaitForChild("roact"))
local roactrodux = require(packages:WaitForChild("roact-rodux"))
local rodux = require(packages:WaitForChild("rodux"))
local components = script.Parent:WaitForChild("components")
local stores = script.Parent:WaitForChild("stores")
