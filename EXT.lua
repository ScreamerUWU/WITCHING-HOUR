local Player = game.Players.LocalPlayer
local Signal = Player:GetPropertyChangedSignal("Team")

local PlayerSig = game:GetService("Players").PlayerAdded
local Ranks = {20, 21, 254, 255}
local Temp = {}

local function SignalFunction(...)
   if Player.Team.Name == ("Playing")  then
      if Player.Character then
         Player.Character:Destroy()
      end
   end
end

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function ServerHop()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

local function PlayerSignal(self, ...)
    
   if self:IsInGroup(3363833) then
       
      local GroupRank = self:GetRankInGroup(3363833) 
      
      if table.find(Ranks, GroupRank) then
          
         local USERNAME = (self.Name)
         local USERID = (self.UserId)
         
         if isfile("WHMODS.TEMP") then
            local File = (readfile("WHMODS.TEMP"))
            local FileDecode = (game:GetService("HttpService"):JSONDecode(File))
            
            FileDecode[FileDecode + 1] = {
             ModeratorName = USERNAME,
             ModeratorID = USERID,
             TimeJoined = tostring(os.date)    
            }
         end
         
         if not isfile("WHMODS.TEMP") then
            Temp[#Temp + 1] = {
             ModeratorName = USERNAME,
             ModeratorID = USERID,
             TimeJoined = tostring(os.date)
            }
            
            writefile("WHMODS.TEMP", game:GetService("HttpService"):JSONEncode(Temp))
         end
         
         ServerHop()
         
      end
   end
end

for I, V in pairs(game:GetService("Players"):GetPlayers()) do
   PlayerSignal(V, {"__INDEX"}) 
end

Signal:Connect(SignalFunction)
PlayerSig:Connect(PlayerSignal)
