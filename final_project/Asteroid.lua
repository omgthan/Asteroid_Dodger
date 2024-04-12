Asteroid = Class{}

neg_min = -200
neg_max = -50
pos_min = 200
pos_max = 50

function Asteroid:init()

    -- start with either 16x16 or 32x32 asteroid
    if math.random(2) == 1 then
        self.width = 16
        self.height = 16

        -- give texture
        self.texture = love.graphics.newImage('textures/asteroid.png')
    else
        self.width = 32
        self.height = 32

        -- give texture
        self.texture = love.graphics.newImage('textures/asteroid_big.png')
    end

    --pick random edge to spawn at
    edge = math.random(4)

    -- edge = 1, left edge
    if edge == 1 then
        self.x = 0 - self.width
        self.dx = math.random(pos_min, pos_max)

        -- top half of left edge
        if math.random(2) == 1 then
            self.y = math.random(0 - self.height, VIRTUAL_HEIGHT/2 - self.height)
            self.dy = math.random(pos_min, pos_max)

        -- bottom half of left edge
        else
            self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT)
            self.dy = math.random(neg_min, neg_max)
        end

    -- edge = 2, top edge
    elseif edge == 2 then
        self.y = 0 - self.height
        self.dy = math.random(pos_min, pos_max)

        -- left half of top edge
        if math.random(2) == 1 then
            self.x = math.random(0 - self.width, VIRTUAL_WIDTH/2 - self.width)
            self.dx = math.random(pos_min, pos_max)

        -- right half of top edge
        else
            self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH)
            self.dx = math.random(neg_min, neg_max)
        end

    -- edge = 3, right edge
    elseif edge == 3 then
        self.x = VIRTUAL_WIDTH
        self.dx = math.random(neg_min, neg_max)

        -- top half of right edge
        if math.random(2) == 1 then
            self.y = math.random(0 - self.height, VIRTUAL_HEIGHT/2 - self.height)
            self.dy = math.random(pos_min, pos_max)

        -- bottom half of right edge
        else
            self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT)
            self.dy = math.random(neg_min, neg_max)
        end

    -- edge = 4, bottom edge
    elseif edge == 4 then
        self.y = VIRTUAL_HEIGHT
        self.dy = math.random(neg_min, neg_max)

        -- left half of bottom edge
        if math.random(2) == 1 then
            self.x = math.random(0 - self.width, VIRTUAL_WIDTH/2 - self.width)
            self.dx = math.random(pos_min, pos_max)

        -- right half of bottom edge
        else
            self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH)
            self.dx = math.random(neg_min, neg_max)
        end
    end

    -- OLD RANDOM SPAWNING

    -- -- start with random velocities
    -- self.dy = math.random(-200, 200)
    -- self.dx = math.random(-200, 200)
    -- while self.dy > -100 and self.dy < 100 do
    --     self.dy = math.random(-200, 200)
    -- end
    -- while self.dx > -100 and self.dx < 100 do
    --     self.dx = math.random(-200, 200)
    -- end

    -- -- randomize position
    -- if self.dx > 0 then
    --     self.x = math.random(VIRTUAL_WIDTH/2) - self.width
    -- else
    --     self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH) + self.width
    -- end
    -- if self.dy > 0 then
    --     self.y = math.random(VIRTUAL_HEIGHT/2) - self.height
    -- else
    --     self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT) + self.height
    -- end

    -- -- randomize which edge to spawn at
    -- if self.dx > 0 and self.dy > 0 then
    --     if math.random(2) == 1 then
    --         self.y = 0 - self.height
    --     else
    --         self.x = 0 - self.width
    --     end
    -- elseif self.dx > 0 and self.dy < 0 then
    --     if math.random(2) == 1 then
    --         self.y = VIRTUAL_HEIGHT + self.height
    --     else
    --         self.x = 0 - self.width
    --     end
    -- elseif self.dx < 0 and self.dy > 0 then
    --     if math.random(2) == 1 then
    --         self.y = 0 - self.height
    --     else
    --         self.x = VIRTUAL_WIDTH + self.width
    --     end
    -- elseif self.dx < 0 and self.dy < 0 then
    --     if math.random(2) == 1 then
    --         self.y = VIRTUAL_HEIGHT + self.height
    --     else
    --         self.y = VIRTUAL_WIDTH + self.width
    --     end
    -- end
end

-- collision function, check if colliding with player
function Asteroid:collides(player)
    if self.x > player.x + player.width or player.x > self.x + self.width then
        return false
    end

    if self.y > player.y + player.height or player.y > self.y + self.height then
        return false
    end

    return true
