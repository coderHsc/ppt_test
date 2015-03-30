local Scheduler = require("framework.scheduler")
local GameManager = class("GameManager")


local scheduler = nil 

function GameManager:initManager()
	scheduler = Scheduler.scheduleGlobal(handler(self, self.update), 0)
	

end

function GameManager:update(ts)



end

function GameManager:endManager()
	Scheduler.unscheduleGlobal(scheduler)
end


return GameManager