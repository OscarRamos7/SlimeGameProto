require("player")

enemy = {}

function enemy:load()
	anim8 = require("libraries/anim8")
	love.graphics.setDefaultFilter("nearest", "nearest")

	self.collider = windfield.world:newBSGRectangleCollider(20, 20, 10, 8, 2)
	self.collider:setCollisionClass("Enemy")
	self.collider:setFixedRotation(true)
	self.x = 250
	self.y = 250
	self.speed = 50
	self.brownSlime = love.graphics.newImage("assets/brownSlime.png")
	self.grid = anim8.newGrid(12, 10, self.brownSlime:getWidth(), self.brownSlime:getHeight())

	self.animations = {}
	self.animations.left = anim8.newAnimation(self.grid("1-4", 1), 0.2)
	self.animations.right = anim8.newAnimation(self.grid("1-4", 2), 0.2)
	self.animations.up = anim8.newAnimation(self.grid("1-4", 3), 0.2)
	self.animations.down = self.animations.right
	self.anim = self.animations.right
end

function enemy:update(dt, player)
	local dx = player.x - self.collider:getX()
	local dy = player.y - self.collider:getY()

	local distance = math.sqrt(dx * dx + dy * dy)
	local detectionRange = 100

	if distance < detectionRange then
		local directionX = dx / distance
		local directionY = dy / distance

		self.collider:setLinearVelocity(directionX * self.speed, directionY * self.speed)

		if math.abs(directionX) > math.abs(directionY) then
			if directionX > 0 then
				self.anim = self.animations.right
			else
				self.anim = self.animations.left
			end
		else
			if directionY > 0 then
				self.anim = self.animations.down
			else
				self.anim = self.animations.up
			end
		end
	else
		self.collider:setLinearVelocity(0, 0)

	end

	self.anim:update(dt)
	print("Enemy position:", self.collider:getPosition())
end

function enemy:draw()
	local x, y = self.collider:getPosition()
	self.anim:draw(self.brownSlime, x, y, nil, 1, 1, 6, 5)
end
