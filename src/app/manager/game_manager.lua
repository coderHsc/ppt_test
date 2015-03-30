
local GameManager = class("GameManaer")
local Scheduler   = require("framework.scheduler")
local NetManager  = require("app.manager.net_manager")
local g_scheduler = nil 
function GameManager:ctor()
	print("game manger")
	self:init()
end

function GameManager:init()
	g_scheduler = Scheduler.scheduleGlobal(handler(self,self.update),0)
	NetManager.init()
	--
	--GameManager:
	--socketManager:initSocket()
end

function GameManager:update(dt)
	--print("xxxxxxxxxxxxx",dt,g_scheduler)





end


return GameManager