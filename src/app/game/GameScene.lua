require("app.data.DataManager")
require("app.game.GameManager")
require("app.game.ControlManager")
require("app.net.socketManager")

local Scheduler = require("framework.scheduler")
local GameScene = class("GameScene",function() 
	return display.newScene("GameScene")
end)

local mapLayer = nil 
local scheduler_handler_
function GameScene:ctor()
    self:init()
end

function GameScene:init()
    
    scheduler_handler_ = Scheduler.scheduleGlobal(handler(self, self.update), 0)
 
	-----------------------------------------------
	mapLayer   = require("app.game.MapLayer"):new()
	mapLayer:createTmxMap("tmx_map/1-1.tmx")
    self:addChild(mapLayer)

    --local gameManger = require("app.game.GameManager"):new()
    --gameManger:initManager()

    -----------------------------------------------玩家
    heroSprite = require("app.game.HeroSprite"):new()
    heroSprite:createHero(DataManager.heroInfo[1])
    self:addChild(heroSprite:getSprite())


    self:testLogin()
    ---------------------------------------------------------
 
end
function GameScene:testLogin()
    socketManager:initSocket()

    -- local stringbuffer = protobuf.encode("BnBOnline.BnB_Login",
    --       {
    --         userid = 1,
    --         name   ="hu",
    --       })
    -- local message = messageManager:getProcessMessage(1,1000,stringbuffer)
    -- socketManager:sendMessage(message)

    print("initSocket over ")
end


function GameScene:update(ts)

   if socketManager:getConnectState() then 
        print("cccccccccccccccccccccccc")
        Scheduler.unscheduleGlobal(scheduler_handler_)
        local stringbuffer = protobuf.encode("BnBOnline.BnB_Login",
        {
            userid = 1,
            name   ="hu",
        })
        local message = messageManager:getProcessMessage(1,1000,stringbuffer)
        socketManager:sendMessage(message)

   end


end

return GameScene