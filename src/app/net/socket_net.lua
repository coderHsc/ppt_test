local net = require("framework.cc.net.init")
--local ByteArray = require("framework.cc.utils.ByteArray")
--require("framework.cc.utils.bit")

      

local socket_net = {}

self = socket_net
-- 网络初始化，添加侦听函数
function socket_net.init(addres,port)
	-- local time = net.SocketTCP.getTime()
	-- print("socket time:" .. time )


	-- if not self.socket then 
	-- 	self.socket = net.SocketTCP:new(addres,port,false)
	-- 	--self.socket:setName("HeroGameTcp")
	-- 	-- socket:setTickTime(1)
	--  -- 	socket:setReconnTime(6)
	--  -- 	socket:setConnFailTime(4)
	--  	print("xxxxxxxxxxxxxxxx",addres,port)
	--  	self.socket:addEventListener(net.SocketTCP.EVENT_DATA, handler(self,self.receive))
	--  	self.socket:addEventListener(net.SocketTCP.EVENT_CLOSE, handler(self,self.tcpClose))
	--     self.socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, handler(self, self.tcpConnected))
	--     self.socket:addEventListener(net.SocketTCP.EVENT_CLOSED, handler(self,self.tcpClosed))
	--     self.socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.error))
	   
	-- end
	if not self._socket then
        self._socket = net.SocketTCP.new("192.168.106.135",8888, true)
        self._socket:addEventListener(net.SocketTCP.EVENT_DATA, handler(self,self.receive))
	  	self._socket:addEventListener(net.SocketTCP.EVENT_CLOSE, handler(self,self.tcpClose))
	    self._socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, handler(self, self.tcpConnected))
	    self._socket:addEventListener(net.SocketTCP.EVENT_CLOSED, handler(self,self.tcpClosed))
	    self._socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.error))
    end
    self._socket:connect()
    print("socketManager.initSocket")
 -- socket:addEventListener(net.SocketTCP.EVENT_DATA, scnet.receive)
 -- socket:addEventListener(net.SocketTCP.EVENT_CLOSE, scnet.tcpClose)
 -- socket:addEventListener(net.SocketTCP.EVENT_CLOSED, scnet.tcpClosed)
 -- socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, scnet.tcpConnected)
 -- socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, scnet.error)


 	--self._socket:connect(addres, port, false)
 	
end

function socket_net.receive(__event)
	--dump(__event)
	print("receive status: %s", __event.data)

end

function socket_net.tcpClose(__event)
	--dump(__event)
	print("tcpClose: %s", __event.data)

end

function socket_net.tcpConnected(__event)
	--dump(__event)
	print("tcpConnected status: %s", __event.data)
end

function socket_net.tcpClosed(__event)
	--dump(__event)

	print("tcpClosed status: %s", __event.data)
end

function socket_net.error(__event)
	--dump(__event)
	print("error status: %s", __event.data)
end

-- --发送数据给服务器
-- function socket_net:send(msgid,data)
-- 	--encodeData 此方法是根据需要发送的数据安装与服务器定义好的消息格式去write





-- end

-- -- -- 发送数据给服务器
-- function scnet.send( msgid,data )
--  --  encodeData 此方法是根据需要发送的数据安装与服务器定义好的消息格式去write
--  local _ba = scnet.encodeData(msgid,data)
--  print("scnet.send _ba",_ba:getLen())
--  if not _ba then 
--  print("发送数据出错了.......",msgid)
--    return 
--  end
--  _ba:setPos(1)
--  local byteList = {}
--  local byteCount = 0
--  --  把数据读出来，加密
--  for i=1,#_ba._buf do
--  local tmpBit = string.byte(_ba:readRawByte())
--  byteCount = byteCount + tmpBit
--  tmpBit = bit.band(tmpBit + 80,255)
--  tmpBit = bit.band(bit.bnot(bit.band(tmpBit,255)),255)
--  byteList<i> = tmpBit
--  end
--  byteCount = byteCount % 256
--  -- 最后再组成一个新的ByteArray
--  local result = ByteArray.new(ByteArray.ENDIAN_BIG)
--  result:writeShort(_ba:getLen() + 3)
--  result:writeByte(byteCount)
--  for i=1,#byteList do
--  result:writeByte(byteList<i>)
--  end
--  -- 把数据发送给服务器
--  scnet.socket:send(result:getPack())
-- end
 
-- 根据messageid来确定数据格式
function socket_net:encodeData(msgid,data)
	

	

end
 
--  -- 根据messageid来确定数据格式
-- function scnet.encodeData( msgid,data )
--  if msgid then
--  local ba = ByteArray.new(ByteArray.ENDIAN_BIG)
--  local fmt = InfoUtil:getMsgFmt(msgid)  -- 此处为读取消息格式 看下面的MessageType里面会有定义
--  ba:writeStringUShort("token")  -- 此处为用户token,没有就为""，此处可以判断用户是否重新登陆啊等等.......
--  for i=1,#fmt do
--  scnet.writeData(ba,fmt<i>,data)
--  end
--  local baLength = ba:getLen()
--  local bt = ByteArray.new(ByteArray.ENDIAN_BIG)
--  bt:writeShort(baLength + 4)   -- 2为message length  2为message type
--  bt:writeShort(msgid)
--  bt:writeBytes(ba)
--  return bt
--  end
-- end
 
 
 
