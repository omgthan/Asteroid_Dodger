Player = Class{}

function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = 0
    self.dy = 0

    self.texture = love.graphics.newImage('textures/ship.png')
end

function Player:update(dt)

    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt

    if self.y < 0 or self.y > VIRTUAL_HEIGHT - self.height then
        if self.y < 0 then
            self.y = 0
        elseif self.y >= VIRTUAL_HEIGHT - self.height then
            self.y = VIRTUAL_HEIGHT - self.height
        end
        self.dy = -self.dy * 0.5
        sounds['blip_high']:play()
    end
    if self.x < 0 or self.x > VIRTUAL_WIDTH - self.width then
        if self.x < 0 then
            self.x = 0
        elseif self.x > VIRTUAL_WIDTH - self.width then
            self.x = VIRTUAL_WIDTH - self.width
        end
        self.dx = -self.dx * 0.5
        sounds['blip_high']:play()
    end
end

-- draw player (rectangle for now)
function Player:render()
    
    love.graphics.draw(self.texture, self.x, self.y)

    -- love.graphics.setColor(1, 1, 1, 0.75)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1, 1)
end