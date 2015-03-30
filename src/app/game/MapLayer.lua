local MapLayer = class("MapLayer", function()
    return display.newNode("MapLayer")
end)

function MapLayer:ctor()
end

function MapLayer:init()
end

function MapLayer:createTmxMap(mapPath)
    local m_map = CCTMXTiledMap:create(mapPath)
    m_map:setVisible(false)
    self:addChild(m_map)
end



return MapLayer


