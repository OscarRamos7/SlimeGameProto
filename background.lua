background = {}

function background:load()
	sti = require("libraries/sti")
	self.gameMap = sti("maps/practiceLevel.lua")
	self.x = (self.gameMap.width * self.gameMap.tilewidth) / 2
	self.y = (self.gameMap.height * self.gameMap.tileheight) / 2
end

function background:update(dt) end

function background:draw()
	self.gameMap:drawLayer(self.gameMap.layers["Ground"])
	self.gameMap:drawLayer(self.gameMap.layers["Walls"])
end
