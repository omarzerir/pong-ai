Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:collides(box)
    if self.x > box.x + box.width 
    or box.x > self.x + self.width
    or self.y > box.y + box.height
    or box.y > self.y + self.height then
            return false
    end 
    return true
end 

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.y <= 0 then 
        self.dy = -self.dy
        self.y = 0
        sounds['wallhit']:play()
    end
    
    if self.y >= VIRTUAL_HEIGHT-4 then
        self.dy = -self.dy
        self.y = VIRTUAL_HEIGHT-4
        sounds['wallhit']:play()
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end