require("player")
require("background")
require("sounds")
require("world")
require("enemy")

function love.load()
	camera = require("libraries/camera")
	cam = camera()
	cam.scale = cam.scale * 1.5
	background:load()
	windfield:load()
	player:load()
	enemy:load()
	sounds:load()
end

function love.update(dt)
	background:update(dt)
	player:update(dt)
	enemy:update(dt, player)

	cam:lookAt(background.x, background.y)

	
	windfield:update(dt)
end

function love.draw()
	cam:attach()
		background:draw()
		player:draw()
		enemy:draw()
		windfield:draw()
	cam:detach()
end


--/Users/oscarramos/Desktop/love.app/Contents/MacOS/love /Users/oscarramos/Desktop/zeldaClone