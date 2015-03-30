
--require("app.net.messageManager")
--require "app.net.protobuf"

local net = require("framework.cc.net.init")
--protobuf.register_file "res/BnBOnline.pb"
socketManager = {}
self = socketManager
local isConnect = false 
function socketManager.initSocket()
	if not self._socket then
        self._socket = net.SocketTCP.new(GMAE_NET_ADDRES, GAME_NET_PORT, false)
        self._socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, handler(self, self.onStatus))
        self._socket:addEventListener(net.SocketTCP.EVENT_CLOSE, handler(self,self.onStatus))
        self._socket:addEventListener(net.SocketTCP.EVENT_CLOSED, handler(self,self.onStatus))
        self._socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.onStatus))
        self._socket:addEventListener(net.SocketTCP.EVENT_DATA, handler(self,self.onData))
    end
    self._socket:connect()
    print("socketManager.initSocket")
end


function socketManager.sendMessage(msg)
	self._socket:send(msg:getPack())
end

function socketManager.onData(__event)
    local maxLen,version,messageId,msg = messageManager:unpackMessage(__event.data)

     -- print("msg:", messageId,msg)

     -- if messageId == 1001 then 
     --    local stringbuffer = protobuf.decode("BnBOnline.BnB_Login",msg)

     --    print("xxxxxxx",stringbuffer.userid,stringbuffer.name)
     -- end
    -- if messageId == 0 then 
    -- 	print("socket receive raw data:", msg)

    -- elseif messageId == 1000 then 
    -- 	--local stringbuffer = protobuf.decode("talkbox.talk_result",msg)
    --     --self.nextScene:getChatLayer():createText(msg)
    -- 	--if stringbuffer.id==0 then
    -- 	--	print("创建用户成功")
    -- 	--elseif stringbuffer.id==1 then 
    -- 	--	print("服务端解析请求创建用户的protocbuf失败")

    -- 	--elseif stringbuffer.id==2 then 
    -- 	--	print("创建用户失败，名字已经存在")
    -- 	--elseif stringbuffer.id==3 then 
    -- 	--	print("服务端解析请求发送内容的protocbuf失败")
    -- 	--end
    -- 	--print("stringbuffer:", stringbuffer.id)
    -- elseif messageId == 1010 then 

    --     local stringbuffer = protobuf.decode("talkbox.talk_message",msg)
    --     self.nextScene:getChatLayer():createText(msg.msg)

    -- elseif messageId ==1008 then 


    -- 	local stringbuffer = protobuf.decode("talkbox.talk_create",msg)

    --     self.nextScene = require("app.scenes.ChatScene"):new()
    --     local kEffect = {"splitCols","splitRows"}
    --     local transtion = display.wrapSceneWithTransition(self.nextScene,kEffect[math.random(1,table.nums(kEffect))],.5)
    --     display.replaceScene(transtion)
    --     self.nextScene:getChatLayer():createText(stringbuffer.userid .. stringbuffer.name)
    -- 	print("socket receive raw data:", maxLen,version,messageId,stringbuffer.userid,stringbuffer.name)
    -- end


end

function socketManager:onStatus(__event)

    isConnect = true 
    printInfo("socket status: %s", __event.name)

    -- local stringbuffer = protobuf.encode("talkbox.talk_create",
    --                 {
    --                   userid = 13,
    --                   name = "2",
                     
    --                 })
    -- local message = messageManager.getProcessMessage (1,1003,stringbuffer)
    -- self._socket:send(message:getPack())
end

function socketManager:getConnectState()
    return isConnect
end

