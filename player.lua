player = {}

function player:load()
	anim8 = require("libraries/anim8")
	love.graphics.setDefaultFilter("nearest", "nearest")

	self.collider = windfield.world:newBSGRectangleCollider(50, 50, 10, 8, 2)
	self.collider:setCollisionClass("Player")
	self.collider:setFixedRotation(true)
	self.x = love.graphics.getWidth() / 2
	self.y = love.graphics.getHeight() / 2
	self.speed = 100
	self.mainSlime = love.graphics.newImage("assets/mainSlime.png")
	self.grid = anim8.newGrid(12, 10, self.mainSlime:getWidth(), self.mainSlime:getHeight())

	self.animations = {}
	self.animations.left = anim8.newAnimation(self.grid("1-4", 1), 0.2)
	self.animations.right = anim8.newAnimation(self.grid("1-4", 2), 0.2)
	self.animations.up = anim8.newAnimation(self.grid("1-4", 3), 0.2)
	self.animations.down = self.animations.right
	self.anim = self.animations.right
end

function player:update(dt)
	self:move(dt)
	self.x = self.collider:getX()
	self.y = self.collider:getY()
	self.anim:update(dt)
	print("Player position:", self.collider:getPosition())
end

function player:move(dt)

	local vx = 0
	local vy = 0

	if love.keyboard.isDown("w") then
		vy = self.speed * -1
		self.anim = self.animations.up
	end
	if love.keyboard.isDown("a") then
		vx = self.speed * -1
		self.anim = self.animations.left
		self.animations.down = self.animations.left
	end
	if love.keyboard.isDown("s") then
		vy = self.speed
		self.anim = self.animations.down
	end
	if love.keyboard.isDown("d") then
		vx = self.speed
		self.anim = self.animations.right
		self.animations.down = self.animations.right
	end

	if vx ~= 0 and vy ~= 0 then
        local magnitude = math.sqrt(vx * vx + vy * vy)
        vx = (vx / magnitude) * self.speed
        vy = (vy / magnitude) * self.speed
    end

	player.collider:setLinearVelocity(vx, vy)
end

function player:draw()
	player.anim:draw(self.mainSlime, self.x, self.y, nil, nil, nil, 6, 5)
end
