
local socketNet = require("app.net.socket_net")
require("app.net.socketManager")
NetManager = {}

--初始化
function NetManager.init()
	NetManager._listenerList = {}
	--socketNet.init(GMAE_NET_ADDRES,GAME_NET_PORT)
	--socketNet:connect(GMAE_NET_ADDRES,GAME_NET_PORT)
	socketManager.initSocket()
end

-- 注册消息
-- 注册之后 接受到服务器消息之后进行广播，谁注册，谁相应
function NetManager:registerMsg(msgid,callBack)
	NetManager._listenerList[msgid] = NetManager._listenerList[msgid] or {}

	local isExist = NetManager:findCallBack(msgid,callBack)

	if not isExist then 
		table.insert(NetManager._listenerList[msgid],callBack)
	end
end
 

-- 移除注册消息
function NetManager:removeRegister(msgid,callBack)
	if NetManager._listenerList[msgid] then

		for k ,v in pairs(NetManager._listenerList) do 
			if v == callBack then 
				NetManager._listenerList[msgid][k] = nil
			end
		end
	end
end

-- 发送消息
-- 整理数据发送给服务器
function NetManager:sendMsg(msgid,data)
	socketNet.send(msgid,data)
end

-- 接受消息
-- 派发事件（数据）
function NetManager:receiveMsg(msgid, data)

	if NetManager._listenerList[msgid] then
 		for k,v in pairs(NetManager._listenerList[msgid]) do
 			v(data)
 		end
 	end

end


function NetManager:findCallBack(msgid, callBack)

	for k,v in pairs(NetManager._listenerList[msgid]) do
		if v == callBack then
			return true 
		end
	end
	return false 

end

 
 
 
------------------------------------------------------------------- test  -------------------------------------------------------------------
-- 监听事件
-- function MainScene:onEnter()
--  NetManager:registerMsg(MsgType.SC_LOGIN ,handler(self,self.receiveHandler))
-- end
 
-- -- 移除坚挺
-- function MainScene:onExit()
--     NetManager:removeRegister(MsgType.SC_LOGIN ,handler(self,self.receiveHandler))
-- end
-- ?
-- 1
-- 2
-- 3
-- 4
-- 5
-- 6
-- 7
-- 8
-- 9
-- 10
-- 11
-- -- 发送数据，根据MsgFmt构造数据
 
 
--  local data = {}
--   data.list = {}
--   table.insert(data.list,{id = 1001,name = "小房",level = 1,sex = 1})
--   table.insert(data.list,{id = 1002,name = "小田",level = 11,sex = 2})
--   table.insert(data.list,{id = 1003,name = "2222",level = 21,sex = 1})
--   table.insert(data.list,{id = 1004,name = "3333",level = 31,sex = 2})
--   data.userid = 10001
--   NetManager:sendMsg(MsgType.CS_LOGIN,data)

return NetManager