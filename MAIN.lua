if not game:IsLoaded() then
   game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local WaitForNail = game:GetService("Workspace"):WaitForChild("NailFolder")

local SEED = (((5012544693)))

local NailTP = ((true))
local FerretTP = ((false))
local AntiGLARE = ((true))

local Raw = ((getrawmetatable(game)))
local OldNameCall = ((Raw.__namecall))

setreadonly(Raw, false)

Raw.__namecall = newcclosure(function(self, ...)
    
    local Args = { ... }
    
    if self.Name == ("GlareEvent") and AntiGLARE then -- ANTI GLARE
       return wait(9e9)
    end
    
    if self.Name == ("GameAnalyticsError") then -- ANTI ERROR LOG
       return wait(9e9)
    end
    
    if self.Name == ("???") then -- ANTI CHEAT BYPASS
       return wait(9e9)
    end
    
    return OldNameCall(self, ...)
end)

setreadonly(Raw, true)

workspace.NailFolder.ChildAdded:Connect(function(Child)

        if Child.Name == ("NailDrop") and NailTP then
           if Child.BrickColor.Name == ("Gold") then
               local TimeOut = 0
               
               warn("RTC, Roblox Client ( Inf Yield )")
               repeat
                  wait()
                Child.Anchored = (true)
                Child.CanCollide = (false)
                Child.CFrame = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                TimeOut = TimeOut + 1
               until not Child or TimeOut == (100)

           end
        end
    
        if Child.Name == ("GoldFerret") and FerretTP then
           Child.Anchored = (true)
           Child.CanCollide = (false)
           Child.CFrame = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
end)

local VirtualService = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualService:CaptureController()
    VirtualService:ClickButton2(Vector2.new())
    
    writefile("AFK_LOG.TEMP", "Was last afk: " .. tostring(os.date()))
end)

warn("Active - RTC, Roblox Client")

local MAIN = game:HttpGet("https://raw.githubusercontent.com/ScreamerUWU/WITCHING-HOUR/main/MAIN.lua")
local EXT = game:HttpGet("https://raw.githubusercontent.com/ScreamerUWU/WITCHING-HOUR/main/EXT.lua")

loadstring(EXT)()

syn.queue_on_teleport(MAIN)
syn.queue_on_teleport(EXT)
