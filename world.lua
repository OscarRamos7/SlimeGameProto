require("background")

windfield = {}
windfield.world = nil
windfield.walls = {}

function windfield:load()
    local wf = require("libraries/windfield")
    self.world = wf.newWorld(0,0)

    self.world:addCollisionClass("Enemy", {collidesWith = {"Obstacle", "Player"}})
    self.world:addCollisionClass("Player", {collidesWith = {"Obstacle", "Enemy"}})
    self.world:addCollisionClass("Obstacle", {collidesWith = {"Enemy", "Player"}})

	if background.gameMap.layers["Wall-hitboxes"] then
		for i, obj in pairs(background.gameMap.layers["Wall-hitboxes"].objects) do
			local wall = self.world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
			wall:setType('static')
            wall:setCollisionClass("Obstacle")
			windfield.walls[obj.id] = wall
            if obj.id == 11 then
                windfield.walls[obj.id]:setType('dynamic')
            end
		end
	end
end

function windfield:update(dt)
    if self.world then
        self.world:update(dt)
    end
end

function windfield:draw()
    self.world:draw()
end