end

function Asteroid:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

-- randomize direction, size, and position
function Asteroid:randomize()
    -- randomize direction
    self.dy = math.random(-200, 200)
    self.dx = math.random(-200, 200)
    while self.dy > -100 and self.dy < 100 do
        self.dy = math.random(-200, 200)
    end
    while self.dx > -100 and self.dx < 100 do
        self.dx = math.random(-200, 200)
    end

    -- randomize size
    if math.random(2) == 1 then
        self.width = 16
        self.height = 16

        -- give texture
        self.texture = love.graphics.newImage('textures/asteroid.png')
    else
        self.width = 32
        self.height = 32

        -- give texture
        self.texture = love.graphics.newImage('textures/asteroid_big.png')
    end

    --pick random edge to spawn at
    edge = math.random(4)

    -- edge = 1, left edge
    if edge == 1 then
        self.x = 0 - self.width
        self.dx = math.random(pos_min, pos_max)

        -- top half of left edge
        if math.random(2) == 1 then
            self.y = math.random(0 - self.height, VIRTUAL_HEIGHT/2 - self.height)
            self.dy = math.random(pos_min, pos_max)

        -- bottom half of left edge
        else
            self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT)
            self.dy = math.random(neg_min, neg_max)
        end

    -- edge = 2, top edge
    elseif edge == 2 then
        self.y = 0 - self.height
        self.dy = math.random(pos_min, pos_max)

        -- left half of top edge
        if math.random(2) == 1 then
            self.x = math.random(0 - self.width, VIRTUAL_WIDTH/2 - self.width)
            self.dx = math.random(pos_min, pos_max)

        -- right half of top edge
        else
            self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH)
            self.dx = math.random(neg_min, neg_max)
        end

    -- edge = 3, right edge
    elseif edge == 3 then
        self.x = VIRTUAL_WIDTH
        self.dx = math.random(neg_min, neg_max)

        -- top half of right edge
        if math.random(2) == 1 then
            self.y = math.random(0 - self.height, VIRTUAL_HEIGHT/2 - self.height)
            self.dy = math.random(pos_min, pos_max)

        -- bottom half of right edge
        else
            self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT)
            self.dy = math.random(neg_min, neg_max)
        end

    -- edge = 4, bottom edge
    elseif edge == 4 then
        self.y = VIRTUAL_HEIGHT
        self.dy = math.random(neg_min, neg_max)

        -- left half of bottom edge
        if math.random(2) == 1 then
            self.x = math.random(0 - self.width, VIRTUAL_WIDTH/2 - self.width)
            self.dx = math.random(pos_min, pos_max)

        -- right half of bottom edge
        else
            self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH)
            self.dx = math.random(neg_min, neg_max)
        end
    end

    -- OLD RANDOM SPAWNING

    -- -- randomize position
    -- if self.dx > 0 then
    --     self.x = math.random(VIRTUAL_WIDTH/2) - self.width
    -- else
    --     self.x = math.random(VIRTUAL_WIDTH/2, VIRTUAL_WIDTH) + self.width
    -- end
    -- if self.dy > 0 then
    --     self.y = math.random(VIRTUAL_HEIGHT/2) - self.height
    -- else
    --     self.y = math.random(VIRTUAL_HEIGHT/2, VIRTUAL_HEIGHT) + self.height
    -- end

    -- -- randomize which edge to respawn at
    -- if self.dx > 0 and self.dy > 0 then
    --     if math.random(2) == 1 then
    --         self.y = 0 - self.height
    --     else
    --         self.x = 0 - self.width
    --     end
    -- elseif self.dx > 0 and self.dy < 0 then
    --     if math.random(2) == 1 then
    --         self.y = VIRTUAL_HEIGHT + self.height
    --     else
    --         self.x = 0 - self.width
    --     end
    -- elseif self.dx < 0 and self.dy > 0 then
    --     if math.random(2) == 1 then
    --         self.y = 0 - self.height
    --     else
    --         self.x = VIRTUAL_WIDTH + self.width
    --     end
    -- elseif self.dx < 0 and self.dy < 0 then
    --     if math.random(2) == 1 then
    --         self.y = VIRTUAL_HEIGHT + self.height
    --     else
    --         self.y = VIRTUAL_WIDTH + self.width
    --     end
    -- end
end

function Asteroid:render()
    love.graphics.draw(self.texture, self.x, self.y)
    
    -- love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1, 1)
end