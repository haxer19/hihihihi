local FullBrightLib = {}
local Light = game:GetService("Lighting")
local originalAmbient = Light.Ambient
local originalColorShiftBottom = Light.ColorShift_Bottom
local originalColorShiftTop = Light.ColorShift_Top

local connection
local function applyFullBright()
    Light.Ambient = Color3.new(1, 1, 1)
    Light.ColorShift_Bottom = Color3.new(1, 1, 1)
    Light.ColorShift_Top = Color3.new(1, 1, 1)
end

function FullBrightLib.enable()
    originalAmbient = Light.Ambient
    originalColorShiftBottom = Light.ColorShift_Bottom
    originalColorShiftTop = Light.ColorShift_Top

    applyFullBright()
    if not connection then
        connection = Light.LightingChanged:Connect(applyFullBright)
    end
end

function FullBrightLib.disable()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    Light.Ambient = originalAmbient
    Light.ColorShift_Bottom = originalColorShiftBottom
    Light.ColorShift_Top = originalColorShiftTop
end

return FullBrightLib