-- -- write 数据
-- function scnet.writeData( ba,msg_type,data )
  
--  local key = msg_type.key
--  print("scnet.writeData","key",key)
--  if key and data[key] then
--  local _type = msg_type["fmt"]
--  if type(_type) == "string" then
--  if _type == "string" then
--  ba:writeStringUShort(data[key])
--  elseif _type == "number" then
--  ba:writeLuaNumber(data[key])
--  elseif _type == "int" then
--  ba:writeInt(data[key])
--  elseif _type == "short" then
--  ba:writeShort(data[key])
--  end
--  else
--  ba:writeShort(#data[key])
--  for k,v in pairs(data[key]) do
--  for i=1,#_type do
--  scnet.writeData(ba,_type<i>,v)
--  end
--  end
--  end
--  else
--  print("找不到对应的 key",msg_type.key,msg_type,data)
--  end
-- end
-- -- 读取数据
-- -- 接收消息
-- function scnet.receive( event )
--  local ba = ByteArray.new(ByteArray.ENDIAN_BIG)
--  ba:writeBuf(event.data)
--  ba:setPos(1)
-- --  有连包的情况，所以要读取数据
--  while ba:getAvailable() <= ba:getLen() do 
--  scnet.decodeData(ba)
--  if ba:getAvailable() == 0 then
--  break
--  end
--  end
-- end
 
 
 
-- -- 消息数据解析
-- function scnet.decodeData( ba )
--  local len = ba:readShort() -- 读数据总长度
--  local total = ba:readByte() -- 一个用于验证的数子
--  local byteList = {}
--  local tmpTotal = 0
--  for i=1,len - 3 do  -- 去除前两个长度
--  local tmpBit = ba:readByte()
--  local enByte = scnet.decodeByte(tmpBit)
--  tmpTotal = tmpTotal + enByte
--  byteList<i> = enByte
--  end
 
 
--  local result = ByteArray.new(ByteArray.ENDIAN_BIG)
--  for i=1,#byteList do
--  result:writeRawByte(string.char(byteList<i>))
--  end
--  result:setPos(1)
--  if (tmpTotal % 256) == total then
--  scnet.decodeMsg(result)
--  else
--  print("scnet.decodeData  total   error")
--  end
-- end
 
-- -- 根据格式解析数据
-- function scnet.decodeMsg( byteArray )
--  local rData = {}
--  local len = byteArray:readShort()
--  local msgid = byteArray:readShort()
--  local roleString = byteArray:readStringUShort()
--  local fmt = InfoUtil:getMsgFmt(msgid)
--  for i=1,#fmt do
--  scnet.readData(byteArray,fmt<i>,rData)
--  end
--  if rData["result"] ~= 0 then
--  print("result  handler is here  ",rData[key])
--  return
--  else
--  NetManager:receiveMsg(msgid,rData)
--  end
-- end
-- -- readData
-- function scnet.readData( ba,msg_type,data)
--  local key = msg_type.key
--  if key then
--  data[key] = data[key] or {}
--  local _type = msg_type["fmt"]
--  if type(_type) == "string" then
--  if _type == "string" then
--  data[key] = ba:readStringUShort()
--  elseif _type == "number" then
--  data[key] = ba:readLuaNumber()
--  elseif _type == "int" then
--  data[key] = ba:readInt()
--  elseif _type == "short" then
--  data[key] = ba:readShort()
--  end
 
 
--  if key == "result" then  -- 当结果不为零的时候，说明有错误
  
--  if data[key] ~= 0 then
--  print("result  handler is here  ",data[key])
--  return
--  end
--  end
 
 
--  else
--  local _len = ba:readShort() -- 读取数组长度
--  for i=1,_len do
--  local tmp = {}
--  for j=1,#_type do
--  scnet.readData(ba,_type[j],tmp)
--  end
--  table.insert(data[key],tmp)
--  end
  
--  end
--  else
--  print("找不到对应的 key  scnet.readData",msg_type.key,msg_type,data)
--  end
-- end
 
-- -- 数据解密
-- function scnet.decodeByte( byte )
--  local tmp = bit.band(bit.bnot(bit.band(byte,255)),255)
--  tmp = bit.band((tmp + 256 - 80),255)
--  return tmp
-- end




------------------------------------------------------------------- 消息格式  -------------------------------------------------------------------

-- -- 发送
-- MsgFmt["1001"] = {
--  {
--  key = "list",
--  fmt = {
--  { 
--  key = "id",fmt = "int"
--  },
--  { 
--  key = "name",fmt = "string"
--  },
--  { 
--  key = "level",fmt = "int"
--  },
--  { 
--  key = "sex",fmt = "int"
--  }
--  }
--  },
--  {
--  key = "userid",fmt = "int"
--  }
-- }
-- --  返回
-- MsgFmt["5001"] = {
--  {
--  key = "result",fmt = "int" 
--  },
--  {
--  key = "list",
--  fmt = {
--  { 
--  key = "id",fmt = "int"
--  },
--  { 
--  key = "name",fmt = "string"
--  },
--  { 
--  key = "level",fmt = "int"
--  },
--  { 
--  key = "sex",fmt = "int"
--  }
--  }
--  }
-- }
return socket_net